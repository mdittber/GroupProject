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