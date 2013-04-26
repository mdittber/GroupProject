classdef DButils
    %DB is an array of qdots...
    
    methods(Static)
        
        function DB = add(DB,DBpart)
            % add new dots to the DB
            DB = [DB; DBpart];
        end
        
        
        function DB = createDB()
            % 
            %
        end

        function [index, timestamp] = getIndex(DB, propertyName, value)
            %get the index and timestamp of a entry in DB with specific value in property
            
            timestamp = cell(0,0);
            index = [];
            
            [~,N] = size(DB);
            k = 1;
            for i=1:N % over all entries
                      
                % NOT YET STABLE!

                
                if  eval( sprintf('DB(%i).%s',i,propertyName) ) == value
                
                    index(k,1) = i; 
                    timestamp{k,1} = DB(i).timestamp;
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
                
                matrix{i,2} = DB(i).mat_name;
				matrix{i,3} = DB(i).geometry(1).id;
				matrix{i,4} = DB(i).geometry(1).type;
                matrix{i,5} = DB(i).geometry(1).radius;
				matrix{i,6} = DB(i).geometry(1).coord;
	
                matrix{i,7} = DB(i).geometry(2).id;
				matrix{i,8} = DB(i).geometry(2).type;
				matrix{i,9} = DB(i).geometry(2).radius;
				matrix{i,10} = DB(i).geometry(2).coord;
                
                matrix{i,11} = DB(i).n_of_modes;
				matrix{i,12} = DB(i).Vdmax;            
				matrix{i,13} = DB(i).a0;                
				matrix{i,14} = DB(i).tb;
				matrix{i,15} = DB(i).dsp3;
    
                matrix{i,16} = DB(i).timestamp(1:8);
                matrix{i,17} = DB(i).timestamp(10:13);                
               
                matrix{i,18} = DB(i).OMENversion;
                matrix{i,19} = DB(i).path;
                matrix{i,20} = DB(i).user;
                matrix{i,21} = DB(i).machine;

					
            end
            
            
        end
        
    end  
end
