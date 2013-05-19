function numArray = comma2dot(cellArray)
    [n,m] = size(cellArray);
    numArray = zeros(n,m);
    for k=1:n
        for l=1:m
            temp = cellArray{k,l};
            idx  = find(temp == ',');
            temp(idx) = '.';
            numArray(k,l) = str2num(temp);
        end
    end
end