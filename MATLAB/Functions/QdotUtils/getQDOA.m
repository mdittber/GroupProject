function [QDOA, SimDirs] = getQDOA()
% [QDOA, SimDirs] = getQDOA()
% create array of QdotObj from all simulation folders

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
        load([config.simulations, SimDirs(i).name, '/qdotObj.mat']);
        QDOA(i) = qdotObj;
    end

end