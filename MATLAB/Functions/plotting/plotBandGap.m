function plotBandGap(DB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global config

    if nargin <1
        [DB, ~] = DButils.createDB();
    end
        
    [n,m] = size(DB);
    for i=1:m
        [BGap(i), Radius(i,:), Volt(i), Mat(i)] = getBandGap(DB(i));
    end
    
    assignin('base','volt',Volt)
    assignin('base','bgap',BGap)
    assignin('base','rad',Radius(:,1))
    Mat
    
    figure;
    hold on;
    [n,m] = size(Radius);
    if m == 1
        Col = Volt/1;%max(Volt)
        S = 2*50*Mat;
        sVolt = round(sort(unique(Volt))*100)/100;
        sh = scatter(Radius(:,1),BGap,S,Col);
        xlabel('Radius of Quantum Dot in nm');
        ylabel('Band Gap in eV');
        hcb = colorbar('Location','SouthOutside','XTickLabel',sVolt);
        xlabel(hcb, 'Voltage in V');
        set(hcb,'XTickMode','manual');
        
        %% TO DO different circle sizes
    else
        %% TO DO: Only for one Voltage!!!
        Col = BGap/max(BGap);
        S = 25*Mat;
        scatter3(Radius(:,1),Radius(:,2),BGap,S,Col);
        xlabel('Inner radius of Quantum Dot in nm');
        ylabel('Outer radius of Quantum Dot in nm');
        hcb = colorbar('Location','SouthOutside','XTickLabel',{'Band Gap in eV'; Col});
        set(hcb,'XTickMode','manual');
    end

    r = [min(Radius(:,1)):0.01:max(Radius(:,1))]
    plot(r,1./r.^2+0.5)
% 
%         title('Bandgap and energy levels of a XYZ quantum dot');
%         %set(gca,'XTickLabel',[]);
%         %xlabel('x-axis');
%         ylabel('Energy in eV');
%         %zlabel('z-axis');
% 
%         legend('CB levels', 'VB levels', 'Bandgap','Location', 'EastOutside');
end