function plotEV3D(qdotObj, NMod)
% Plot wavefn of qdotObj.
% Plotnr: abcd: 
% a:(1,2)=(CB,VB)
% b: (1,2) = (crosssection y,z ; crosssection x,y)
% cd: mode number

    %load matrices from files
%     TODO
%     simPath = [config.Simulations, qdotObj.path];
    simPath = sprintf('Simulations/ID%s_%s/', qdotObj.timestamp, qdotObj.mat_name);

    Layer_Matrix = load([simPath, 'Layer_Matrix.dat']);
    CB_V = load([simPath, 'CB_V_0_0.dat']);
    VB_V = load([simPath, 'VB_V_0_0.dat']);

    [NAtom,~] = size(Layer_Matrix);            
    [n,m]  = size( VB_V );
    NOrb = n/NAtom; %nr of orbitals

    if nargin < 2
        NMod = m/2; %default: nr of modes = all modes
    end

    % convert EV to probability (psi^2) for requested modes
    psiCB2 = EV2psi(CB_V, NOrb, NMod);
    psiVB2 = EV2psi(VB_V, NOrb, NMod);

    for i=1:NMod,
        plot3DunitCell( Layer_Matrix, psiCB2(:,i), 1000+(i-1))
        plot3DunitCell( Layer_Matrix, psiVB2(:,i), 2000+(i-1))
    end
end


%********************************************************************************
% SUBFUNCTIONS
%********************************************************************************


function plot3DunitCell( LayerMatrix ,EV,index)

    h=colormap;

    EV=EV/max(EV)*length(h);

    %schnitt 1: y,z plane
    figure(100+index)
    hold on
    IA=1;
    while LayerMatrix(IA,1)<1e-8,
        plot3(LayerMatrix(IA,1),LayerMatrix(IA,2),LayerMatrix(IA,3),'ko','MarkerSize',8,'MarkerFaceColor',h(ceil(EV(IA)),:))
        view([90,0])
        IA=IA+1;
    end
    xlabel('x')
    ylabel('y')
    zlabel('z')

    %schnitt 2: x,y plane
    figure(200+index)
    hold on
    for IA=1:length(LayerMatrix(:,1)),
        if LayerMatrix(IA,3)<1e-8,
            plot3(LayerMatrix(IA,1),LayerMatrix(IA,2),LayerMatrix(IA,3),'ko','MarkerSize',8,'MarkerFaceColor',h(ceil(EV(IA)),:))
        end
    end
    xlabel('x')
    ylabel('y')
    zlabel('z')

end