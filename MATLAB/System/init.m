%% Initializing Process
%  Update directories, set root directory

global config;
config.root    = '/usr/zupo/stud7/gra13f2/GroupProject/';
config.system  = [config.root, 'MATLAB/System/'];
config.log     = [config.root, 'SystemData'];
config.user    = getenv('USERNAME');
config.machine = getenv('HOSTNAME');
config.OMEN   = [config.root, 'OMEN_ethz-amd64'];
config.simulations = [config.root, 'Simulations/'];

config.vOMEN = 'version';

addpath(genpath(config.root))
cd(config.root)