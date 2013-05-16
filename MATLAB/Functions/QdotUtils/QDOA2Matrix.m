 function matrix = QDOA2Matrix(DB)
            % creates cell matrix from DB, containing selected properties
            % TODO not yet complete
            
            N = length(DB);
            M = 2; % number of properties displayed
            
            matrix = cell(N,M);
            
            for i = 1:N
                matrix{i,1} = DB(i).mat_name;
				matrix{i,2} = DB(i).geometry(1).id;
				matrix{i,3} = DB(i).geometry(1).type;
                matrix{i,4} = DB(i).geometry(1).radius;
				matrix{i,5} = mat2str(DB(i).geometry(1).coord);
	
                if length(DB(i).geometry) == 2
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