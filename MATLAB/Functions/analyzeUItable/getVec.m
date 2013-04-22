function vec = getVec(MparElem)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cMparElem = char(MparElem);
%vec = zeros(3,1);
tmp = '';
[n,m] = size(cMparElem);
j = 1;

for i=1:1:m
    
    if strcmp(cMparElem(i),'.')
        tmp = [tmp, cMparElem(i)];
    
    elseif str2double(cMparElem(i)) >= 0 && str2double(cMparElem(i)) <= 9
        tmp = [tmp, cMparElem(i)];
    
    elseif strcmp(cMparElem(i),',') || i == m
        vec(j) = str2double(tmp);
        j = j+1;
        tmp = '';
    end
end