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

config.OMEN         = [config.root, 'OMEN/OMEN_ethz-amd64'];
config.experimentalData = [config.root, 'ExperimentalData/'];
config.simulations  = [config.root, 'Simulations/'];
config.vOMEN        = '23May2013';

if exist(config.simulations) == 0
    mkdir(config.simulations)
end

addpath(genpath(config.root))
cd(config.root)