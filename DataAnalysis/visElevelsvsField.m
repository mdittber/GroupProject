%plot Energylevels vs Efield for different radii
dots = cell(1,1);
% dots{1} = v{6}(:); 
% dots{2} = v{11}(:);

for k =1:length(v)
    dots{k} = v{k}(:);
    titlestr{k} = sprintf('radius = %g',v{k}(1).geometry.radius);
end

ax=[0,2,-1,1.5];

for k =1:length(dots)

    figure
    plotEvsField(dots{k})
    title(titlestr{k});
    %axis(ax)

end