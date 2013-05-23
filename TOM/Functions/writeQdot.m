function [QDO, Nerror] = writeQdot(Mpar_row, row)
%[QDO, Nerror] = writeQdot(Mpar_row, row)
%   Writes the QDO from a parameter set (given by UI table)

    Nerror = 0;

    %%********************************************************************
    %% Parameters
    %%********************************************************************

    % Selects a Qdot template for every material type and fills in the
    % necessary parameters
    
    % Convert and check the UI table string into a matrix
    [CHK,vMat] = getUitInput(Mpar_row(1));
    Nerror = checkUitInput(CHK,vMat,[row,1],Nerror);
    
    switch vMat(1)
        case 1
            QDO = Qdot('PbSe_allan');
            
            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            Nerror = checkUitInput(CHK,vGeo,[row,2],Nerror);
            switch vGeo(1)
                case 1
                    QDO.geometry(1).type = 'sphere';
                case 2
                    QDO.geometry(1).type = 'quboid';
            end
            
            % Radius            
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            Nerror = checkUitInput(CHK,vRadius,[row,3],Nerror);
            QDO.geometry(1).radius = vRadius;
            
            
        case 2
            QDO = Qdot('PbSe_lent');
            
            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            Nerror = checkUitInput(CHK,vGeo,[row,2],Nerror);
            switch vGeo(1)
                case 1
                    QDO.geometry(1).type = 'sphere';
                case 2
                    QDO.geometry(1).type = 'quboid';
            end
            
            % Radius
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            Nerror = checkUitInput(CHK,vRadius,[row,3],Nerror);
            QDO.geometry(1).radius = vRadius;
            
            
        case 3
            QDO = Qdot('CdS_CdSe');

            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            Nerror = checkUitInput(CHK,vGeo,[row,2],Nerror);
            switch vGeo(1)
                case 1
                    QDO.geometry(1).type = 'sphere';
                case 2
                    QDO.geometry(1).type = 'quboid';
            end
            switch vGeo(2)
                case 1
                    QDO.geometry(2).type = 'sphere';
                case 2
                    QDO.geometry(2).type = 'quboid';
            end
            
            % Radii
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            Nerror = checkUitInput(CHK,vRadius,[row,3],Nerror);
            QDO.geometry(1).radius = vRadius(1,:);
            QDO.geometry(2).radius = vRadius(2,:);
            
            
        case 4
            QDO = Qdot('ZnSe_CdSe');

            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            Nerror = checkUitInput(CHK,vGeo,[row,2],Nerror);
            switch vGeo(1)
                case 1
                    QDO.geometry(1).type = 'sphere';
                case 2
                    QDO.geometry(1).type = 'quboid';
            end
            switch vGeo(2)
                case 1
                    QDO.geometry(2).type = 'sphere';
                case 2
                    QDO.geometry(2).type = 'quboid';
            end
            
            % Radii
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            Nerror = checkUitInput(CHK,vRadius,[row,3],Nerror);
            QDO.geometry(1).radius = vRadius(1,:);
            QDO.geometry(2).radius = vRadius(2,:);
            
        case 5
            QDO = Qdot('PbS_lent');
            
            % Geometry
            [CHK,vGeo] = getUitInput(Mpar_row(2));
            Nerror = checkUitInput(CHK,vGeo,[row,2]);
            switch vGeo(1)
                case 1
                    QDO.geometry(1).type = 'sphere';
                case 2
                    QDO.geometry(1).type = 'quboid';
            end
            
            % Radius
            [CHK,vRadius]= getUitInput(Mpar_row(3));
            Nerror = checkUitInput(CHK,vRadius,[row,3],Nerror);
            QDO.geometry(1).radius = vRadius;
            
        otherwise
    end
    
    
    % Number of modes for bandstructure calculation
    [CHK,vModes] = getUitInput(Mpar_row(4));
    Nerror = checkUitInput(CHK,vModes,[row,4],Nerror);
    QDO.n_of_modes = vModes;
    
    
    % Voltage
    [CHK,vVolt] = getUitInput(Mpar_row(5));
    Nerror = checkUitInput(CHK,vVolt,[row,5],Nerror);
%     QDO.NVD        = vVolt(3);			% number of drain voltages Vd=Vdmin:(Vdmax-Vdmin)/(NVD-1):Vdmax
%     QDO.Vdmin      = vVolt(1);			% absolute minimum drain potential
%     QDO.Vdmax      = vVolt(2);			% absolute maximum drain potential
    
    QDO.Efield = [vVolt(1), vVolt(2), vVolt(3)];
    
    % Permutation
    [CHK,vPermutate] = getUitInput(Mpar_row(6));
    Nerror = checkUitInput(CHK,vPermutate,[row,6],Nerror);
    QDO.permutateRadii = logical(vPermutate);
end