%% Initializing Process
%  Update directories, set root directory

global config;
config.root    = 'C:\Users\matthias\Documents\ETH\ITET\Gruppenarbeit\';
config.system  = [config.root, 'MATLAB\System\'];
config.user    = getenv('USERNAME');
config.machine = getenv('COMPUTERNAME');
config.vOMEN   = 'version???';