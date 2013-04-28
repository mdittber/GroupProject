function checkUitInput(CHK, M, pos)
%checkUitInput(CHK, M, pos)
%   Sets a warning in the Progess Info (gui_simulate) if the input is not
%   correct or in a irregular range

    global config
    
    if CHK == 0
        setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - ', M], 2, gui_simulate, 't_progress');
    else
        switch pos(2)
            case 1  % Material
                if M<1 || M>4
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Material index out of range. Aborting Simulation!'], 2, gui_simulate, 't_progress');
                    config.cancelSim = 1;
                end
            case 2  % Geometry
                if M<1 || M>2
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Geometry index out of range. Aborting Simulation!'], 2, gui_simulate, 't_progress');
                    config.cancelSim = 1;
                end
            case 3  % Radius
                maxR = max(M(:,1:2));
                if maxR > 5
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating Radii > 5nm can take a long time!'], 2, gui_simulate, 't_progress');
                end
                if min(M(:,3)) < 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Radius Sweep has to be positive integer. Aborting Simulation!'], 2, gui_simulate, 't_progress');
                    config.cancelSim = 1;
                end
            case 4  % # of Modes
                if M < 4
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating less than 4 modes is not excepted by OMEN. Aborting Simulation!'], 2, gui_simulate, 't_progress');
                    config.cancelSim = 1;
                elseif M > 20
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating more than 20 modes can take a long time!'], 2, gui_simulate, 't_progress');
                end
            case 5  % Voltage
                if min(M(:,3)) < 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Voltage Sweep has to be positive integer. Aborting Simulation!'], 2, gui_simulate, 't_progress');
                    config.cancelSim = 1;
                end
        end
    end
end