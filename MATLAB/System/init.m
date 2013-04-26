%% Initializing Process
%  Update directories, set root directory

global config;

if strcmp(getenv('USERNAME'), 'gra13f2')
    config.root = '/usr/zupo/stud7/gra13f2/GroupProject/';
elseif strcmp(getenv('USER'), 'christianfunck')
    config.root    = '/Users/christianfunck/Data/ETH/ITET/GA/GroupProject/';
elseif strcmp(getenv('USERNAME'), 'matthias')
    config.root    = 'C:\Users\matthias\Documents\ETH\ITET\Gruppenarbeit\';
end

config.system  = [config.root, 'MATLAB/System/'];
config.log     = [config.root, 'SystemData'];
config.user    = getenv('USER');
config.machine = getenv('HOSTNAME');
config.OMEN   = [config.root, 'OMEN_ethz-amd64'];
config.simulations = [config.root, 'Simulations/'];
config.vOMEN = 'version';
config.cancelSim = 0;

if exist(config.simulations) == 0
    mkdir(config.simulations)
end

addpath(genpath(config.root))
cd(config.root)