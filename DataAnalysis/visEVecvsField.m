%plot EV to show shift with Efield
dots = cell(1,1);
dots{1} = v{6}(2:2); 


%target mode: plot EV closest to bandedge

for k =1:length(dots)
    
    for i=1:length( dots{k} )
        
        [~,~,CBind, VBind] = splitCBVBE(dots{k}(i));
        
        Nmod = [(VBind-1):VBind, CBind:(CBind+1)];
        
        plotEV3Dmax(dots{k}(i),'CB',[0.2,0.5],Nmod)

        
    end

end



% normal plotting 
% 
% Nmod = [1];
% band = 'CB';
% 
% for k =1:length(dots)
%     plotEV3Dmax(dots{k},band,[0.2,0.5],Nmod)
% end