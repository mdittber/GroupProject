function startSimulation(Mpar)
%startSimulation(Mpar)
%   Starts the Simulation process using OMEN
%
%   INPUT: Mpar is an cell array containing
%          OMEN parametes as strings
%
%           1. Column: Material
%           2. Column: Type of material (Geometry)
%           3. Column: Inner radius
%           4. Column: Outer radius
%           5. Column: # of modes
%           6. Column: Vdmin
%           7. Column: Vdmax
%           8. Column: Vd Sweep

    global config
    dirMpar = [config.system, 'Mpar.mat'];
    save(dirMpar,'Mpar');
    [n,m] = size(Mpar);
    for i=1:n
        writeDBentry(Mpar(i,:));
    end
    
    setProgessInfo('   Creating OMEN Cmd files...', gui_simulate, 't_progress')
    setProgessInfo('...OMEN Cmd files available!', gui_simulate, 't_progress')
    
    setProgessInfo('   Starting OMEN calculations...', gui_simulate, 't_progress')
    setProgessInfo('...OMEN calculations done!', gui_simulate, 't_progress')
    
    setProgessInfo('###...Simulation Procedure done!', gui_simulate, 't_progress')
end

