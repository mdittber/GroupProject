%plot EV to show shift with Efield
clear dots
%dots{1} = v{7}(:); 
dots = ExportedQDOA;
%dots{3} = v{11}(:);

%target mode: plot EV closest to bandedge

% for k =1:length(dots)
%     
%     for i=1:length( dots{k} )
        
%        [~,~,CBind, VBind] = splitCBVBE(dots{k}(i));        
%        Nmod = [(VBind-1):VBind, CBind:(CBind+1)];

        Nmod = 1:8;%[(40-6-16+1):(40-6)];        
%         plotEV3Dmax(dots{k}(i),'CB',[0.2,0.6],Nmod);

        plotEV3D(dots,'VB',Nmod);
        plotEV3D(dots,'CB',Nmod);

%         
%     end
% 
% end



% normal plotting 
% 
% Nmod = [1];
% band = 'CB';
% 
% for k =1:length(dots)
%     plotEV3Dmax(dots{k},band,[0.2,0.5],Nmod)
% end