function [DB, SimDirs] = getQDOA()
            % create the DB from simulation folders
            
            %get sim folders
            global config;            
            SimDirs = dir([config.simulations '/ID*']);
            [N,~] = size(SimDirs);
            
            %initialize DB
            if N<1
                DB = Qdot.empty;
                return;
            end            
            DB(N) = Qdot;
            
            %load data into DB 
            for i=1:N    
                load([config.simulations, SimDirs(i).name, '/qdotObj.mat']);
                DB(i) = qdotObj;
            end
            
        end