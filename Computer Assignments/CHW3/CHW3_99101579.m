%% Q1.1 
clc ; clear; close all;
syms s;
H1(s)=(s-1)/(s^3+20*s^2+10*s+100);
H2(s)=1/(s^4+20*s^2+10*s+100);
[n1,d1]=numden(H1);
[n2,d2]=numden(H2);
digits(5);
poles1=vpa(solve(d1==0,s));
zeros1=vpa(solve(n1==0,s));
poles2=vpa(solve(d2==0,s));
zeros2=vpa(solve(n2==0,s));
zplane(zeros1,poles1);
title('pole - zero plot for H1(s) ');
figure;
zplane(zeros2,poles2);
title('pole - zero plot for H2(s) ');
disp('for H1(s) we have '+string(length(poles1))+' poles : '+string(poles1(1))+' , '+string(poles1(2))+' , '+string(poles1(3)));
disp('for H1(s) we have '+string(length(zeros1))+' zeros : '+string(zeros1(1)));
disp('for H2(s) we have '+string(length(poles2))+' poles : '+string(poles2(1))+' , '+string(poles2(2))+' , '+string(poles2(3))+' , '+string(poles2(4)));
disp('for H1(s) we have '+string(length(zeros2))+' poles : ');
%% Q1.2
clc ; clear; close all;
syms s;
num=[1,7.2,24.91,44.77,41.235,7,0.33];
denum=[1,7.2,22.5,40.32,41.46,32.4,15.5];
H3=tf(num,denum);
pzmap(H3);
grid on;
%% Q1.3
clc ; clear; close all;
syms s  t;
H1(s)=(s-1)/(s^3+20*s^2+10*s+100);
H2(s)=1/(s^4+20*s^2+10*s+100);
U1(s)=(1/s)*(s-1)/(s^3+20*s^2+10*s+100);
U2(s)=(1/s)*1/(s^4+20*s^2+10*s+100);
u1(t)=vpa(real(ilaplace(U1(s))));
u2(t)=vpa(real(ilaplace(U2(s))));
fplot(u1(t),[0,50],'Linewidth',2);
title('step response of H1 system');
figure;
fplot(u2(t),[0,30],'Linewidth',2);
title('step response of H2 system');
%% Q1.4
clc ; clear; close all;
syms s  t;
G_2(s)=(2*s+4.5)/(3*s^2+2*s+7);
G_4(s)=(2*s+4.5)/(3*s^2+4*s+7);
G_6(s)=(2*s+4.5)/(3*s^2+6*s+7);
u_2(t)=vpa(real(ilaplace(G_2(s)*(1/s))));
u_4(t)=vpa(real(ilaplace(G_4(s)*(1/s))));
u_6(t)=vpa(real(ilaplace(G_6(s)*(1/s))));
h_2(t)=vpa(real(ilaplace(G_2(s))));
h_4(t)=vpa(real(ilaplace(G_4(s))));
h_6(t)=vpa(real(ilaplace(G_6(s))));

fplot(u_2(t),[0,35],'Linewidth',1.5);
hold on;
fplot(u_4(t),[0,35],'Linewidth',1.5);
hold on;
fplot(u_6(t),[0,35],'Linewidth',1.5);
title('impulse response of G system');
legend('a=2','a=4','a=6');

figure;
fplot(h_2(t),[0,35],'Linewidth',1.5);
hold on;
fplot(h_4(t),[0,35],'Linewidth',1.5);
hold on;
fplot(h_6(t),[0,35],'Linewidth',1.5);
title('step response of G system');
legend('a=2','a=4','a=6');

%% Q2.1
clc ; clear; close all;
syms n z;
x(n)=sin(n*pi/4);
X=ztrans(x);
[n1,d1]=numden(X);
poles_x=vpa(solve(d1==0,z));
zeros_x=vpa(solve(n1==0,z));
zplane(zeros_x,poles_x);
title('pole - zero plot for X(z) ');

%% Q2.3
clc ; clear; close all;
syms n z;
H1(z)=(z^(-1))/(1-2*z^(-1)+0.5*z^(-2));
[r,p,k]=residuez([0,1],[1,-2,0.5]);

disp('poles : '+string(p(1))+' , '+string(p(2)));
disp('roots : '+string(r(1))+' , '+string(r(2)));
%% Q2.4
clc ; clear; close all;
syms n z;
Y=(0:1:35);
x=0.707*1.707.^Y-0.707*0.292.^Y;
H1(z)=(z^(-1))/(1-2*z^(-1)+0.5*z^(-2));
h=vpa(real(iztrans(H1(z))));
h=subs(h,n,Y);
stem(Y,x,'Linewidth',2);
title('h1[n] using partial fraction ');
figure;
stem(Y,h,'Linewidth',2,'Color','r');
title('h1[n] using iztrans ');
%% Q3.1
clc ; clear; close all;
image = imread('radin.jpg');
imshow(image);
%% Q3.2
clc ; clear; close all;
image = imread('radin.jpg');
[R,G,B] = imsplit(image);
figure
subplot(2,2,1);
imshow(image)
title('original')
subplot(2,2,2)
imshow(R)
title('red Channel')
subplot(2,2,3)
imshow(G)
title('green Channel')
subplot(2,2,4)
imshow(B)
title('blue Channel')
%% Q3.3
clc ; clear; close all;
image = imread('radin.jpg');
[R,G,B] = imsplit(image);
average=(R+G+B)./3;
x=rgb2gray(image);
imshow(x);
figure;
imshow(average);


%% Q3.4  
clc; clear;close all;
image = imread('image.png');
picture=rgb2gray(image);

g1=[1,0,-1;2,0,-2;1,0,-1];
g2=[1,2,1;0,0,0;-1,-2,-1];

Gx=conv2(g1,picture);
Gy=conv2(g2,picture);
G=sqrt(Gx.^2+Gy.^2);
G=G/max(G,[],'all');
imshow(G);
figure;
imshow(image);


