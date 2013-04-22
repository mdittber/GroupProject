function Mpar = reshapeCheckUITable(Mpar_raw)
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
%           3. Column: [Inner radius 1, Outer radius 1, ...]
%           4. Column: # of modes
%           5. Column: [Vdmin, Vdmax, Vd Sweep]

    setProgessInfo('   Reshaping Parameters...', gui_simulate, 't_progress')
    Mpar = delEmptyRows(Mpar_raw)
    [n,m] = size(Mpar)
    
    %% Check for invalid entries
    if n==0
        disp('No parameters to start the simulation')
    else
        
        for i=1:n
            writeQdot(Mpar(i,:))
        end    
    
    %% Reshape for Cmd files
    
        

    end
    
    
    setProgessInfo('...Reshaping Parameters done!', gui_simulate, 't_progress')
    
end

