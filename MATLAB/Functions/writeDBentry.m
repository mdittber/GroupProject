function writeDBentry(paramSet)
%writeDBentry(paramSet)
%   Generates Idenifier for the Simulation values set.
%   Writing parameter values to DB and LookUp table

    % Generate identifier and directories
    ID    = ['ID' getTimeDate(4)];
    year  = ID(3:6);
    month = ID(7:8);
    day   = ID(9:10);
    hour  = ID(11:12);
    minute= ID(13:14);
    sec   = ID(15:16);
    
    global config
    config.root;
    
    dir = [config.root, 'simulations\', ID];
    mkdir(dir);
    
    % Create LookUp table entry
    dirLU = [config.system, 'LookUp.mat'];
    if exist(dirLU, 'file') == 0
        n = 0;
    else
        load(dirLU);
        [n,m] = size(LookUp);
    end
        LookUp(n+1,1) = paramSet(1);         % material
        LookUp(n+1,2) = paramSet(2);         % geometry
        LookUp(n+1,3) = paramSet(3);         % inner radius
        LookUp(n+1,4) = paramSet(4);         % outer radius
        LookUp(n+1,5) = paramSet(5);         % # of modes
        LookUp(n+1,6) = paramSet(6);         % Vdmin
        LookUp(n+1,7) = paramSet(7);         % Vdmax
        LookUp(n+1,8) = paramSet(8);         % Vd sweep
        LookUp(n+1,9) = {year};              % year
        LookUp(n+1,10)= {month};             % month
        LookUp(n+1,11)= {day};               % day
        LookUp(n+1,12)= {hour};              % hour
        LookUp(n+1,13)= {minute};            % minute
        LookUp(n+1,14)= {sec};               % second
        LookUp(n+1,15)= {config.vOMEN};      % OMEN version
        LookUp(n+1,16)= {ID};                % identifier
        LookUp(n+1,17)= {config.user};       % user
        LookUp(n+1,18)= {config.machine};    % machine
        LookUp(n+1,19)= {dir};               % path
    save(dirLU, 'LookUp');

end