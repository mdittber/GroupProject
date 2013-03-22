/*********************************************************************************************************************************
Definition of a wire structure:

1) the order of the parameters must not be changed
2) the points in the structure mat_coord(i,j) and ox_coord(i,j) must follow the order described below
3) comments must remain on one line or start again with //

Commands:

CB_Bandstructure	= conduction bandstructure of contacts
VB_Bandstructure	= valence bandstructure of contacts
CB_Transmission_UWF	= conduction band transmission with UMFPACK
VB_Transmission_UWF	= valence band transmission with UMFPACK
CB_Transmission_SWF	= conduction band transmission with SuperLU_DIST
VB_Transmission_SWF	= valence band transmission with SuperLU_DIST
CB_Transmission_MWF	= conduction band transmission with MUMPS
VB_Transmission_MWF	= valence band transmission with MUMPS
CB_Transmission_RGF	= conduction band transmission with recursive GF
VB_Transmission_RGF	= valence band transmission with recursive GF
EL_SC_UWF		= self-consistent electron simulation with UMFPACK
HO_SC_UWF		= self-consistent hole simulation with UMFPACK
EL_SC_SWF		= self-consistent electron simulation with SuperLU_DIST
HO_SC_SWF		= self-consistent hole simulation SuperLU_DIST
EL_SC_MWF		= self-consistent electron simulation with MUMPS
HO_SC_MWF		= self-consistent hole simulation MUMPS
EL_SC_RGF		= self-consistent electron simulation with recursive GF
HO_SC_RGF		= self-consistent hole simulation with recursive GF
Write_Layer_Matrix      = write file with atom positions + connections
Write_Grid_Matrix       = write file with grid points + file with index of atom position

*********************************************************************************************************************************/
/*Parameters*/

mat_name            	= CdS_CdSe;             		//Material
a0                      = 0.582;                	//lattice constant
first_atom              = cation;               	//atom situated at [0 0 0]

open_system		= 0;

tb			= 10;                   	//tight-binding order
dsp3			= 30;                   	//passivation energy [eV]

n_of_modes		= 16;              		//number of modes for bandstructure calculation

max_bond_def		= 0.1;         			//maximum relative bond deformation (should only be changed if very large strain)

x                       = [1 0 0];			//transport direction
y                       = [0 1 0];			//direction of confinement
z     			= [0 0 1];              	//direction of confinement

CPU_per_vd_point	= 1;

NVD			= 1;				//number of drain voltages Vd=Vdmin:(Vdmax-Vdmin)/(NVD-1):Vdmax
Vdmin                   = 0.0;				//absolute minimum drain potential
Vdmax                   = 0.0;				//absolute maximum drain potential

//directory		= ;

/*********************************************************************************************************************************/
/*Structure*/

no_mat			= 2;				//number of pieces that form the nanowire (channel + oxide)
no_channel_mat          = 2;                    	//number of pieces that form the nanowire channel
no_oxide_mat            = 0;                    	//number of pieces that form the oxide around the wire  

mat_type(1)		= sphere;			//type of material: square or circle
mat_cs(1)		= yes;                          //does the material determine the nanowire cross section 
mat_id(1)		= 2;
mat_radius(1)		= 2.0;                          //radius of circle
mat_coord(1,1)	        = [0.0 0.0 0.0];	          	//[xcenter ycenter zcenter]

mat_type(2)		= sphere;			//type of material: square or circle
mat_cs(2)		= yes;                          //does the material determine the nanowire cross section 
mat_id(2)		= 1;
mat_radius(2)		= 3.0;                          //radius of circle
mat_coord(2,1)	        = [0.0 0.0 0.0];	          	//[xcenter ycenter zcenter]

/*********************************************************************************************************************************/
/*Commands*/

command(1)              = Write_Layer_Matrix;
command(2)		= CB_Closed;
command(3)		= VB_Closed;
