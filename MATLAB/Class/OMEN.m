classdef OMEN
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        parameters = {
            'Material',
            'Geometry',
            'Inner Radius',
            'Outer Radius',
            '# of modes'
         }
    end
    
    methods(Static)
        function out = get(bool)
            out = bool
            out = out + bool
            out = cell2mat(OMEN.parameters)
        end
    end
    
end

