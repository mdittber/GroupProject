function [dots, simSuccess] = simAll(def_dot)

% CREATE OMEN CMD FILE FOR EVERY PARAMETER COMBINATION
% PERFORMS OMEN SIMULATION FOR ALL CMD FILES
%
% returns cell matrix with entries for DB
%
% creates a folder for each simulation, containing:
% Simulation Data created by OMEN
% Cmd File
% Logfile with console output of OMEN simulation
% qdot object containing the parameters
%********************************************************************
        
% PERFORM SWEEP
%********************************************************************
		    
    dots = sweep(def_dot); %create array of qdots with all parameters
    N = length(dots);

    
% DEFINITIONS
%********************************************************************
	global config;
    
    cd(config.simulations);
    
    simSuccess = zeros(N,1); %each element changed to 1 if corresponding simulation is successfull
    
    mat = def_dot.mat_name; %matrial
    
    status = (-1)*ones(N,1); %status of each simulation. returned zero if sucessful
    
    consoleOut = cell(N,1); %console output for each sim will be saved here
    
    simTimestamp = cell(N,1); %Timestamp for each simulation
    logTimestamp = getTimeDate(5); %Timestamp for all simulations
    

% WRITE CMD FILE AND SIMULATE 
%********************************************************************

    t1 = tic; %measure time of all simulations

    for i = 1:N
		
        %print message
        fprintf(1, '\nSTART SIMULATION %i \n',i);
        
        %timestamp for this simulation
        simTimestamp{i} = getTimeDate(5);
	
    % CREATE AND CHANGE DIR
		
        SIMDIR = sprintf('ID%s_%s', simTimestamp{i}, mat);
        mkdir(SIMDIR);
        cd(SIMDIR);
        
	% SAVE QDOT
        
        dots(i).timestamp = simTimestamp{i};
        
        QDOTNAME = 'qdotObj';  %name of mat-file in which the current qdot is saved
        qdotObj = dots(i);
        qdotObj.timestamp = simTimestamp{i};
        qdotObj.path      = SIMDIR;
        
        save( QDOTNAME, 'qdotObj');
        
	% WRITE CMD FILE
            
        CMDFILENAME = 'qdot_cmd'; 
        
        writeCmdFile(dots(i), CMDFILENAME,  simTimestamp{i} ); %write the cmdfiles
			
	% SIMULATE WITH OMEN
        
        t2 = tic;   %measure time of single simulation
        
        UNIXCOMMAND = [config.OMEN, ' ', CMDFILENAME]; %create command string
        [status(i), consoleOut{i}] = unix( UNIXCOMMAND, '-echo') ; %execute

        singleTime = toc(t2);
		
		simSuccess(i) = checkSuccess( status(i), SIMDIR, consoleOut{i} );
		
	%WRITE LOGFILE OF THIS SIMULATIONS

        simlogFile = ['simlog_' simTimestamp{i} '.txt'];
        simlogfid = fopen(simlogFile, 'w');

        if  simSuccess(i) == 1  %simulation successful 
            fprintf(simlogfid, 'Simulation SUCCESSFUL.\n');
            fprintf(1, '\nEND OF SIMULATION %i: SUCCESSFUL.\n', i);
        else
            fprintf(simlogfid, 'Simulation FAILED.\n');
            fprintf(1, '\nEND OF SIMULATION %i: FAILED.\n',i);
        end

        fprintf(simlogfid, 'elapsed time %f \n\nConsole output for simulation: %s \n\n' , singleTime, simTimestamp{i});
        fwrite(simlogfid, consoleOut{i});
        fclose(simlogfid);
        
		cd ..;
        
    end
    
    totalTime = toc(t1);
    

    
% WRITE LOGFILE OF ALL SIMULATIONS
%********************************************************************
    
    LOGDIR = ['log'];
    
    if exist( LOGDIR , 'dir' ) ==0
        mkdir(LOGDIR);
    end
    
    cd(LOGDIR);

    LOGNAME = ['log_' logTimestamp '_' mat '.txt'];
    logfid = fopen(LOGNAME,'w');

    fprintf(logfid, 'Simulation %s %s \nTotal time: %f sec.\n\n',logTimestamp, mat, totalTime);

    %Check for failed simulations
    
    if( sum( simSuccess == 0 ) )
        failed = find( simSuccess == 0 );
        fprintf(logfid, 'Attempt to simulate %i qdots. \n', N);
        fprintf(logfid, 'Simulation failed for indices %s \n\n', sprintf('%d, ',failed));
        setProgressInfo('Some simulations FAILED!', 2, gui_simulate, 't_progress');
    else 
        fprintf(logfid, 'All %i simulations terminated normally! \n\n', N);
    end
    
    fprintf(logfid, 'CONSOLE OUTPUT OF EVERY SIMULATION: \n\n');
    for i =1:N
        fprintf(logfid, 'SIMULATION %s :\n\n%s \n\n-------------------- \n\n', simTimestamp{i}, consoleOut{i});
    end
    
    fclose(logfid);
    
    cd ..;


end


function check = checkSuccess(status, dir, consoleOut)

% check if the OMEN simulation was successful, returns 1 or 0
% consoleOut: console output of OMEN
% status: status returned by unix function
% check status and if LayerMatrix is created.

	if (status == 0) && ( exist( [dir '/VB_V_0_0.dat'], 'file') ~= 0 )
		check = 1;
	else
		check = 0;
    end

end