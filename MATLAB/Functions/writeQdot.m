function wQdot = writeQdot(Mpar_row, row)
%wQdot = writeQdot(Mpar_row, row)
%   Writes the Qdots from a parameter set (given by UI table) and passes it
%   to the further simulation procedure: writing Cmd files, starting the
%   OMEN simulation.

    global config;

    %%********************************************************************
    %% Parameters
    %%********************************************************************

    % Selects a Qdot template for every material type and fills in the
    % necessary parameters
    
    % Convert and check the UI table string into a matrix
    [CHK,vMat] = getUitInput(Mpar_row(1));
    checkUitInput(CHK,vMat,[row,1]);
    
    switch vMat(1)
        case 1
            default = Qdot('PbSe_allan');
            
            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            checkUitInput(CHK,vGeo,[row,2]);
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
            
            % Radius            
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            checkUitInput(CHK,vRadius,[row,3]);
            default.geometry(1).radius = vRadius;
            
            
        case 2
            default = Qdot('PbSe_lent');
            
            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            checkUitInput(CHK,vGeo,[row,2]);
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
            
            % Radius
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            checkUitInput(CHK,vRadius,[row,3]);
            default.geometry(1).radius = vRadius;
            
            
        case 3
            default = Qdot('CdS_CdSe');

            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            checkUitInput(CHK,vGeo,[row,2]);
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
            switch vGeo(2)
                case 1
                    default.geometry(2).type = 'sphere';
                case 2
                    default.geometry(2).type = 'quboid';
            end
            
            % Radii
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            checkUitInput(CHK,vRadius,[row,3]);
            default.geometry(1).radius = vRadius(1,:);
            default.geometry(2).radius = vRadius(2,:);
            
            
        case 4
            default = Qdot('ZnSe_CdSe');

            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            checkUitInput(CHK,vGeo,[row,2]);
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
            switch vGeo(2)
                case 1
                    default.geometry(2).type = 'sphere';
                case 2
                    default.geometry(2).type = 'quboid';
            end
            
            % Radii
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            checkUitInput(CHK,vRadius,[row,3]);
            default.geometry(1).radius = vRadius(1,:);
            default.geometry(2).radius = vRadius(2,:);
            
        otherwise
    end
    
    
    % Number of modes for bandstructure calculation
    [CHK,vModes] = getUitInput(Mpar_row(4));
    checkUitInput(CHK,vModes,[row,4]);
    default.n_of_modes = vModes;
    
    
    % Voltage
    [CHK,vVolt] = getUitInput(Mpar_row(5));
    checkUitInput(CHK,vVolt,[row,5]);
    default.NVD        = vVolt(3);			% number of drain voltages Vd=Vdmin:(Vdmax-Vdmin)/(NVD-1):Vdmax
    default.Vdmin      = vVolt(1);			% absolute minimum drain potential
    default.Vdmax      = vVolt(2);			% absolute maximum drain potential
    
    
    %%********************************************************************
    %% TECHNICAL DATA
    %%********************************************************************
    default.user        = config.user;
    default.OMENversion = config.vOMEN;
    default.machine     = config.machine;
    
    
    %%********************************************************************
    %% WRITE CMD FILES AND SIMULATE
    %%********************************************************************
    if config.cancelSim == 0
        wQdot = default;
        simAll(default);
    end
end