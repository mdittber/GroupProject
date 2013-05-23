function Nerror = checkUitInput(CHK, M, pos, Nerror)
%Nerror = checkUitInput(CHK, M, pos, Nerror)
%   Sets a warning in the Progess Info (gui_simulate) if the input is not
%   correct or in a irregular range

    if CHK == 0
        setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - ', M], 2, gui_simulate, 't_progress');
        Nerror = Nerror + 1;
    else
        switch pos(2)
            case 1  % Material
                if M<1 || M>5
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Material index out of range!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
            case 2  % Geometry
                if min(M)<1 || max(M)>1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Geometry index out of range!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
            case 3  % Radius
                maxR = max(M(:,1:2));
                if maxR > 5
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating Radii > 5nm can take a long time!'], 2, gui_simulate, 't_progress');
                end
                if min(M(:,3)) < 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Radius Sweep has to be positive integer!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
            case 4  % # of Modes
                if M < 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating less than 1 mode is not possible!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                elseif M > 20
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Simulating more than 20 modes can take a long time!'], 2, gui_simulate, 't_progress');
                end
            case 5  % Voltage
                if min(M(:,3)) < 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Voltage Sweep has to be positive integer!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
            case 6 % Permutation
                if length(M) > 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Permutation mode cannot be a vector/matrix!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
                if M < 0 || M > 1
                    setProgressInfo(['Cell(', num2str(pos(1)), ',', num2str(pos(2)), ') - Only permutation mode 0 or 1 possible!'], 2, gui_simulate, 't_progress');
                    Nerror = Nerror + 1;
                end
        end
    end
end