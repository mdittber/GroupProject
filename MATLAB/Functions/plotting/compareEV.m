function compareEV(dots, band, Nmod, tol, pName, showGrid)
%plot EV along axis for multiple directions (x,y,z) in same window

    directions = [1 0 0;0 1 0;0 0 1];

    [Ndir,~] = size(directions);


    for k =1:Ndir
        for i=1:Nmod       
            figure(i);
            subplot(Ndir,1,k);
            title( sprintf('mode %i, dir %s',i, mat2str(directions(k,:)) ) );
        end
        plotEVAlongAxis(dots, pName,[0 0 0], directions(k,:), showGrid, tol, Nmod, band);
    end

end