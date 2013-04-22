%% Initializing Process
%  Update directories, set root directory

global config;

if strcmp(getenv('USER'), 'gra13f2')
    config.root = '/usr/zupo/stud7/gra13f2/GroupProject/'
else
    config.root    = '/Users/christianfunck/Data/ETH/ITET/GA/GroupProject/';
end

config.system  = [config.root, 'MATLAB/System/'];
config.log     = [config.root, 'SystemData'];
config.user    = getenv('USER');
config.machine = getenv('HOSTNAME');
config.OMEN   = [config.root, 'OMEN_ethz-amd64'];
config.simulations = [config.root, 'Simulations/'];

config.vOMEN = 'version';

addpath(genpath(config.root))
cd(config.root)