minCB = min(CB_E_0_0);
maxVB = max(VB_E_0_0);
BGhalf= (minCB-maxVB)/2;
strBGhalf = num2str(BGhalf);

hold on;
for i=1:length(CB_E_0_0)
    plot([0 5], [CB_E_0_0(i) CB_E_0_0(i)],'-g')
end
for i=1:length(VB_E_0_0)
    plot([0 5], [VB_E_0_0(i) VB_E_0_0(i)],'-k');
end

fill([0 5 5 0], [minCB minCB maxVB maxVB], 'r');
text(1, BGhalf, ['Bandgap = ', strBGhalf, 'eV']);

title('Bandgap and energy levels of a XYZ quantum dot');
set(gca,'XTickLabel',[]);
%xlabel('x-axis');
ylabel('Energy in eV');
%zlabel('z-axis');

legend('CB levels', 'VB levels', 'Bandgap','Location', 'EastOutside');