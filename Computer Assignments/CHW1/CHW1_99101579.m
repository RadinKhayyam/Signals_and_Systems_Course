%% Q1 section1
clc ; clear all ; close all ;

n1=-100:1:100;
s1=((0.98).^n1).*sin(0.2*pi.*n1+0.05*pi);

for n2=-100:1:100
    if(mode(n2,2)==0)
        s2(n2+101)=sin(0.1*n2)*exp(0.02*n2);
    else
        s2(n2+101)=cos(0.1*n2)*exp(-0.02*n2);
    end
end

n3=1:1:100;
s3=log10(sqrt(n3));

s4=zeros(201,1);
for n4=-100:1:100
    sum=0;
    for i=-100:1:n4
        sum=s1(i+101)*s2(-i+101)+sum;
    end
    s4(n4+101)=sum;
end

subplot(2,2,1);
stem(n1,s1);
title('$s_{1}[n] $','Interpreter','latex');
subplot(2,2,2);
stem([-100:1:100],s2);
title('$s_{2}[n] $','Interpreter','latex');
subplot(2,2,3);
stem(n3,s3);
title('$s_{3}[n] $','Interpreter','latex');
subplot(2,2,4);
stem([-100:1:100],s4);
title('$s_{4}[n] $','Interpreter','latex');
%% Q1 section2
clc ; clear all ; close all ;
s1_c = @(t1) ((0.98).^t1).*sin(0.2*pi.*t1+0.05*pi);
t1_start=-100;
t1_end=100;
fs=1000;
t1 = linspace(t1_start, t1_end,fs*(t1_end-t1_start));
subplot(2,1,1);
plot(t1,s1_c(t1),'LineWidth',2);
ylabel('$ s_{1}(t) $','Interpreter','latex');
xlabel('t');
title('$s_{1}(t) $','Interpreter','latex');

subplot(2,1,2);
t3_start=0;
t3_end=50;
t3=0:(1/fs):100;
s3_c=log10(sqrt(t3));
plot(t3,s3_c,'color','r','LineWidth',2);
ylabel('$ s_{3}(t) $','Interpreter','latex');
xlabel('t');
title('$s_{3}(t) $','Interpreter','latex');

%% Q1 section3
clc ; clear all ; close all ;
fs=1000;
t_a=-10:(1/fs):10;
signal_a=exp(0.5*pi*1i.*t_a);

subplot(2,2,1);
plot(t_a,real(signal_a));
title('$real\ part\ of\ signal\ a(t) $','Interpreter','latex');
subplot(2,2,2);
plot(t_a,imag(signal_a));
title('$imaginary\ part\ of\ signal\ a(t) $','Interpreter','latex');
subplot(2,2,3);
plot(t_a,abs(signal_a));
title('$amplitude\ of\ signal\ a(t) $','Interpreter','latex');
subplot(2,2,4);
plot(t_a,rad2deg(angle(signal_a)));
title('$phase(in\ deg)\ of\ signal\ a(t) $','Interpreter','latex');

t_b=-pi/4:(1/fs):pi/4;
signal_b=tanh(1i*pi.*t_b);

figure;
subplot(2,2,1);
plot(t_b,real(signal_b));
title('$real\ part\ of\ signal\ b(t) $','Interpreter','latex');
subplot(2,2,2);
plot(t_b,imag(signal_b));
title('$imaginary\ part\ of\ signal\ b(t) $','Interpreter','latex');
subplot(2,2,3);
plot(t_b,abs(signal_b));
title('$amplitude\ of\ signal\ b(t) $','Interpreter','latex');
subplot(2,2,4);
plot(t_b,rad2deg(angle(signal_b)));
title('$phase(in\ deg)\ of\ signal\ b(t) $','Interpreter','latex');

%% Q2 section1
clc ; clear all ; close all ;
syms t;
x(t)=piecewise(t<-3,0,-3<t<-2,t+3,-2<t<2,1,2<t<4,-t/2+2,4<t,0);

subplot(2,3,1);
fplot(x(t),'LineWidth',2);
title('$x(t) $','Interpreter','latex');
xlabel('t');
ylim([0 2]);
xlim([-5 5]);
grid minor;

subplot(2,3,2);
fplot(x(t-2.5),'LineWidth',2);
title('$x(t-2.5) $','Interpreter','latex');
xlabel('t');
ylim([0 2]);
xlim([-2.5 7.5]);
grid minor;

subplot(2,3,3);
fplot(x(2*t),'LineWidth',2);
title('$x(2t) $','Interpreter','latex');
xlabel('t');
ylim([0 2]);
xlim([-2.5 2.5]);
grid minor;

subplot(2,3,4);
fplot(x(t/2+3),'LineWidth',2);
title('$x(0.5t+3) $','Interpreter','latex');
xlabel('t');
ylim([0 2]);
xlim([-16 4]);
grid minor;

