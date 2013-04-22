function [DB] = checkUItable(Mpar_raw)
%Mpar = reshapeCheckUITable(Mpar_raw)
%   Gets the raw data cell array from the GUI table
%   checks if all entries are valid and reformats the
%   data that can be used to generate OMEN CMD files
%
%   INPUT:  raw data cell array from the GUI table
%   OUTPUT: Reshaped cell array containing OMEN compatilbe
%           parameters. All cell entries are strings in
%           the following order:
%
%           1. Column: Material
%           2. Column: Type of material (Geometry)
%           3. Column: Inner radius
%           4. Column: Outer radius
%           5. Column: # of modes
%           6. Column: Vdmin
%           7. Column: Vdmax
%           8. Column: Vd Sweep


    setProgessInfo('   Reshaping Parameters...', gui_simulate, 't_progress')
    Tmp = cell2mat(Mpar_raw);
    [n,m] = size(Tmp);
    
    %% Check for invalid entries
    if n==0
        disp('No parameters to start the simulation')
    else
    
    %% Reshape for Cmd files
    
        Mpar = cell(n,m);
        for i=1:n
            % Materials
            switch Tmp(i,1)
                case 1
                    Mpar(i,1) = cellstr('PbSe_allan');
                case 2
                    Mpar(i,1) = cellstr('PbSe_lent');
                case 3
                    Mpar(i,1) = cellstr('CdS_CdSe');
                case 4
                    Mpar(i,1) = cellstr('ZnSe_CdSe');
            end

            % Geometry
            switch Tmp(i,2)
                case 1
                    Mpar(i,2) = cellstr('sphere');
                case 2
                    Mpar(i,2) = cellstr('quboid');
            end
        end
        
        for i=1:n
            for j=3:m
                Mpar(i,j) = num2cell(Tmp(i,j));
            end
        end

    end
    
    
    setProgessInfo('...Reshaping Parameters done!', gui_simulate, 't_progress')
    
end

