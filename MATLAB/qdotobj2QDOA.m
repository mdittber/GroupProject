%% Run the script do change all qdotObj.mat files and
%  included Qdot object to QDO.mat incl. QDO


global config;

QDOA = getQDOA()

for k=1:length(QDOA)
    path = [config.simulations, QDOA(k).path, '/qdotObj.mat'];
    load(path);
    QDO = qdotObj;
    save([config.simulations, QDOA(k).path, '/QDO.mat'],'QDO');
    delete(path);
end