subplot(2,3,5);
fplot(x(-(t-2)),'LineWidth',2);
title('$x(-(t-2)) $','Interpreter','latex');
xlabel('t');
ylim([0 2]);
xlim([-3 7]);
grid minor;

%% Q2 section2
clc ; clear all ; close all ;
syms t;
x(t)=piecewise(t<-3,0,-3<t<-2,t+3,-2<t<2,1,2<t<4,-t/2+2,4<t,0);

subplot(2,1,1);
fplot((x(t)+x(-t))/2,'LineWidth',2);
title('$even\ part\ of\ signal\ x(t) $','Interpreter','latex');
xlabel('t');
ylim([-2 2]);
xlim([-5 5]);
grid minor;

subplot(2,1,2);
fplot((x(t)-x(-t))/2,'LineWidth',2);
title('$odd\ part\ of\ signal\ x(t) $','Interpreter','latex');
xlabel('t');
ylim([-2 2]);
xlim([-5 5]);
grid minor;

%% Q3 section2a
clc ; clear all ; close all ;
syms t;
low_lim_x1=-2;
up_lim_x1=4;
low_lim_x2=-4;
up_lim_x2=2;
x1(t)=piecewise(t<=low_lim_x1,0,low_lim_x1<t<up_lim_x1,1,up_lim_x1<=t,0);
x2(t)=x1(-t);
answer=convolution(x1,low_lim_x1,up_lim_x1,x2,low_lim_x2,up_lim_x2);
subplot(2,1,1);
plot(linspace(low_lim_x1+low_lim_x2,up_lim_x1+up_lim_x2,length(answer)),answer);
title('$ y_1(t)\ =\ x_1(t)*x_1(-t)\ using\ my\ function $','Interpreter','latex');

fs=100;
t1=-2:(1/fs):4;
t2=-4:(1/fs):2;
s1=double(x1(t1));
s2=double(x2(t2));
w=conv(s1,s2)*(1/fs);
subplot(2,1,2);
plot((t1(1)+t2(1):(1/fs):t1(end)+t2(end)),w);
title('$y_1(t)\ =\ x_1(t)*x_1(-t)\ using\ matlab\ function $','Interpreter','latex');

%% Q3 section2b
clc ; clear all ; close all ;
syms t;
low_lim_x1=-6;
up_lim_x1=6;
low_lim_x2=-2;
up_lim_x2=10;
x1(t)=piecewise(t<low_lim_x1 ,0 , low_lim_x1<=t<=0 , t+6,0<=t<=up_lim_x1 , -t+6,up_lim_x1<t , 0);
x2(t)=piecewise(t<low_lim_x2,0,low_lim_x2<=t<=up_lim_x2,exp(-0.5.*(t-2)),up_lim_x2<t,0);
answer=convolution(x1,low_lim_x1,up_lim_x1,x2,low_lim_x2,up_lim_x2);
subplot(2,1,1);
plot(linspace(low_lim_x1+low_lim_x2,up_lim_x1+up_lim_x2,length(answer)),answer);
title('$y_2(t)\ =\ y_1(t)*x_2(t)\ using\ my\ function $','Interpreter','latex');

fs=100;
t1=-6:(1/fs):6;
t2=-2:(1/fs):10;
s1=double(x1(t1));
s2=double(x2(t2));
w=conv(s1,s2)*(1/fs);
subplot(2,1,2);
plot((t1(1)+t2(1):(1/fs):t1(end)+t2(end)),w);
title('$y_2(t)\ =\ y_1(t)*x_2(t)\ using\ matlab\ function $','Interpreter','latex');

%% Q3 section3.1
clc ; clear all ; close all ;
syms t;
low_lim_x1=-2;
up_lim_x1=4;
low_lim_x2=-2;
up_lim_x2=10;
x1(t)=piecewise(t<=low_lim_x1,0,low_lim_x1<t<up_lim_x1,1,up_lim_x1<=t,0);
x2(t)=piecewise(t<low_lim_x2,0,low_lim_x2<=t<=up_lim_x2,exp(-0.5.*(t-2)),up_lim_x2<t,0);

answer1=convolution(x1,low_lim_x1,up_lim_x1,x2,low_lim_x2,up_lim_x2);

answer2=convolution(x2,low_lim_x2,up_lim_x2,x1,low_lim_x1,up_lim_x1);

subplot(2,1,1);
plot(linspace(low_lim_x1+low_lim_x2,up_lim_x1+up_lim_x2,length(answer1)),answer1);
title('$ x_1(t)*x_2(t)\ using\ my\ function $','Interpreter','latex');

subplot(2,1,2);
plot(linspace(low_lim_x1+low_lim_x2,up_lim_x1+up_lim_x2,length(answer2)),answer2);
title('$ x_2(t)*x_1(t)\ using\ my\ function $','Interpreter','latex');

