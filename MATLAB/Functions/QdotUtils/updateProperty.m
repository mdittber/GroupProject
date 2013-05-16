 function updateProperty(DIR, pName, value)
%% updateProperty(DIR, pName, value)
%   DIR     directory path relative to 'root/Simulations/'
%   pName   Qdot property in single quotes, i.e. 'OMENversion'
%   value   value that will be entered in the property
%            abs2rel changes the path of the Qdot to a path relative to
%            'root/Simulations' and moves the simulation set into the
%             right folder

    global config;
    ctrStatus = 0;
    SimDirs = dir([config.simulations, DIR, '/ID*']);
    [N,~] = size(SimDirs);

    for i=1:N
        load([config.simulations, DIR, '/', SimDirs(i).name, '/qdotObj.mat']);

        %% Overwrite property

        % Change path from absolute to relative
        if strcmp(pName, 'path') && strcmp(value, 'abs2rel')
            newPath = ['ID', qdotObj.timestamp, '_', qdotObj.mat_name];
            eval( sprintf('qdotObj.%s = %s;',pName,'newPath') );
            save([config.simulations, DIR, '/', SimDirs(i).name, '/qdotObj.mat'], 'qdotObj');

            % Move simulation folder
            source = [config.simulations, DIR, '/',newPath];
            destination = [config.simulations, newPath];
            [status, msg, msgID] = movefile(source, destination,'f');
            ctrStatus = ctrStatus + status;
            if status == 0
                sprintf('Folder could not be moved from: \n   %s \n to: \n   \s', source, destination);
            end
            if i == N && ctrStatus == N
                rmdir([config.simulations, DIR]);
            end

        % Change a property
        else
            eval( sprintf('qdotObj.%s = %s;',pName,'value') );
            save([config.simulations, DIR, '/', SimDirs(i).name, '/qdotObj.mat'], 'qdotObj');
        end

    end
    addpath(genpath(config.root));
end