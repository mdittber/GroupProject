function QDStructurePlot(qdotObj)
% Ploting the structure of a Quantum Dot in 3D

    global config;

    for k = 1:length(qdotObj)
    
        Layer_Matrix = load( [config.simulations, qdotObj.path, '/Layer_Matrix.dat']);

        NA = size(Layer_Matrix,1);
        numOfElements = max(Layer_Matrix(:,4));
        SizeCode = 30*ones(1,NA)';
        ColCode = Layer_Matrix(:,4)/numOfElements;

        fig_count = 1;
        %fig = figure(fig_count)
        scatter3(Layer_Matrix(:,1), Layer_Matrix(:,2), Layer_Matrix(:,3),SizeCode,ColCode,'filled');
        title('Structure of a XYZ quantum dot');
        %legend('Pb','S');
        xlabel('x-axis');
        ylabel('y-axis');
        zlabel('z-axis');
        %A(1,1) = 5;
        %refresh(H)

        %saveas(fig, getTimeDate);
    end
end
