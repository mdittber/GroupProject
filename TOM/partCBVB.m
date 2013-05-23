function [indCB, indVB] = partCBVB(E)
 % find the indices (E vector) of the energy levels which are nearest to
 % the bandgap
 
        a = E(1:end-1);
        b = E(2:end);
        c = abs(a-b);
        [~, indice] = max(c);
        
        indCB = indice+1;
        indVB = indice;
end