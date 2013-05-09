function plotQdotBandGap(Qdots)

    global config;
    [n,m] = size(Qdots)
    
    for i=1:max(n,m)
        if mod(i,6) == 0
            figure()%mod(i,6))
            hold on;
            title('Bandgaps of quantum dots')
        end
        subplot(2,3,mod(i,6))
            load([config.simulations, Qdots(i).path, '/CB_E_0_0.dat']);
            load([config.simulations, Qdots(i).path, '/VB_E_0_0.dat']);
            minCB = min(CB_E_0_0);
            maxVB = max(VB_E_0_0);
            BGhalf= (minCB-maxVB)/2;
            strBGhalf = num2str(BGhalf);
            hold on;
            group = ones(length(CB_E_0_0),1);
            group = [group; zeros(length(VB_E_0_0),1)]
            size([linspace(0,5,length(CB_E_0_0)) linspace(0,5,length(VB_E_0_0))])
            size([CB_E_0_0; VB_E_0_0])
            size(group)
            gscatter([linspace(0,5,length(CB_E_0_0)) linspace(0,5,length(VB_E_0_0))], [CB_E_0_0; VB_E_0_0],group)

            %fill([0 5 5 0], [minCB minCB maxVB maxVB], 'r');
            %text(1, BGhalf, ['Bandgap = ', strBGhalf, 'eV']);

            stitle = ['Bandgap and energy levels of a ', Qdots(i).mat_name, ' quantum dot']
            title(stitle, 'Interpreter', 'none');
            set(gca,'XTickLabel',[]);
            ylabel('Energy in eV');

            legend('CB levels', 'VB levels', 'Bandgap','Location', 'EastOutside');
    end
end