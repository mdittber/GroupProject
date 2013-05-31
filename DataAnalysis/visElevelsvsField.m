%plot Energylevels vs Efield for different radii
clear dots

%dots{1} = v{7}(:); 
dots{1} = v{11}(:);
%dots{3} = v{11}(:);


% for k =1:length(v)
% 
%     dots{k}(:) = v{k}(:);
%     titlestr{k} = sprintf('radius = %g',v{k}(1).geometry.radius);
% end

% dots = ExportedQDOA;%nor(3:2:19);
% for k =1:length(dots)
%     titlestr{k} = sprintf('radius = %g',dots(k).geometry.radius);
% end
% ax=[0,0.005,-1,2];

for k =1:length(dots)

    figure
    plotEvsField(dots{k})
    %suptitle(titlestr{k});
    %ylim([-0.5,1])
    xlim([0, 0.3]);
end