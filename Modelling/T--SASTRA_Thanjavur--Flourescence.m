clc;
close all;
t=0:1:7200;    %Time for Set1 equations - miRNA_antimiR incubation
x0=[100*10^-9,100*10^-9,0];  %initial values of miRNA< antimiR and complex
[t,x]= ode15s(@f, t, x0);  %Calling function containing ODES and their solution
figure()
plot(x);
xlabel('Time (s)')
ylabel('Concentration (M)')
legend('miRNA', 'antimiRNA', 'Complex')
com0=x(7201,3); %final value of complex
t1=0:1:480;  %time for transcription incubation
x0_1=0;      %initial value of CTS
[t1,x1]=ode15s(@h, t1, x0_1);
CTS0=x1(end); %Final value of CTS
t2=0:1:14400; %Time for Set2 equations - CTS_complex interactions
y0_2=[com0,CTS0,0,0,0,0];  %initial value of components in Set2
[t2,y]= ode15s(@g, t2, y0_2); 
figure()
plot(y)
xlabel('Time (s)')
ylabel('Concentration (M)')
legend('Complex','CTS','OTS','GFP','Mature GFP');
figure()
plot(y(:,4));
hold on;
plot(y(:,5));
legend('GFP', 'Mature GFP');
figure()
plot(y(:,6));
xlabel('Time (s)')
ylabel('Intensity')
function dx= f(~,x)  %Set1 reactions
kmiRantimiR_b=10^5;  %Parameters for Set1
kmiRantimiR_ub=1;
kdecay=3*10^-4;

 dx(1)=-kmiRantimiR_b*x(1)*x(2)-kdecay*x(1); %Equations for Set1
 dx(2)=-kmiRantimiR_b*x(1)*x(2)-kdecay*x(2);
 dx(3)=kmiRantimiR_b*x(1)*x(2);
 dx=dx(:);
end
function dy= g(~,y)  %Set2 reactions
kcomplexcts_b=10^5;  %Parameters for Set2
ktranscription=1.1*10^-3;
ktranslation=1.7*10^-2;
kdecay=3*10^-4;
kmat=0.0033;
GFPdecay=5*10^-5;
 dy(1)=-kcomplexcts_b*y(1)*y(2);  %Equations for Set2
 dy(2)=ktranscription*(20*10^-9)-kcomplexcts_b*y(1)*y(2)-kdecay*y(2);
 dy(3)=kcomplexcts_b*y(1)*y(2)-kdecay*y(3);
 dy(4)=ktranslation*y(3)-kmat*y(4);
 dy(5)=kmat*y(4)-GFPdecay*y(5);
 dy(6)=79.429*y(5)*10^3;
 dy=dy(:);
end

function dx1= h(~,~) %Transcriptional incubation reactions
ktranscription=1.1*10^-3;
 dx1(1)=ktranscription*(20*10^-9);
 dx1=dx1(:);
end