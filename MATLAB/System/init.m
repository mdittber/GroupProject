%% Initializing Process
%  Update directories, set root directory

global config;

if strcmp(getenv('USERNAME'), 'gra13f2')
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

<<<<<<< HEAD
config.system  = [config.root, 'MATLAB/System/'];
config.log     = [config.root, 'SystemData'];
config.user    = getenv('USER');
config.machine = getenv('HOSTNAME');
config.OMEN   = [config.root, 'OMEN_ethz-amd64'];
config.simulations = [config.root, 'Simulations/'];
config.vOMEN = '04May2013';
config.cancelSim = 0;   % Is = 1 if simulation is aborted otherwise = 0
=======
config.system       = [config.root, 'MATLAB/System/'];
config.log          = [config.root, 'SystemData'];
config.OMEN         = [config.root, 'OMEN_ethz-amd64'];
config.simulations  = [config.root, 'Simulations/'];
config.vOMEN        = '04May2013';

% Is = 1 if simulation is aborted otherwise = 0
config.cancelSim    = 0;
>>>>>>> origin/mdevelop

if exist(config.simulations) == 0
    mkdir(config.simulations)
end

addpath(genpath(config.root))
cd(config.root)