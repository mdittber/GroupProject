function plot_qdot_data

mode_index=1;
type='CB';
no_orbital=5;

load Layer_Matrix.dat

NA=length(Layer_Matrix(:,1));

filename=[type '_V_0_0.dat'];
V=load(filename);

number_of_modes=length(V(1,:))/2;

V=V(:,1:2:2*number_of_modes)+1i*V(:,2:2:2*number_of_modes);
    
psi2=sum(reshape(abs(V(:,mode_index)).^2,no_orbital,NA))';

plot_3D_unit_cell(Layer_Matrix,psi2)

function plot_3D_unit_cell(Matrix_Atom,V)

h=colormap;

V=V/max(V)*length(h);

figure(1)
hold on
IA=1;
while Matrix_Atom(IA,1)<1e-8,
    plot3(Matrix_Atom(IA,1),Matrix_Atom(IA,2),Matrix_Atom(IA,3),'ko','MarkerSize',8,'MarkerFaceColor',h(ceil(V(IA)),:))
    IA=IA+1;
end
xlabel('x')
ylabel('y')
zlabel('z')

figure(2)
hold on
for IA=1:length(Matrix_Atom(:,1)),
    if Matrix_Atom(IA,3)<1e-8,
        plot3(Matrix_Atom(IA,1),Matrix_Atom(IA,2),Matrix_Atom(IA,3),'ko','MarkerSize',8,'MarkerFaceColor',h(ceil(V(IA)),:))
    end
end
xlabel('x')
ylabel('y')
zlabel('z')