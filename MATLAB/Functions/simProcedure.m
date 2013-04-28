function simProcedure(Mpar_raw)
%simProcedure(Mpar_raw)
%   Gets the raw data cell array from the GUI table
%   checks if all entries are valid and reformats the
%   data that can be used to generate OMEN CMD files

    global config;
    
    %% Delete empty rows from the UI table
    Mpar = delEmptyRows(Mpar_raw);
    [n,m] = size(Mpar);
    
    %% Check for invalid entries
    if n==0
        setProgressInfo('No entries to start the simulation', 2, gui_simulate, 't_progress')
    else
        for i=1:n
            %% Write data from UI table into Qdot objects and write Cmd files
            setProgressInfo(['(', int2str(i), '/', int2str(n), ') Creating OMEN Cmd file(s).'], 1, gui_simulate, 't_progress')
            writeQdot(Mpar(i,:),i)
            
            %% Stop iterations when Cancel Simulation Button was hit
            if config.cancelSim == 1
                break;
            end
            
            setProgressInfo(['(', int2str(i), '/', int2str(n), ') Simulation succesful!'], 1, gui_simulate, 't_progress')
        end
    end
    
    if config.cancelSim == 0
        setProgressInfo('Simulation Procedure done!', 1, gui_simulate, 't_progress')
        setProgressInfo('hline', 0, gui_simulate, 't_progress')
    else
    
    %% Clean up Simulations folder if simulations failed
    
    % # Simualations failed OR all Simulations ran successfully
    setProgressInfo('Simulation FAILED!', 1, gui_simulate, 't_progress')
    setProgressInfo('hline', 0, gui_simulate, 't_progress')
    end
    config.cancelSim = 0;
end