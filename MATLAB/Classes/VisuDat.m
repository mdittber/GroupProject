classdef VisuDat
    %Methods for visualising data from OMEN simulation
    methods (Static)
        
        function gridIndices = getGridIndices(grid, axis)
        end
        function probab = getEV( EV , axis)
        end
        
        function EV = plotEValongAxis(dots, pName, axis)
            % plot the EV of multiple dots along Axis
            
            % get EVs and param values for pName
            N=length(dots);
            EV = cell(N,1);
            pValue = zeros(N,1);
            for i=1:N
                EV{i} = load( [dots(i).path, '/VB_V_0_0.dat'] );
                pValue(i) = eval( sprintf('dots(%i).%s',i,pName) ); 
            end
            
%             probab = getEV( EV, axis);
            
%             plotNormal(probab, pName, pValue);
            
        end
        
        function plotNormal(values, pName, pValue)
            % plot and label multiple curves on normalized x-axis (0 to 1).
            % value: cell array containing arrays of the values to be
            % plotted
            % pName: Name of the parameter which distinguishes the
            % different curves
            % pValue: array of parameter Value for different curves

            N = length(values);
            
            allStyles = {'-k','-r','-g','-b','-c',':k',':r',':g',':b',':c','--k','--r','--g','--b','--c'};
            style = allStyles(1:N);
            labels = arrayfun( @(b) sprintf('%s = %g',pName,b), pValue, 'UniformOutput', false);
            
            hold on;
            h = cellfun(@(y,st) plot(linspace(0,1,length(y)),y,st), values, style);
            legend(h,labels);
        end
        
    end    
end
    
    