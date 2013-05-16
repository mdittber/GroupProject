        function  deleteSimData(DB)
        % WARNING: Deletes the simulation folders and their contents of the objects in DB
            global config;
            for k = 1:length(DB)
                dir = [config.simulations, DB(k).path];
                rmdir( dir, 's' );
            end
        end