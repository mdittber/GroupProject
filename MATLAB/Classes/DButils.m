classdef DButils
    % Class DButils provides methods for manipulating DB
    % DB is an 1xN array of Qdots
    
    methods(Static)
        
        function [DB, SimDirs] = createDB()
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
    
        function showSelParam(DB)
            % display selected parameters for every Qdot in DB
            
            for i=1:length(DB)
                DB(i).getSelParam()
            end
        end
         
        function sLookUp = sort(LookUp, col, mode)
            % sLookUp = sort(LookUp, col, mode)
            %   sorts the column of an cell array where the rows
            %   stay the same
            %
            %   LookUp   cell array that shall be sorted
            %   col      column of LookUp that shall be sorted
            %   mode = 1 'ascend'
            %   mode = 0 'descend'
            
            sLookUp = sortrows(LookUp,col)
            if mode == 0
                sLookUp = flipud(sLookUp)
            end
        end
        
        function matrix = createMatrix(DB)
            % creates cell matrix from DB, containing selected properties
            % TODO not yet complete
            
            [~,N] = size(DB);
            M = 2; % number of properties displayed
            
            matrix = cell(N,M);
            
            for i = 1:N
                matrix{i,1} = DB(i).mat_name;
				matrix{i,2} = DB(i).geometry(1).id;
				matrix{i,3} = DB(i).geometry(1).type;
                matrix{i,4} = DB(i).geometry(1).radius;
				matrix{i,5} = mat2str(DB(i).geometry(1).coord);
	
                if size(DB(i).geometry,1) == 2
                matrix{i,6} = DB(i).geometry(2).id;
				matrix{i,7} = DB(i).geometry(2).type;
				matrix{i,8} = DB(i).geometry(2).radius;
				matrix{i,9} = mat2str(DB(i).geometry(2).coord);
                end
                
                matrix{i,10} = DB(i).n_of_modes;
				matrix{i,11} = DB(i).Vdmax;            
				matrix{i,12} = DB(i).a0;                
				matrix{i,13} = DB(i).tb;
				matrix{i,14} = DB(i).dsp3;
    
                matrix{i,15} = DB(i).timestamp(1:8);
                matrix{i,16} = DB(i).timestamp(10:13);                
               
                matrix{i,17} = DB(i).OMENversion;
                matrix{i,18} = DB(i).path;
                matrix{i,19} = DB(i).user;
                matrix{i,20} = DB(i).machine;
            end
        end
        
        
        %********************************************************************
        % METHODS for Filtering
        %********************************************************************

        function entries = filter(DB, propertyName, value, mode, tol)
            % returns array of obj whose properties match value
            % suited for properties of type scalar numeric or string
            % mode 1: property and value EXACTLY MATCHING 
            % mode 2: property matches a RANGE of values = [min, max]
            % mode 3: property and value match APPROXIMATELY :
            %           numeric properties: specify tolerance tol
            %           string properties: objects whose property contains string 'value' are selected
            % mode 4+5: compare 2 properties (propertyName = {pN1, pN2}) 
            % mode 4: value = constant difference +/-tol = pN1-pN2
            % mode 5: value = constant ratio +/-tol = pN1/pN2
            
            switch mode
                case 1
                    indices = DButils.find(DB, propertyName, value);
                case 2
                    indices = DButils.findRange(DB, propertyName, value(1), value(2));
                case 3
                    indices = DButils.findSimilar(DB, propertyName, value, tol);
                case 4
                    indices = DButils.findConstDiff(DB, propertyName{1}, propertyName{2}, value, tol);
                case 5
                    indices = DButils.findConstRatio(DB, propertyName{1}, propertyName{2}, value, tol);
            end
            entries = DButils.getEntries(DB, indices);            
        end
        
        
        %********************************************************************
        % sub functions for method filter
        %********************************************************************
        
        function entries = getEntries(DB, indices)
            % returns the objects with the specified indices in an Qdot array
            
            N=length(indices);
            if N<1
                entries = Qdot.empty;
                return;
            end
            
            entries(N) = Qdot;
            for i=1:N
                entries(i) = DB(indices(i));
            end
        end
        
        function [index, path] = find(DB, propertyName, value)
            % return indices and paths of DB entries with values of a Qdot property
            % which EXACTLY match argument value
            
            path = cell(0,0);
            index = [];
            [~,N] = size(DB);
            
            for i=1:N % over all entries
                currentValue = eval(sprintf('DB(%i).%s',i,propertyName));
                if isequal(currentValue, value)                       
                    index(end+1,1) = i; 
                    path{end+1,1} = DB(i).path;
                end
            end
        end
                
        function [index,path] = findRange(DB, propertyName, min, max)
            % return indices and paths of DB entries with values of a Qdot property
            % within a RANGE of values
            % Works only for properties of type double, scalar
            
            path = cell(0,0);
            index = [];
            [~,N] = size(DB);
            
            for i=1:N % over all entries
                currentValue = eval( sprintf('DB(%i).%s',i,propertyName));
                if (currentValue <= max ) && ( currentValue >= min )
                    index(end+1,1) = i; 
                    path{end+1,1} = DB(i).path;
                end
            end
            
        end
        
        function [index,path] = findSimilar(DB, propertyName, value, tol)
            % return indices and paths of DB entries with values of a Qdot property
            % which match APPROXIMATELY argument value
            % For scalar doubles specify tol:  tolerance in percent/100
            % for chars: all strings CONTAINING value will be returned 
            
            firstValue = eval( sprintf('DB(%i).%s',1,propertyName)); %read the first value to determine the datatype of the property
            
            if ischar( firstValue )
                
                path = cell(0,0);
                index = [];
                [~,N] = size(DB);
                
                for i=1:N % over all entries
                    currentValue = eval( sprintf('DB(%i).%s',i,propertyName));
                    if regexp(currentValue, value, 'once')
                        index(end+1,1) = i; 
                        path{end+1,1} = DB(i).path;
                    end
                end                
                
            
            elseif isnumeric( firstValue )
                [index, path] = DButils.findRange(DB, propertyName, value*(1-tol),  value*(1+tol));
            end
        end
        
        
        function [index, path] = findConstRatio(DB, propertyName1, propertyName2, ratio, tol)
            % returns indices and paths of DB entries with const ratio = pN1/pN2.
            % ratio +/- tol
            
            path = cell(0,0);
            index = [];
            [~,N] = size(DB);
            
            for i=1:N % over all entries
                currentValue1 = eval(sprintf('DB(%i).%s',i,propertyName1));
                currentValue2 = eval(sprintf('DB(%i).%s',i,propertyName2));
                currentRatio = currentValue1 / currentValue2;
                
                if ( currentRatio <= ratio*(1+tol) ) && (currentRatio >= ratio*(1-tol) )
                    index(end+1,1) = i; 
                    path{end+1,1} = DB(i).path;
                end
            end            
            
            
        end
        
        
        function [index, path] = findConstDiff(DB, propertyName1, propertyName2, diff, tol)
            % returns indices and paths of DB entries with constant difference  diff = pN1 - pN2.
            % diff +/- tol
            
            path = cell(0,0);
            index = [];
            [~,N] = size(DB);
            
            for i=1:N % over all entries
                currentValue1 = eval(sprintf('DB(%i).%s',i,propertyName1));
                currentValue2 = eval(sprintf('DB(%i).%s',i,propertyName2));
                currentDiff = currentValue1 - currentValue2;
                
                if ( currentDiff <= diff*(1+tol) ) && (currentDiff >= diff*(1-tol) )
                    index(end+1,1) = i; 
                    path{end+1,1} = DB(i).path;
                end
            end            
            
        end
               
        
        function cleaned = removeDuplicates(DB)
            % returns the DB with all Duplicates removed.
            % not suitable for large DBs
            N = length(DB);
            cleaned = Qdot.empty;
            
            if N > 100000 
                warning('over 100 000 iterations necessary. removeDuplicates not executed');
                return;
            end
            
            for i=1:N
                foundDuplicate = 0;
                
                for k=1:N
                    %check for duplicates
                    if (isequal(DB(i), DB(k))) && (k<i)
                        foundDuplicate = 1;
                        break;
                    end
                end

                if foundDuplicate == 0
                    %no duplicates found: add the current Qdot to new DB
                    cleaned(end+1) = DB(i);
                end
            end
        end

    end  
end
