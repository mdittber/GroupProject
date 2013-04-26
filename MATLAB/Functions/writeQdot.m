function wQdot = writeQdot(Mpar_row)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %********************************************************************
    % Writes cmd files and simulates with OMEN for different parameters
    %********************************************************************
    
%     Mpar: mat, mat_type, radius1, radius2, nrofmodes, vdmin, vdmax, NVD

    %********************************************************************
    %CREATE AND DEFINE DIRECTORIES
    %********************************************************************

    global config;

    %********************************************************************
    %PARAMETERS MATERIAL 1
    %********************************************************************
    %default = Qdot();

    %********************************************************************
    %Config of multiple values
    %********************************************************************
    % 
    % Parameters with multiple values: enter [start,stop,steps] instead of
    % a single value
    % 
    % Supported Sweep Parameters: radius(1) radius(2) NVD
    % 
    % Note: if radius 1 and 2 are both swept, they must be swept over an equal
    % nr of values! Furthermore  r1 < r2


    %********************************************************************
    %Parameters
    %********************************************************************

    %material_model
    [CHK,vMat] = getUitInput(Mpar_row(1));
    switch vMat(1)
        case 1
            default = Qdot('PbSe_allan');
            
            %GEOMETRY
            
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            default.geometry(1).radius = vRadius;              %radius of circle

            [CHK,vGeo] = getUitInput(Mpar_row(2));
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
        case 2
            default = Qdot('PbSe_lent');
            
            %GEOMETRY
            
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            default.geometry(1).radius = vRadius;              %radius of circle

            [CHK,vGeo] = getUitInput(Mpar_row(2));
            switch vGeo(1)
                case 1
                    default.geometry(1).type = 'sphere';
                case 2
                    default.geometry(1).type = 'quboid';
            end
        case 3
            default = Qdot('CdS_CdSe');
            %GEOMETRY

            [CHK,vRadius]= getUitInput(Mpar_row(3));
            default.geometry(1).radius = vRadius(1,:);              %radius of circle
            default.geometry(2).radius = vRadius(2,:);              %radius of circle
            
            [CHK,vGeo] = getUitInput(Mpar_row(2));
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
        case 4
            default = Qdot('ZnSe_CdSe');
            %GEOMETRY
 
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            default.geometry(1).radius = vRadius(1,:);              %radius of circle
            default.geometry(2).radius = vRadius(2,:);              %radius of circle
            
            [CHK,vGeo] = getUitInput(Mpar_row(2));
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
    end

    default.n_of_modes = str2double(Mpar_row(4));          %number of modes for bandstructure calculation
   
    [CHK,vVolt] = getUitInput(Mpar_row(5));
    default.NVD        = vVolt(3);				%number of drain voltages Vd=Vdmin:(Vdmax-Vdmin)/(NVD-1):Vdmax
    default.Vdmin      = vVolt(1);				%absolute minimum drain potential
    default.Vdmax      = vVolt(2);				%absolute maximum drain pote
    
    %********************************************************************
    %TECHNICAL DATA
    %********************************************************************
    default.user        = config.user;
    default.OMENversion = config.vOMEN;
    default.machine     = config.machine;
    
    %********************************************************************
    %WRITE CMD FILES AND SIMULATE FOR MATERIAL 1
    %********************************************************************

    wQdot = default;
    DBpart1 = simAll(default);

end

