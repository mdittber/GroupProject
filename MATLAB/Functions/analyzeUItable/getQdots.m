function Msim = getQdots(Mpar)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    [n,m] = size(Mpar);

    Mpar = cell(n,m);
        for i=1:n
            % Materials
            switch str2double(Mpar_raw(i,1))
                case 1
                    Mpar(i,1) = cellstr('PbSe_allan');
                case 2
                    Mpar(i,1) = cellstr('PbSe_lent');
                case 3
                    Mpar(i,1) = cellstr('CdS_CdSe');
                case 4
                    Mpar(i,1) = cellstr('ZnSe_CdSe');
            end

            % Geometry
            switch str2double(Mpar_raw(i,2))
                case 1
                    Mpar(i,2) = cellstr('sphere');
                case 2
                    Mpar(i,2) = cellstr('quboid');
            end
        end
        
        for i=1:n
            for j=3:m
                Mpar(i,j) = Mpar_raw(i,j);
            end
        end
        



end