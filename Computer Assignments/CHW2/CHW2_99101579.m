%% Q1
% Q1.1
clc ; clear ; close all;

syms x0 y0 v0 ang0 t

x(t)=symfun(v0*cos(ang0)*t+x0,[v0 x0 ang0 t]);
y(t)=symfun(-(0.5)*9.8*(t^2)+v0*sin(ang0)*t+y0,[v0 y0 ang0 t]);

projectile(x0,y0,v0,ang0,t)=[x(t),y(t)]; 
%Q1.2
sample_1=projectile(0,20,20,pi/3,t);
sample_2=projectile(0,20,10,-pi/3,t);

fplot(sample_1(1),sample_1(2),[0 4],'LineWidth',2);
hold on;
fplot(sample_2(1),sample_2(2),[0 4],'LineWidth',2);
ylabel('y');
xlabel('x');
legend('sample 1','sample 2');
title('position of sample 1 and sample 2 for 0<t<4');

t_1=solve(sample_1(2)==0,t>0);
t_2=solve(sample_2(2)==0,t>0);
t_3=solve(sample_1(2)==20,t>0);
t_4=solve(sample_2(2)==20,t>0);

digits(4);
if(isempty(t_1))
    disp("first sample never comes back to h=0 for t>0 ")
else
    disp("first sample comes back to h=0 at << "+string(vpa(t_1))+" s >>");
end
if(isempty(t_2))
    disp("second sample never comes back to h=0 for t>0 ")
else
    disp("second sample comes back to h=0 at << "+string(vpa(t_2))+" s >>");
end
if(isempty(t_3))
    disp("first sample never comes back to first height for t>0 ");
else
    disp("first sample comes back to first height at << "+string(vpa(t_3))+" s >>");
end
if(isempty(t_4))
    disp("second sample never comes back to first height for t>0 ");
else
    disp("second sample comes back to first height at << "+string(vpa(t_4))+" s >>");
end
%Q1.3

V_calculator=diff(projectile,t);
V_sample_1=V_calculator(0,20,20,pi/3,t);
V_sample_2=V_calculator(0,20,10,-pi/3,t);

figure;
fplot(t,V_sample_1(1),[0 4],'LineWidth',2);
hold on;
fplot(t,V_sample_1(2),[0 4],'LineWidth',2);
hold on;
fplot(t,V_sample_2(1),[0 4],'LineWidth',2);
hold on;
fplot(t,V_sample_2(2),[0 4],'LineWidth',2);
legend('V_x sample 1','V_y sample 1','V_x sample 2','V_y sample 2');
title(' velocity - time chart for sample 1 and sample 2 in 0<t<4 ');
ylabel('V(m/s)');
xlabel('t(s)');

%% Q2.1
clc ; clear ; close all;


fplot(f(x),[-20,20],'LineWidth',2);
ylim([-5,5]);
title(' f(x) ');
figure;
fplot(g(x),[-10,20],'LineWidth',2);
title(' g(x) ' );

%% Q2.2
clc ; clear ; close all;
syms x
f(x)=1/(1-x^3);
g(x)=(x^2)*exp(-x)*heaviside(x);
F=fourier(f(x));
G=fourier(g(x));

figure;
subplot(2,1,1);
fplot(abs(F),'LineWidth',2);
title(' norm of F(\omega) ');
subplot(2,1,2);
fplot(phase(F),'LineWidth',2);
xlim([-20,20]);
title(' phase of F(\omega) ');

figure;
subplot(2,1,1);
fplot(abs(G),'LineWidth',2);
title(' norm of G(\omega) ');
subplot(2,1,2);
fplot(phase(G),'LineWidth',2);
xlim([-20,20]);
title(' phase of G(\omega) ');

%% Q3
clc ; clear ; close all;
syms x
f(x)= sinc(x);
g1(x)=f(x-2);
g2(x)=exp(1i*x/2)*f(x);
g3(x)=f(2*x);
g4(x)=cos(2*x)*f(x);

F=fourier(f(x));
G1=fourier(g1(x));
G2=fourier(g2(x));
G3=fourier(g3(x));
G4=fourier(g4(x));

figure;
subplot(2,2,1);
fplot(abs(F),'LineWidth',2);
title(' norm of F(\omega) ');
subplot(2,2,2);
fplot(phase(F),'LineWidth',2);
title(' phase of F(\omega) ');
subplot(2,2,3);
fplot(abs(G1),'LineWidth',2);
title(' norm of G1(\omega) ');
subplot(2,2,4);
fplot(phase(G1),'LineWidth',2);
title(' phase of G1(\omega) ');

figure;
subplot(2,2,1);
fplot(abs(F),'LineWidth',2);
title(' norm of F(\omega) ');
subplot(2,2,2);
fplot(phase(F),'LineWidth',2);
title(' phase of F(\omega) ');
subplot(2,2,3);
fplot(abs(G2),'LineWidth',2);
title(' norm of G2(\omega) ');
subplot(2,2,4);
fplot(phase(G2),'LineWidth',2);
title(' phase of G2(\omega) ');

figure;
subplot(2,2,1);
fplot(abs(F),'LineWidth',2);
xlim([-10,10]);
ylim([0,1]);
title(' norm of F(\omega) ');
subplot(2,2,2);
fplot(phase(F),'LineWidth',2);
title(' phase of F(\omega) ');
subplot(2,2,3);
fplot(abs(G3),'LineWidth',2);
xlim([-10,10]);
ylim([0,1]);
title(' norm of G3(\omega) ');
subplot(2,2,4);
fplot(phase(G3),'LineWidth',2);
title(' phase of G3(\omega) ');

figure;
subplot(2,2,1);
fplot(abs(F),'LineWidth',2);
title(' norm of F(\omega) ');
xlim([-10,10]);
subplot(2,2,2);
fplot(phase(F),'LineWidth',2);
title(' phase of F(\omega) ');
subplot(2,2,3);
fplot(abs(G4),'LineWidth',2);
ylim([0,1]);
xlim([-10,10]);
title(' norm of G4(\omega) ');
subplot(2,2,4);
fplot(phase(G4),'LineWidth',2);
title(' phase of G4(\omega) ');




