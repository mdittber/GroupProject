function simMultParam( Mpar )

    %********************************************************************
    % Writes cmd files and simulates with OMEN for different parameters
    %********************************************************************
    
%     Mpar: mat, mat_type, radius1, radius2, nrofmodes, vdmin, vdmax, NVD

    %********************************************************************
    %CREATE AND DEFINE DIRECTORIES
    %********************************************************************

    global config;

    cd( config.simulations );

    %********************************************************************
    %PARAMETERS MATERIAL 1
    %********************************************************************
    default = Qdot();

    %********************************************************************
    %Config of multiple values
    %********************************************************************
    % 
    % Parameters with multiple values: enter [start,stop,steps] instead of
    % a single value
    % 
    % Supported Sweep Parameters: radius(1) radius(2) NVD
    % 
    % Note: if radius 1 and 2 are both swept, they must be swept over an equal
    % nr of values! Furthermore  r1 < r2


    %********************************************************************
    %Parameters
    %********************************************************************

    default.mat_name                = Mpar{1};       %material_model
%     dynamic mat: fn
    
    default.lattice_type            = 'zincblende';
    
    default.a0                      = 0.582;            %lattice constant
    default.first_atom              = 'cation';         %atom situated at [0 0 0]

    default.open_system             = 0;

    default.tb                      = 10;              	%tight-binding order
    default.dsp3                    = 30;             	%passivation energy [eV]

    default.n_of_modes              = Mpar{5};               %number of modes for bandstructure calculation

    default.max_bond_def            = 0.1;              %maximum relative bond deformation (should only be changed if very large strain)

    default.x                       = [1 0 0];          %transport direction
    default.y                       = [0 1 0];          %direction of confinement
    default.z                       = [0 0 1];          %direction of confinement

    default.CPU_per_vd_point        = 1;

    default.NVD                     = Mpar{8};				%number of drain voltages Vd=Vdmin:(Vdmax-Vdmin)/(NVD-1):Vdmax
    default.Vdmin                   = Mpar{6};				%absolute minimum drain potential
    default.Vdmax                   = Mpar{7};				%absolute maximum drain pote
    %default.directory              = ;

    %GEOMETRY

    default.no_mat                  = 2;				%number of pieces that form the nanowire (channel + oxide)
    default.no_channel_mat          = 2;               	%number of pieces that form the nanowire channel
    default.no_oxide_mat            = 0;                %number of pieces that form the oxide around the wire  


    def_mat(1) = Geometry();

    def_mat(1).type                 = Mpar{2};			%type of material: square or circle
    def_mat(1).cs                   = 'yes';            %does the material determine the nanowire cross section 
    def_mat(1).id                   = 2;
    def_mat(1).radius               =  Mpar{3};              %radius of circle
    def_mat(1).coord                = [0.0 0.0 0.0];	%[xcenter ycenter zcenter]

    def_mat(2) = Geometry();

    def_mat(2).type                 = Mpar{2};			%type of material: square or circle
    def_mat(2).cs                   = 'yes';            %does the material determine the nanowire cross section 
    def_mat(2).id                   = 1;
    def_mat(2).radius               = Mpar{4};                %radius of circle
    def_mat(2).coord                = [0.0 0.0 0.0];    %[xcenter ycenter zcenter]

    default.geometry = def_mat;

    
    %********************************************************************
    %WRITE CMD FILES AND SIMULATE FOR MATERIAL 1
    %********************************************************************

    DBpart1 = simAll(default);
    clear default def_mat;

end