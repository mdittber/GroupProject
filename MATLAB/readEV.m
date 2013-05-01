EV = load('VB_V_0_0.dat');

EVmode1 = EV(:,1) + 1i*EV(:,2);
ProbabMode1 = abs(EVmode1).^2;

x = linspace(0,1, length(ProbabMode1) );

plot(x, ProbabMode1);
