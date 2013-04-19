classdef DButils
    %DB is an array of qdots...
    
    methods(Static)
        
        function DB = add(DB,DBpart)
            % add new dots to the DB
            DB = [DB; DBpart];
        end


        function [index, timestamp] = getIndex(DB, propertyName, value)
            %get the index and timestamp of a entry in DB with specific value in property
            
            timestamp = cell(0,0);
            index = [];
            
            [~,N] = size(DB);
            k = 1;
            for i=1:N % over all entries
                               
                if eval( sprintf('DB(%i).%s',i,propertyName) ) == value
                    index(k) = i; 
                    timestamp{k} = DB(i).timestamp;
                    k = k+1;
                end
            end
        end
        

        function entries = getEntries(DB, index)
            % returns the objects with the specified indices in an array
            N=length(index);
            
            entries(N) = Qdot;
            
            for i=1:N
                entries(i) = DB(index(i));
            end
        end
        

        
        function newDB = removeEmpty(DB)
            % remove the deleted dots (= empty entries in DB)
            % TODO
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
                matrix{i,1} = i; %first element is array index of DB!
                matrix{i,2} = DB(i).timestamp;
                matrix{i,3} = DB(i).mat_name;
            end
            
            
        end
        
    end  
end