function [Mpar] = delEmptyRows(Mpar_raw)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    e = cellfun('isempty', Mpar_raw);
        e = sum(e,2);
        [idx,e] = find(e);
        Mpar_raw(idx,:) = [];
Mpar = Mpar_raw;
end

