function line_visualization(Matrix_Atom,V,index)


figure(100+index)
hold on

ind=1;

for IA=1:length(Matrix_Atom(:,1)),
    if (abs(Matrix_Atom(IA,2))<1e-8)&&(abs(Matrix_Atom(IA,3))<1e-8),
        Vline(ind)=V(IA);
        x(ind)=Matrix_Atom(IA,1);
        ind=ind+1;
    end
end

plot(x,Vline);
xlabel('x')
ylabel('|V|^2')