function plotBandGap(DB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global config

    if nargin <1
        [DB, ~] = DButils.createDB();
    end
        
    [n,m] = size(DB);
    Radius = zeros(length(DB),2);
    for i=1:m
        [BGap(i), Radius(i,:), Volt(i), Mat(i)] = getBandGap(DB(i));
    end
    
    Col = Volt;
    S = 20;
    [cMat,iMat,icMat] = unique(Mat);
    nMat = length(cMat);
        for k=1:nMat
            if cMat(k) ~= 3
            idx = find(Mat == cMat(k));
            figure;
            %sVolt = round(sort(unique(Volt))*100)/100;
            scatter(Radius(idx,1),BGap(idx),S,Col(idx),'filled');
            xlabel('Radius of Quantum Dot in nm');
            ylabel('Band Gap in eV');
            axis([0 max(Radius(:,1)) 0 max(BGap)]);
            hcb = colorbar('Location','SouthOutside','XTickLabel',Volt);
            caxis(hcb,[min(Volt), max(Volt)]);
            xlabel(hcb, 'Voltage in V');
            set(hcb,'XTickMode','manual');
            stitle = DB(idx(1)).mat_name;
            title(stitle,'interpreter','none');
            hold on;
            r = [min(Radius(:,1)):0.01:max(Radius(:,1))];
            plot(r,1./r.^2+0.5,'--b');
            end
        end

        for k=1:nMat
            if cMat(k) == 3
            idx = find(Mat == cMat(k));
            [cVolt,iVolt,icVolt] = unique(Volt(idx));
            for l=1:length(cVolt)
                idxV = find(Volt == cVolt(l));
                if length(idx) > length(idxV)
                    idxV=idxV(ismember(idxV,idx));
                else
                    idxV=idxV(ismember(idxV,idx));
                end
                figure;
                scatter(Radius(idxV,1),Radius(idxV,2),S,BGap(idxV),'filled');
                xlabel('Inner radius of Quantum Dot in nm');
                ylabel('Outer radius of Quantum Dot in nm');
                axis([0 max(Radius(:,1)) 0 max(Radius(:,2))]);
                hcb = colorbar('Location','SouthOutside','XTickLabel',BGap(idxV));
                xlabel(hcb, 'Band Gap in eV');
                set(hcb,'XTickMode','manual');
                stitle = [DB(idxV(1)).mat_name, ', El field = ', num2str(Volt(idxV(l)))];
                title(stitle,'interpreter','none');
            end
            end
        end
end