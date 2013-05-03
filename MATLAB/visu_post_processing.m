number_of_modes=5;
number_of_elec_field=1;
no_orbital=20;

Layer_Matrix=load('Layer_Matrix.dat');

NA=length(Layer_Matrix(:,1));

for IE=1:number_of_elec_field,
    
    filename=['CB_V_' num2str(IE-1) '_0.dat'];
    CB_V=load(filename);
    CB_V=CB_V(:,1:2:2*number_of_modes)+1i*CB_V(:,2:2:2*number_of_modes);
    
    psiCB2=zeros(NA,number_of_modes);
    for IM=1:number_of_modes,
        psiCB2(:,IM)=sum(reshape(abs(CB_V(:,IM)).^2,no_orbital,NA))';
        line_visualization( Layer_Matrix, psiCB2(:,IM), 2*(IE-1)*number_of_modes+2*(IM-1) )
    end    
end