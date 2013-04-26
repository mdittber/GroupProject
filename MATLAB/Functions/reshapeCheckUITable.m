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

    global config;
    Mpar = delEmptyRows(Mpar_raw);
    [n,m] = size(Mpar);
    
    %% Check for invalid entries
    if n==0
        disp('No parameters to start the simulation')
    else
        
        for i=1:n
            if config.cancelSim == 1
                break;
            end
            setProgressInfo(['(', int2str(i), '/', int2str(n), ')', 'Creating OMEN Cmd file...'], gui_simulate, 't_progress')
            writeQdot(Mpar(i,:))
            setProgressInfo(['(', int2str(i), '/', int2str(n), ')', 'OMEN Cmd file available!'], gui_simulate, 't_progress')
        end
        config.cancelSim = 0;
    
    %% Reshape for Cmd files    
    %setProgessInfo('   Starting OMEN calculations...', gui_simulate, 't_progress')
    
    end
    
    setProgressInfo('Writing DB entries', gui_simulate, 't_progress')
    setProgressInfo('Writing DB entries done!', gui_simulate, 't_progress')
    
    setProgressInfo('Simulation Procedure done!', gui_simulate, 't_progress')
    setProgressInfo('hline', gui_simulate, 't_progress')
end

