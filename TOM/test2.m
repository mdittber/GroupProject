all = getQDOA;
all = filterQDOA(all,'mat_name','PbS_lent',1,0);

%target mode
tar = filterQDOA(all,'update_bs_target',1,1,0);

%split radii: v{k} contains QDOA with same radius = radii(k)
radii = 0.5:0.25:5;
v = cell(length(radii),1);

for k=1:length(tar)
    for j=1:length(radii)
        if tar(k).geometry.radius == radii(j)
            v{j}(end+1) = tar(k);
        end
    end
end
%normal cb cv mode
nor = filterQDOA(all,'update_bs_target',0,1,0);

