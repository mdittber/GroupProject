function [cleanedQDOA, duplicatesQDOA] = removeDuplicates(QDOA)
% [cleanedQDOA, duplicatesQDOA] = removeDuplicates(QDOA)
% returns the QDOA with all duplicates removed.

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
            if equalQdotParams(QDOA(i), QDOA(k))
                duplicatesInd(end+1) = i;
                cleanedInd(end) = [];
                break;            
            end
        end
    end
    

    duplicatesQDOA = QDOA(duplicatesInd);
    cleanedQDOA = QDOA(cleanedInd);
end

function bool = equalQdotParams(a, b)
% check if the simulation parameters of two QDO are equal
% return true or false
    bool =  ~isequal(a.mat_name,b.mat_name) + ...
        ~isequal(a.lattice_type,b.lattice_type ) + ...
        ~isequal(a.a0,b.a0 ) + ...
        ~isequal(a.first_atom,b.first_atom ) + ...
        ~isequal(a.open_system,b.open_system ) + ...
        ~isequal(a.tb,b.tb ) + ...
        ~isequal(a.dsp3,b.dsp3 ) + ...
        ~isequal(a.n_of_modes,b.n_of_modes ) + ...
        ~isequal(a.max_bond_def,b.max_bond_def ) + ...
        ~isequal(a.x,b.x ) + ...
        ~isequal(a.y,b.y ) + ...
        ~isequal(a.z,b.z ) + ...
        ~isequal(a.NVD,b.NVD ) + ...
        ~isequal(a.Vdmin,b.Vdmin ) + ...
        ~isequal(a.Vdmax,b.Vdmax ) + ...
        ~isequal(a.no_mat,b.no_mat ) + ...
        ~isequal(a.no_channel_mat,b.no_channel_mat ) + ...
        ~isequal(a.no_oxide_mat,b.no_oxide_mat ) + ...
        ~isequal(a.geometry,b.geometry ) + ...
        ~isequal(a.update_bs_target,b.update_bs_target ) + ...
        ~isequal(a.simulationStatus,b.simulationStatus) + ...
        ~isequal(a.bs_target,b.bs_target) ;
    
    bool = ~bool;

end