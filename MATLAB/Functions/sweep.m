function dots = sweep(def_dot)

% Takes a default qdot object with scalar sweep parameters 
% entered in the form [min,max,steps].
% returns array of qdots with all parameter combinations
% supportes sweep parameters: radius(1), radius(2), Voltage
%********************************************************************

    
    nMat = def_dot.no_mat;

    p1 = sweepAndLockRadii(def_dot);
    
	
    voltage = [def_dot.Vdmin, def_dot.Vdmax, def_dot.NVD];
    p2 = paramSweep( voltage );
    
    
% CREATE PERMUTATION MATRIX with all parameter combinations
% collumn i of permMatrix contains parameters for qdot(i)
    
    permMatrix = zeros( rows(p1)+rows(p2), cols(p1)*cols(p2) );
    
	% Assign values to the permutation matrix 
    
	l = 1;
    for i = 1:cols(p1)
        for k = 1:cols(p2)
        permMatrix(:,l) = [ p1(:,i); p2(:,k)];
        l=l+1;
        end
    end
    
    N = cols(permMatrix); %Number of permutations
   
    dots( N ) = Qdot; %initialize N qdots
    
% ASSIGN VALUES TO NEW QDOTS
    
    for i = 1:N
        dots(i) = def_dot;
        j = 1;
        
        % fill in the radii
        for k = 1:nMat
            dots(i).geometry(k).radius = permMatrix(k,i);
            j=k+1;
        end

        %fill in the voltages
        dots(i).NVD = 1;
        dots(i).Vdmax = permMatrix(j,i);
        dots(i).Vdmin = permMatrix(j,i);
        
    end
end

%%
% SUBFUNCTIONS
%********************************************************************

function p = paramSweep(a)
% create all parameter values using linspace

    if(cols(a) == 3)
        p = linspace(a(1),a(2),a(3));
    elseif(cols(a) ==1)
% do not use linspace if only single value
        p=a;
    else
% only acceptable input: scalar or vector of length 3
        warning('radius1: incorrect values');
        p=a(1);
    end
end


function p12 = lock(a1,a2)
% lock two parameters: they will not be permutated later

    if cols(a1) ~= cols(a2)
        if cols(a1) == 1
            a1 = a1 * ones(1,cols(a2));
        elseif cols(a2) ==1
            a2 = a2 * ones(1,cols(a1));
        else
            warning(['dimensions of lock parameters do not match. \n' ...
                            'they will be reset to their first value']);
            a1 = a1(1);
            a2 = a2(1);
        end
    end
    p12 = [a1;a2];
end

function radiiMatrix = sweepAndLockRadii(def_dot)
%sweep each radius and lock it with the radii from the qdot. 

    nMat = def_dot.no_mat;
    
    radiiMatrix = paramSweep( def_dot.geometry(1).radius );
    
    for i = 2:nMat
        r = paramSweep( def_dot.geometry(i).radius );     
        radiiMatrix = lock( radiiMatrix , r);
    end
	
end


function n = cols(mat)
% returns number of collums in a 2x2 matrix
    [~,n] = size(mat);
end

function m = rows(mat)
% returns number of rows in a 2x2 matrix
    [m,~] = size(mat);
end


