function [cleanedQDOA, duplicatesQDOA] = removeDuplicates(QDOA)
% cleanedQDOA = removeDuplicates(QDOA, removeFolder)
% returns the QDOA with all Duplicates removed.

    N = length(QDOA);
    duplicatesInd = [];
    cleanedInd = 1;

    if N > 100000 
        warning('over 100 000 iterations necessary. removeDuplicates not executed');
        return;
    end

    for i=2:N
        cleanedInd(end+1)=i;
        for k=1:i-1            
            %check for duplicates
            if isequal(QDOA(i), QDOA(k))
                duplicatesInd(end+1) = i;
                cleanedInd(end) = [];
                break;            
            end
        end
    end
    
    duplicatesQDOA = QDOA(duplicatesInd);
    cleanedQDOA = QDOA(cleanedInd);
    
end  