%% Q3 section3.2
clc ; clear all ; close all ;
syms t;
low_lim_x1=-2;
up_lim_x1=2;
low_lim_x2=-2;
up_lim_x2=2;
low_lim_x3=-2;
up_lim_x3=2;
x1(t)=piecewise(t<=low_lim_x1,0,low_lim_x1<t<up_lim_x1,1,up_lim_x1<=t,0);
x2(t)=piecewise(t<=low_lim_x2,0,low_lim_x2<=t<-1,t+2,-1<=t<1,1,1<=t<up_lim_x2,-t+2,up_lim_x2<=t,0);
x3(t)=piecewise(t<low_lim_x3 ,0 , low_lim_x3<=t<=0 , t+2,0<=t<=up_lim_x3 , -t+2,up_lim_x3<t , 0);
x4(t)=x2(t)+x3(t);
answer1=convolution(x1,low_lim_x1,up_lim_x1,x2,low_lim_x2,up_lim_x2);

answer2=convolution(x1,low_lim_x1,up_lim_x1,x3,low_lim_x3,up_lim_x3);

answer3=answer1+answer2;

answer4=convolution(x1,low_lim_x1,up_lim_x1,x4,-2,2);

subplot(3,3,1);
fplot(x1(t));
title('$ x_1(t) $','Interpreter','latex');
subplot(3,3,2);
fplot(x2(t));
title('$ x_2(t) $','Interpreter','latex');
subplot(3,3,3);
fplot(x3(t));
title('$ x_3(t) $','Interpreter','latex');
subplot(3,3,[4,5,6]);
plot(linspace(low_lim_x1+low_lim_x2,up_lim_x1+up_lim_x2,length(answer3)),answer3);
title('$ x_1(t)*x_2(t)\ +\ x_1(t)*x_3(t)\ using\ my\ function $','Interpreter','latex');

subplot(3,3,[7,8,9]);
plot(linspace(low_lim_x1-2,up_lim_x1+2,length(answer4)),answer4);
title('$ x_1(t)*(x_2(t)\ +\ x_3(t))\ using\ my\ function $','Interpreter','latex');

%% Q3 section3.3
clc ; clear all ; close all ;
syms t;
low_lim_x1=-2;
up_lim_x1=2;
low_lim_x2=-2;
up_lim_x2=2;
low_lim_x3=-2;
up_lim_x3=2;
x1(t)=piecewise(t<=low_lim_x1,0,low_lim_x1<t<up_lim_x1,1,up_lim_x1<=t,0);
x2(t)=piecewise(t<=low_lim_x2,0,low_lim_x2<=t<-1,t+2,-1<=t<1,1,1<=t<up_lim_x2,-t+2,up_lim_x2<=t,0);
x3(t)=piecewise(t<low_lim_x3 ,0 , low_lim_x3<=t<=0 , t+2,0<=t<=up_lim_x3 , -t+2,up_lim_x3<t , 0);

fs=100;
t1=-2:(1/fs):2;
t2=-2:(1/fs):2;
t3=-2:(1/fs):2;
s1=double(x1(t1));
s2=double(x2(t2));
s3=double(x3(t3));
answer1=conv(s2,s3)*(1/fs);
answer2=conv(s1,answer1)*(1/fs);

answer3=conv(s1,s2)*(1/fs);
answer4=conv(s3,answer3)*(1/fs);

subplot(3,3,1);
fplot(x1(t));
title('$ x_1(t) $','Interpreter','latex');
subplot(3,3,2);
fplot(x2(t));
title('$ x_2(t) $','Interpreter','latex');
subplot(3,3,3);
fplot(x3(t));
title('$ x_3(t) $','Interpreter','latex');
subplot(3,3,[4,5,6]);
plot(linspace(-6,6,length(answer2)),answer2);
title('$ x_1(t)*(x_2(t)*x_3(t))\ using\ matlab\ function $','Interpreter','latex');

subplot(3,3,[7,8,9]);
plot(linspace(-6,6,length(answer4)),answer4);
title('$ (x_1(t)*x_2(t))*x_3(t)\ using\ matlab\ function $','Interpreter','latex');

%% functions
function [answer]=convolution(x1,low_lim_x1,up_lim_x1,x2,low_lim_x2,up_lim_x2) 
    syms t;
    syms m;
    fs=5;
    answer=zeros(1,(up_lim_x2+up_lim_x1-low_lim_x2-low_lim_x1)*fs+1);
    i=1;
    for n=low_lim_x2+low_lim_x1:(1/fs):up_lim_x1+up_lim_x2
        answer(i)=int(x1(m)*x2(n-m),m,low_lim_x1,up_lim_x1);
        i=i+1;
    end
end