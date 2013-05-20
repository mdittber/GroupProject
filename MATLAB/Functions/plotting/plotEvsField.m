function plotEvsField(QDOA)
% plotEvsField(QDOA)
% Plot Energylevels againts applied electric field
% Degeneracy (within +/-0.002) is shown

global config;
N= length(QDOA);

fields = cell2mat( {QDOA(:).Efield} );
xspace = max(fields) - min(fields);
DegSpaceing = 0.005*xspace;
if DegSpaceing < 0.001
    DegSpaceing = 0.001;
end

for k =1:N
    
    VBpath = [config.simulations QDOA(k).path '/VB_E_0_0.dat'];
    CBpath = [config.simulations QDOA(k).path '/CB_E_0_0.dat'];
    if exist( CBpath ) > 0
        CBE = load(CBpath);
        plotDegEnergy(CBE, QDOA(k).Efield, DegSpaceing);
    end
    if exist( VBpath ) > 0
        VBE = load(VBpath);
        plotDegEnergy(VBE, QDOA(k).Efield, DegSpaceing);
    end

end

end

function plotDegEnergy(E,x,DegSpaceing)
    L = length(E);
    x = ones(L,1).*x;
    
    for i=2:L            
        if abs( E(i)-E(i-1) ) <0.002
            x(i) = x(i-1)+DegSpaceing;
        end
    end
    hold on;
    plot(x, E, '.b');
end
