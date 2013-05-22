function [QDOA, SimDirs] = getQDOA()
% [QDOA, SimDirs] = getQDOA()
% creates an array of QDO from all simulation folders

    %get sim folders
    global config;            
    SimDirs = dir([config.simulations '/ID*']);
    [N,~] = size(SimDirs);

    %initialize DB
    if N<1
        QDOA = Qdot.empty;
        return;
    end            
    QDOA(N) = Qdot;

    %load data into DB 
    for i=1:N   
        path =[config.simulations, SimDirs(i).name, '/QDO.mat'];
        if exist(path) >0
            load(path);
            QDOA(i) = QDO;
        end    
    end
end