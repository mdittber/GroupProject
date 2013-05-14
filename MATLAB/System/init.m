%% Initializing Process
%  Update directories, set root directory

global config;

if strcmp(getenv('USER'), 'gra13f2')
    config.root     = '/usr/zupo/stud7/gra13f2/GroupProject/';
    config.user     = getenv('USER');
    config.machine  = getenv('HOSTNAME');
elseif strcmp(getenv('USER'), 'christianfunck')
    config.root     = '/Users/christianfunck/Data/ETH/ITET/GA/GroupProject/';
    config.user     = getenv('USER');
    config.machine  = getenv('HOSTNAME');
elseif strcmp(getenv('USERNAME'), 'matthias')
    config.root     = 'C:\Users\matthias\Documents\ETH\ITET\Gruppenarbeit\';
    config.user     = getenv('USERNAME');
    config.machine  = getenv('COMPUTERNAME');
end

config.system       = [config.root, 'MATLAB/System/'];
config.matlab          = [config.root, 'MATLAB'];
config.OMEN         = [config.root, 'OMEN_ethz-amd64'];
config.simulations  = [config.root, 'Simulations/'];
config.vOMEN        = '04May2013';

% Is = 1 if simulation is aborted otherwise = 0
config.cancelSim    = 0;

if exist(config.simulations) == 0
    mkdir(config.simulations)
end

addpath(genpath(config.matlab))
cd(config.root)