function plotEVsAlongAxis(dots, pName, startPoint, direction)
    % plot the EVs of multiple Qdots along specified line

    % get EVs and param values for pName
    
    
%     N=length(dots);
%     EV = cell(N,1);
%     pValue = zeros(N,1);
%     for i=1:N
%         EV{i} = load( [dots(i).path, '/VB_V_0_0.dat'] );
%         pValue(i) = eval( sprintf('dots(%i).%s',i,pName) ); 
%     end
    
    NN=2;
    
    a = 'ID20130429-1213-34315_CdS_CdSe';
    b = 'ID20130426-1803-05541_PbSe_allan';
    
%     dots(1) = load( ['Simulations/' a '/qdotObj.mat'] );
%     dots(2) = load( ['Simulations/' b '/qdotObj.mat'] );

    
    EV{1} = load( ['Simulations/' a '/VB_V_0_0.dat'] );
    EV{2} = load( ['Simulations/' b '/VB_V_0_0.dat'] );
    
    LayerMatrix{1} = load( ['Simulations/' a '/Layer_Matrix.dat'] );
    LayerMatrix{2} = load( ['Simulations/' b '/Layer_Matrix.dat'] );

    psi2 = cell(1,NN);
    selAtomInd = cell(1,NN);
    scale = cell(1,NN);
    
    
    
    
    % set different tolerances for different directions        
    ndir = direction/norm(direction);
    
    if isequal(ndir, [1 0 0]) || isequal(ndir, [0 1 0]) || isequal(ndir, [0 0 1]) 
        tol = 0.01;
    else
        tol = 0.2;
    end
    
    
    %get indices and scale for atoms on specified line
    
    for k =1:NN
        %calc nr of orbitals
        [NAtom,~] = size(LayerMatrix{k});            
        [n,~]  = size( EV{k} );
        NOrb = n/NAtom; %nr of orbitals
        
        %calc psi2
        psi2{k} = EV2psi( EV{k}, NOrb, 1);
        
        %get 
        [selAtomInd{k}, scale{k}] = atomsOnAxis(LayerMatrix{k}, startPoint, direction, tol);

    end
    
    subset = cell(1,NN); 
    
    for k = 1:NN
        subset{k} = psi2{k}(selAtomInd{k}); % psi2 for atoms on line
        
        highlightAtoms(LayerMatrix{k}, selAtomInd{k}, startPoint, direction, 100+k); %plot atoms and line
        
    end
    
    plotNormal(subset, 'mat', [1,2], scale, 3); % plot wavefn's along spec line

end


%********************************************************************************
% SUBFUNCTIONS
%********************************************************************************

function highlightAtoms(grid, atoms, startPoint, direction, plotid)
    % highlights atoms (containing indices of grid) in grid
    % optional plotting of a line
    
    [NAll,~] = size(grid);    
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
    
    t = [-1,1];
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
    
    if nargin < 4 %set default scale (uniform spacing)
        for k = 1:N
            m = length( values{k} )
            x{1,k}= linspace(0,1,m);
        end
        
    else
        x = cellfun(@(a) (a-a(1))/ abs(a(end)-a(1)), scales, 'UniformOutput', 0); %normalise scale    
    end
    
    allStyles = {'-k','-r','-g','-b','-c',':k',':r',':g',':b',':c','--k','--r','--g','--b','--c'};
    style = allStyles(1:N);
    labels = arrayfun( @(b) sprintf('%s = %g',pName,b), pValue, 'UniformOutput', false);

    figure(plotid);
    hold on;
    h = cellfun(@(x,y,st) plot(x,y,st), x, values, style);
    legend(h,labels);
end    