classdef Qdot

	% Parameters for a structure to be simulated by OMEN
	%********************************************************************	
    
	properties
        mat_name
        
		lattice_type
		
        a0
        first_atom
        open_system
        tb
        dsp3
        
        n_of_modes
        
        max_bond_def
        
        x
        y
        z
        
        CPU_per_vd_point
        
        NVD
        Vdmin
        Vdmax
        
        directory
        
        no_mat
        no_channel_mat
        no_oxide_mat
        
        geometry
    end
    
    properties
        
        user
        timestamp
        OMENversion
        machine
        path
        
        
    end
    
    
    methods
        
        function obj = Qdot(varargin)
            % optional argument: Qdot obj is constructed from default values
			% if no argument is specified, an empty Qdot obj is constructed

            if (nargin ==1)
                if strcmp( varargin{1}, 'PbS')
                    
                    defaultPbSQdot;
                    obj = default;
                    
                elseif strcmp( varargin{1}, 'CdS_CdSe')
                    
                    defaultCdS_CdSeQdot;
                    obj = default;                
                
                elseif strcmp( varargin{1}, 'PbSe_allan')
                    
                    defaultPbSe_allanQdot;
                    obj = default;

                 elseif strcmp( varargin{1}, 'PbSe_lent')
                    
                    defaultPbSe_lentQdot;
                    obj = default;
                                       
                end
            end
            
            
        end
					
        function params = getSelParam(obj)        
            %return selected parameters in a struct or cell
					
            params = struct(...
                'mat_name', obj.mat_name,...
                'a0', obj.a0 ...
                );
            
            for i = 1: obj.no_mat
                params.Id(i) = obj.geometry(i).id;
                params.Radius(i) = obj.geometry(i).radius;
              
            end
        end

        
        function getGeo(obj)
            %display geometry
					
            for i =1:length(obj.geometry)
                obj.geometry(i)
            end
        end

        
    end
   
end