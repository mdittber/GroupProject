function plotEVAlongAxis(dots, pName, startPoint, direction, plotGrid, tolerance, NMod)
    % plot the EVs of multiple Qdots along specified line.
    % pName is the for the plot relevant Qdot property.
    % set plotGrid = [indices] OR 'all' for visualisation of Qdot and specified line. 
    % tolerance in %/100 of a0. (for latticetype 'zincblende': will be /2)
    
    Ndots = length(dots); 
    pValue = cell(1,Ndots);
    LayerMatrix = cell(1,Ndots);
    EV = cell(1,Ndots);
    tol = zeros(Ndots,1);
    psi2 = cell(1,Ndots);
    selAtomInd = cell(1,Ndots);
    scale = cell(1,Ndots);
    subset = cell(1,Ndots); 

% get EVs and param values for pName
    
    for k =1:Ndots
        %     simPath = [config.Simulations, qdotObj.path];
        simPath = sprintf('Simulations/ID%s_%s/', dots(k).timestamp, dots(k).mat_name);

        LayerMatrix{k} = load([simPath, 'Layer_Matrix.dat']);
%         CB_V = load([simPath, 'CB_V_0_0.dat']);
        
        EV{k} = load([simPath, 'VB_V_0_0.dat']);
        
        pValue{1,k} = eval( sprintf('dots(%i).%s',k,pName) );
        
        tol(k) = dots(k).a0 * tolerance;
        if strcmp(dots(k).lattice_type, 'zincblende')
            tol(k) = tol(k)/2;
        end
    end
        
% get indices and scale for atoms on specified line
    
    for k =1:Ndots
        %calc nr of orbitals
        [NAtom,~] = size(LayerMatrix{k});            
        [n,~]  = size( EV{k} );
        NOrb = n/NAtom; %nr of orbitals
        
        %calc psi2
        psi2{k} = EV2psi( EV{k}, NOrb, NMod);
        
        %get atoms on line
        [selAtomInd{k}, scale{k}] = atomsOnAxis(LayerMatrix{k}, startPoint, direction, tol(k));
        
        %print warning if few atoms on line
        if length(selAtomInd{k})<8
            warning('ID %i: Less than 8 atoms on line! Set plotGrid = true to check the line',k);
        end

    end
    
% plot atoms and line if selected in plotGrid
    if isequal(plotGrid, 'all')
        plotGrid = 1:Ndots;
    elseif isequal(plotGrid, 0)
        plotGrid = [];
    end
    
    for k = plotGrid
        plotID = 10+k;
        figure(plotID);
        title( sprintf('ID %i', k) );
        highlightAtoms(LayerMatrix{k}, selAtomInd{k}, startPoint, direction, plotID); %plot atoms and line    
    end
    
% plot wavefn's for each dot and mode
    for i = 1:NMod
        for k = 1:Ndots
            subset{k} = psi2{k}(selAtomInd{k},i); % psi2 for atoms on line for dot k and mode i
        end
        plotNormal(subset, pName, pValue, scale, i);
    end
end


%********************************************************************************
% SUBFUNCTIONS
%********************************************************************************

function highlightAtoms(grid, atoms, startPoint, direction, plotid)
    % highlights atoms (containing indices of grid) in grid
    % optional plotting of a line
    
    [NAll,~] = size(grid);    
    direction = direction/norm(direction);
    
    figure(plotid); 
    hold on
    
%plot all atoms in grid
    for k =1:NAll
        plot3(grid(k,1), grid(k,2), grid(k,3), 'ko')
    end
    
%plot only hitAtoms
    for k =1:length(atoms)
        plot3(grid(atoms(k),1), grid(atoms(k),2), grid(atoms(k),3), 'r*')
    end
        
    t = [-1,1] * max(max(grid(:,1:3)));
    line = startPoint'*[1,1] + direction'*t;

    plot3(line(1,:), line(2,:), line(3,:), 'b-')

    xlabel('x')
    ylabel('y')
    zlabel('z')
end



function [sortedIndices, scale] = atomsOnAxis(LayerMatrix, startPoint, direction, tol)
    % returns indices (of LayerMatrix) for atoms on specified line, and scale: projection on axis 
    % line = startpoint + t*direction.
    % tol: how close to the line can the atoms be.

    indices = [];
    proj = [];
    [N,~] = size( LayerMatrix );           
    atomGrid = LayerMatrix(:,1:3); % coordinates of all atoms
    direction = direction/norm(direction); %normalize
    distance = @(a,n,p) norm( (a-p) - ((a-p)'*n)*n ); % distance point to line. n normalised!

%set default values for tol and startPoint
    if nargin < 4
        tol = 0.1;
    end
    if nargin < 3
        startPoint = [0,0,0];
    end

% extract indices of atoms close to specified line
    for i = 1:N
        if distance(startPoint', direction', atomGrid(i,:)') < tol 
            indices(end+1,1) = i;
            proj(end+1,1) = dot(direction, atomGrid(i,:))/norm(direction); %projection on line
        end
    end
    
% sort indices along axis (using projection on axis) 
    sorted = sortrows([indices, proj],2); %sort (dist)
    
    sortedIndices = sorted(:,1);
    scale = sorted(:,2);    
end



function plotNormal(values, pName, pValue, scales, plotid)
    % plot and label multiple curves on normalized x-axis (0 to 1).
    % values: cell array (1,N) containing arrays of the values to be
    % plotted
    % pName: Name of the parameter which distinguishes the
    % different curves
    % pValue: array of parameter Value for different curves
    % optional scale. default: aequidistant values
    
    N = length(values);

% set scales
    if nargin < 4 %set default scale (uniform spacing)
        for k = 1:N
            m = length( values{k} );
            x{1,k}= linspace(0,1,m);
        end
        
    else
        x = cellfun(@(a) (a-a(1))/ abs(a(end)-a(1)), scales, 'UniformOutput', 0); %normalise scale    
    end
    
% styles and labels
    allStyles = {'-k','-r','-g','-b','-c',':k',':r',':g',':b',':c','--k','--r','--g','--b','--c'};
    style = allStyles(1:N);
    IDs = num2cell(1:N);
    labels = cellfun( @(a,b) sprintf('ID %i: %s', a, mat2str(b)), IDs, pValue, 'UniformOutput', false);

    figure(plotid);
    title( sprintf('Parameter: %s', pName), 'Interpreter', 'none');
    hold on;

% plot    
    h = cellfun(@(x,y,st) plot(x,y,st), x, values, style);
    legend(h,labels, 'Interpreter', 'none');
end    