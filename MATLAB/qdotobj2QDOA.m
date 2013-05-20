%% Run the script do change all qdotObj.mat files and
%  included Qdot object to QDO.mat incl. QDO


global config;

%get sim folders
SimDirs = dir([config.simulations '/ID*']);
[N,~] = size(SimDirs);


for k=1:N
    path = [config.simulations, SimDirs(k).name, '/qdotObj.mat'];
    if exist(path)>0
    load(path);
    QDO = qdotObj;
    save([config.simulations, SimDirs(k).name, '/QDO.mat'],'QDO');
    delete(path);
    end
end