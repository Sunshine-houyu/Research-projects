clear;clc;
tic

L=1000;  
D=20; 
E=3.55e10;
I=pi*859.75;   
m=147500*pi;    
B=0.4;
BB=0;
f2=500;
CC=2;
cd=20000000;
AA=1.4;    
e=7; 
ee=0;
p=1000; 
CD=1;CL=0.7;Cm=1;CD1=0.05;
kexi=0.01;   
r=[0.0114573444572960; 
0.0115916843011330;
0.0121795814126480; 
0.0134724741671850; 
0.0153993460194940; 
0.0177203321378470; 
0.0202343504629790; 
0.0227899761509930; 
0.0251511920985520; 
0.0263971265514810];

P0=xlsread('1');    %读取冲击荷载

%Newmark-β法参数
dt=0.01;    %时间步长
gamma=0.5;beta=1/6;
a0=1/(beta*(dt)^2);
a1=gamma/(beta*dt);
a2=1/(beta*dt);
a3=(1/(2*beta))-1;
a4=(gamma/beta)-1;
a5=(dt/2)*((gamma/beta)-2);
a6=dt*(1-gamma);
a7=gamma*dt; %积分常数

t=0:dt:100;

c=2*kexi*(m*E*I*(r).^4).^0.5;   %竖向阻尼系数,是10*1的列向量

syms x;

%竖向振型计算

for i1=1:length(r)

K1=165637333.4;
K2=165637333.4;
K3=165637333.4;
K4=165637333.4;
K5=165637333.4;
K6=165637333.4;
K7=165637333.4;
K8=165637333.4;
K9=165637333.4;







S1=1.92e12;   
S2=1.92e12;
S3=1.92e12;
S4=1.92e12;
S5=1.92e12; 
S6=1.92e12;
S7=1.92e12;
S8=1.92e12; 
S9=1.92e12;
S10=1.92e12;






sh1=(1/2)*(exp(r(i1)*50)-exp(-r(i1)*50));
ch1=(1/2)*(exp(r(i1)*50)+exp(-r(i1)*50));

q1=[1,0,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1/(E*I)];


qq1=[1,0,0,0;
    0,1/(E*I),0,0;
    0,0,1,0;
    0,0,0,1];


HH2=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];


HH4=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];


HH6=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH8=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH10=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH12=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH14=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH16=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];

HH18=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -r(i1)*sin(r(i1)*50),r(i1)*cos(r(i1)*50),r(i1)*sh1,r(i1)*ch1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    E*I*(r(i1)^3)*sin(r(i1)*50),-E*I*(r(i1)^3)*cos(r(i1)*50),E*I*(r(i1)^3)*sh1,E*I*(r(i1)^3)*ch1];


H2=q1*HH2;%是为了去掉EI
H4=q1*HH4;
H6=q1*HH6;
H8=q1*HH8;
H10=q1*HH10;
H12=q1*HH12;
H14=q1*HH14;
H16=q1*HH16;
H18=q1*HH18;

FF2=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K1,-E*I*(r(i1)^3),K1,E*I*r(i1)^3];

FF4=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K2,-E*I*(r(i1)^3),K2,E*I*r(i1)^3];

FF6=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K3,-E*I*(r(i1)^3),K3,E*I*r(i1)^3];

FF8=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K4,-E*I*(r(i1)^3),K4,E*I*r(i1)^3];

FF10=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K5,-E*I*(r(i1)^3),K5,E*I*r(i1)^3];

FF12=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K6,-E*I*(r(i1)^3),K6,E*I*r(i1)^3];

FF14=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K7,-E*I*(r(i1)^3),K7,E*I*r(i1)^3];

FF16=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K8,-E*I*(r(i1)^3),K8,E*I*r(i1)^3];

FF18=[1,0,1,0;
    0,r(i1),0,r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    K9,-E*I*(r(i1)^3),K9,E*I*r(i1)^3];

F2=q1*FF2;
F4=q1*FF4;
F6=q1*FF6;
F8=q1*FF8;
F10=q1*FF10;
F12=q1*FF12;
F14=q1*FF14;
F16=q1*FF16;
F18=q1*FF18;

QQ1=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S1*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S1*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S1*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S1*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ3=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S2*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S2*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S2*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S2*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ5=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S3*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S3*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S3*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S3*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ7=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S4*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S4*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S4*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S4*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ9=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S5*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S5*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S5*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S5*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ11=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S6*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S6*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S6*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S6*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ13=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S7*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S7*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S7*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S7*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ15=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S8*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S8*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S8*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S8*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ17=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S9*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S9*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S9*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S9*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];


QQ19=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    S10*r(i1)*sin(r(i1)*50)+E*I*(r(i1)^2)*cos(r(i1)*50),-S10*r(i1)*cos(r(i1)*50)+E*I*(r(i1)^2)*sin(r(i1)*50),-S10*r(i1)*sh1-E*I*(r(i1)^2)*ch1,-S10*r(i1)*ch1-E*I*(r(i1)^2)*sh1;
    -(r(i1)^2)*cos(r(i1)*50),-(r(i1)^2)*sin(r(i1)*50),(r(i1)^2)*ch1,(r(i1)^2)*sh1;
    (r(i1)^3)*sin(r(i1)*50),-(r(i1)^3)*cos(r(i1)*50),(r(i1)^3)*sh1,(r(i1)^3)*ch1];




Q1=qq1*QQ1;%为了去掉EI
Q3=qq1*QQ3;
Q5=qq1*QQ5;
Q7=qq1*QQ7;
Q9=qq1*QQ9;
Q11=qq1*QQ11;
Q13=qq1*QQ13;
Q15=qq1*QQ15;
Q17=qq1*QQ17;
Q19=qq1*QQ19;

PP1=[1,0,1,0;
    0,-S1*r(i1),0,-S1*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP3=[1,0,1,0;
    0,-S2*r(i1),0,-S2*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP5=[1,0,1,0;
    0,-S3*r(i1),0,-S3*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP7=[1,0,1,0;
    0,-S4*r(i1),0,-S4*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP9=[1,0,1,0;
    0,-S5*r(i1),0,-S5*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP11=[1,0,1,0;
    0,-S6*r(i1),0,-S6*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP13=[1,0,1,0;
    0,-S7*r(i1),0,-S7*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP15=[1,0,1,0;
    0,-S8*r(i1),0,-S8*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP17=[1,0,1,0;
    0,-S9*r(i1),0,-S9*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

PP19=[1,0,1,0;
    0,-S10*r(i1),0,-S10*r(i1);
    -r(i1)^2,0,r(i1)^2,0;
    0,-r(i1)^3,0,r(i1)^3];

P1=qq1*PP1;%为了去掉EI
P3=qq1*PP3;
P5=qq1*PP5;
P7=qq1*PP7;
P9=qq1*PP9;
P11=qq1*PP11;
P13=qq1*PP13;
P15=qq1*PP15;
P17=qq1*PP17;
P19=qq1*PP19;

T=[cos(r(i1)*50),sin(r(i1)*50),ch1,sh1;
    -cos(r(i1)*50),-sin(r(i1)*50),ch1,sh1];

J1=P1\Q1;
J2=F2\H2;
J3=P3\Q3;
J4=F4\H4;
J5=P5\Q5;
J6=F6\H6;
J7=P7\Q7;
J8=F8\H8;
J9=P9\Q9;
J10=F10\H10;
J11=P11\Q11;
J12=F12\H12;
J13=P13\Q13;
J14=F14\H14;
J15=P15\Q15;
J16=F16\H16;
J17=P17\Q17;
J18=F18\H18;
J19=P19\Q19;





R=T*J19*J18*J17*J16*J15*J14*J13*J12*J11*J10*J9*J8*J7*J6*J5*J4*J3*J2*J1;

r11=R(1,1);r12=R(1,2);r13=R(1,3);r14=R(1,4);
r21=R(2,1);r22=R(2,2);r23=R(2,3);r24=R(2,4);

Q=[r12 r14;
    r22 r24];  %特征方程系数矩阵




A1=0;
B1=1;
C1=0;
D1=-(Q(1,1)*B1)/Q(1,2);
con1=[A1;B1;C1;D1];   %第1跨实常数矩阵
con2=J1*con1;    %第2跨实常数矩阵
con3=J2*con2;    %第3跨实常数矩阵
con4=J3*con3;    %第4跨实常数矩阵
con5=J4*con4;    %第5跨实常数矩阵
con6=J5*con5;    %第6跨实常数矩阵
con7=J6*con6;    %第7跨实常数矩阵
con8=J7*con7;    %第8跨实常数矩阵
con9=J8*con8;    %第9跨实常数矩阵
con10=J9*con9;    %第10跨实常数矩阵
con11=J10*con10;    %第11跨实常数矩阵
con12=J11*con11;    %第12跨实常数矩阵
con13=J12*con12;    %第13跨实常数矩阵
con14=J13*con13;    %第14跨实常数矩阵
con15=J14*con14;    %第15跨实常数矩阵
con16=J15*con15;    %第16跨实常数矩阵
con17=J16*con16;    %第17跨实常数矩阵
con18=J17*con17;    %第18跨实常数矩阵
con19=J18*con18;    %第19跨实常数矩阵
con20=J19*con19;    %第20跨实常数矩阵


%每一段模态函数中的三角函数和双曲函数
F1=[cos(r(i1)*x) sin(r(i1)*x) cosh(r(i1)*x) sinh(r(i1)*x)];
F2=[cos(r(i1)*(x-50)) sin(r(i1)*(x-50)) cosh(r(i1)*(x-50)) sinh(r(i1)*(x-50))];
F3=[cos(r(i1)*(x-100)) sin(r(i1)*(x-100)) cosh(r(i1)*(x-100)) sinh(r(i1)*(x-100))];
F4=[cos(r(i1)*(x-150)) sin(r(i1)*(x-150)) cosh(r(i1)*(x-150)) sinh(r(i1)*(x-150))];
F5=[cos(r(i1)*(x-200)) sin(r(i1)*(x-200)) cosh(r(i1)*(x-200)) sinh(r(i1)*(x-200))];
F6=[cos(r(i1)*(x-250)) sin(r(i1)*(x-250)) cosh(r(i1)*(x-250)) sinh(r(i1)*(x-250))];
F7=[cos(r(i1)*(x-300)) sin(r(i1)*(x-300)) cosh(r(i1)*(x-300)) sinh(r(i1)*(x-300))];
F8=[cos(r(i1)*(x-350)) sin(r(i1)*(x-350)) cosh(r(i1)*(x-350)) sinh(r(i1)*(x-350))];
F9=[cos(r(i1)*(x-400)) sin(r(i1)*(x-400)) cosh(r(i1)*(x-400)) sinh(r(i1)*(x-400))];
F10=[cos(r(i1)*(x-450)) sin(r(i1)*(x-450)) cosh(r(i1)*(x-450)) sinh(r(i1)*(x-450))];
F11=[cos(r(i1)*(x-500)) sin(r(i1)*(x-500)) cosh(r(i1)*(x-500)) sinh(r(i1)*(x-500))];
F12=[cos(r(i1)*(x-550)) sin(r(i1)*(x-550)) cosh(r(i1)*(x-550)) sinh(r(i1)*(x-550))];
F13=[cos(r(i1)*(x-600)) sin(r(i1)*(x-600)) cosh(r(i1)*(x-600)) sinh(r(i1)*(x-600))];
F14=[cos(r(i1)*(x-650)) sin(r(i1)*(x-650)) cosh(r(i1)*(x-650)) sinh(r(i1)*(x-650))];
F15=[cos(r(i1)*(x-700)) sin(r(i1)*(x-700)) cosh(r(i1)*(x-700)) sinh(r(i1)*(x-700))];
F16=[cos(r(i1)*(x-750)) sin(r(i1)*(x-750)) cosh(r(i1)*(x-750)) sinh(r(i1)*(x-750))];
F17=[cos(r(i1)*(x-800)) sin(r(i1)*(x-800)) cosh(r(i1)*(x-800)) sinh(r(i1)*(x-800))];
F18=[cos(r(i1)*(x-850)) sin(r(i1)*(x-850)) cosh(r(i1)*(x-850)) sinh(r(i1)*(x-850))];
F19=[cos(r(i1)*(x-900)) sin(r(i1)*(x-900)) cosh(r(i1)*(x-900)) sinh(r(i1)*(x-900))];
F20=[cos(r(i1)*(x-950)) sin(r(i1)*(x-950)) cosh(r(i1)*(x-950)) sinh(r(i1)*(x-950))];


ffy1(i1,1)=F1*con1;  %第1跨振型函数
ffy2(i1,1)=F2*con2;  %第2跨振型函数
ffy3(i1,1)=F3*con3;  %第3跨振型函数
ffy4(i1,1)=F4*con4;  %第4跨振型函数
ffy5(i1,1)=F5*con5;  %第5跨振型函数
ffy6(i1,1)=F6*con6;  %第6跨振型函数
ffy7(i1,1)=F7*con7;  %第7跨振型函数
ffy8(i1,1)=F8*con8;  %第8跨振型函数
ffy9(i1,1)=F9*con9;  %第9跨振型函数
ffy10(i1,1)=F10*con10;  %第10跨振型函数
ffy11(i1,1)=F11*con11;  %第11跨振型函数
ffy12(i1,1)=F12*con12;  %第12跨振型函数
ffy13(i1,1)=F13*con13;  %第13跨振型函数
ffy14(i1,1)=F14*con14;  %第14跨振型函数
ffy15(i1,1)=F15*con15;  %第15跨振型函数
ffy16(i1,1)=F16*con16;  %第16跨振型函数
ffy17(i1,1)=F17*con17;  %第17跨振型函数
ffy18(i1,1)=F18*con18;  %第18跨振型函数
ffy19(i1,1)=F19*con19;  %第19跨振型函数
ffy20(i1,1)=F20*con20;  %第20跨振型函数


fyy1(i1,1)=-ffy1(i1,1);%正的变负的
fyy2(i1,1)=-ffy2(i1,1);
fyy3(i1,1)=-ffy3(i1,1);
fyy4(i1,1)=-ffy4(i1,1);
fyy5(i1,1)=-ffy5(i1,1);
fyy6(i1,1)=-ffy6(i1,1);
fyy7(i1,1)=-ffy7(i1,1);
fyy8(i1,1)=-ffy8(i1,1);
fyy9(i1,1)=-ffy9(i1,1);
fyy10(i1,1)=-ffy10(i1,1);
fyy11(i1,1)=-ffy11(i1,1);
fyy12(i1,1)=-ffy12(i1,1);
fyy13(i1,1)=-ffy13(i1,1);
fyy14(i1,1)=-ffy14(i1,1);
fyy15(i1,1)=-ffy15(i1,1);
fyy16(i1,1)=-ffy16(i1,1);
fyy17(i1,1)=-ffy17(i1,1);
fyy18(i1,1)=-ffy18(i1,1);
fyy19(i1,1)=-ffy19(i1,1);
fyy20(i1,1)=-ffy20(i1,1);


%将符号表达式或函数转换为带有句柄的 MATLAB 函数
fyyy1=matlabFunction(fyy1(i1,1));
fyyy2=matlabFunction(fyy2(i1,1));
fyyy3=matlabFunction(fyy3(i1,1));
fyyy4=matlabFunction(fyy4(i1,1));
fyyy5=matlabFunction(fyy5(i1,1));
fyyy6=matlabFunction(fyy6(i1,1));
fyyy7=matlabFunction(fyy7(i1,1));
fyyy8=matlabFunction(fyy8(i1,1));
fyyy9=matlabFunction(fyy9(i1,1));
fyyy10=matlabFunction(fyy10(i1,1));
fyyy11=matlabFunction(fyy11(i1,1));
fyyy12=matlabFunction(fyy12(i1,1));
fyyy13=matlabFunction(fyy13(i1,1));
fyyy14=matlabFunction(fyy14(i1,1));
fyyy15=matlabFunction(fyy15(i1,1));
fyyy16=matlabFunction(fyy16(i1,1));
fyyy17=matlabFunction(fyy17(i1,1));
fyyy18=matlabFunction(fyy18(i1,1));
fyyy19=matlabFunction(fyy19(i1,1));
fyyy20=matlabFunction(fyy20(i1,1));




%提高计算精度，MaxFunEvals为允许的函数求值的最大次数，MaxIter为允许的迭代最大次数，
%TolX为最优值点间的误差阈值;TolFun为函数的误差阈值;
options=optimset('MaxFunEvals',10000,'MaxIter',10000,'TolX',1e-6);

%fminbnd函数为查找单变量函数在定区间上的最小值
%对于任何输入参数，[x,fval] = fminbnd(___) 返回目标函数在 fun 的解 x 处计算出的值。
[x1,fval1]=fminbnd(fyyy1,0,50,options);
[x2,fval2]=fminbnd(fyyy2,50,100,options);
[x3,fval3]=fminbnd(fyyy3,100,150,options);
[x4,fval4]=fminbnd(fyyy4,150,200,options);
[x5,fval5]=fminbnd(fyyy5,200,250,options);
[x6,fval6]=fminbnd(fyyy6,250,300,options);
[x7,fval7]=fminbnd(fyyy7,300,350,options);
[x8,fval8]=fminbnd(fyyy8,350,400,options);
[x9,fval9]=fminbnd(fyyy9,400,450,options);
[x10,fval10]=fminbnd(fyyy10,450,500,options);
[x11,fval11]=fminbnd(fyyy11,500,550,options);
[x12,fval12]=fminbnd(fyyy12,550,600,options);
[x13,fval13]=fminbnd(fyyy13,600,650,options);
[x14,fval14]=fminbnd(fyyy14,650,700,options);
[x15,fval15]=fminbnd(fyyy15,700,750,options);
[x16,fval16]=fminbnd(fyyy16,750,800,options);
[x17,fval17]=fminbnd(fyyy17,800,850,options);
[x18,fval18]=fminbnd(fyyy18,850,900,options);
[x19,fval19]=fminbnd(fyyy19,900,950,options);
[x20,fval20]=fminbnd(fyyy20,950,1000,options);


% [x9,fval9]=fminbnd(matlabFunction(ffy8(i1,1)),350,400,options);    %最后一段单独拿出来求最小值，仅悬臂端要考虑

maxfvaly=max([abs(fval1);abs(fval2);abs(fval3);abs(fval4);abs(fval5);abs(fval6);abs(fval7);abs(fval8);abs(fval9);abs(fval10);abs(fval11);
    abs(fval12);abs(fval13);abs(fval14);abs(fval15);abs(fval16);abs(fval17);abs(fval18);abs(fval19);abs(fval20)]);


%归一化的竖向振型函数

fy1(i1,1)=ffy1(i1,1)/maxfvaly;
fy2(i1,1)=ffy2(i1,1)/maxfvaly;
fy3(i1,1)=ffy3(i1,1)/maxfvaly;
fy4(i1,1)=ffy4(i1,1)/maxfvaly;
fy5(i1,1)=ffy5(i1,1)/maxfvaly;
fy6(i1,1)=ffy6(i1,1)/maxfvaly;
fy7(i1,1)=ffy7(i1,1)/maxfvaly;
fy8(i1,1)=ffy8(i1,1)/maxfvaly;
fy9(i1,1)=ffy9(i1,1)/maxfvaly;
fy10(i1,1)=ffy10(i1,1)/maxfvaly;
fy11n(i1,1)=ffy11(i1,1)/maxfvaly;
fy12n(i1,1)=ffy12(i1,1)/maxfvaly;
fy13n(i1,1)=ffy13(i1,1)/maxfvaly;
fy14n(i1,1)=ffy14(i1,1)/maxfvaly;
fy15n(i1,1)=ffy15(i1,1)/maxfvaly;
fy16n(i1,1)=ffy16(i1,1)/maxfvaly;
fy17n(i1,1)=ffy17(i1,1)/maxfvaly;
fy18n(i1,1)=ffy18(i1,1)/maxfvaly;
fy19n(i1,1)=ffy19(i1,1)/maxfvaly;
fy20(i1,1)=ffy20(i1,1)/maxfvaly;

end

% ?????%以上就是为了算出r

%第1段振型

fy11=matlabFunction(fy1(1,1));
fy12=matlabFunction(fy1(2,1));
fy13=matlabFunction(fy1(3,1));
fy14=matlabFunction(fy1(4,1));
fy15=matlabFunction(fy1(5,1));
fy16=matlabFunction(fy1(6,1));
fy17=matlabFunction(fy1(7,1));
fy18=matlabFunction(fy1(8,1));
fy19=matlabFunction(fy1(9,1));
fy110=matlabFunction(fy1(10,1));


%第2段振型

fy21=matlabFunction(fy2(1,1));
fy22=matlabFunction(fy2(2,1));
fy23=matlabFunction(fy2(3,1));
fy24=matlabFunction(fy2(4,1));
fy25=matlabFunction(fy2(5,1));
fy26=matlabFunction(fy2(6,1));
fy27=matlabFunction(fy2(7,1));
fy28=matlabFunction(fy2(8,1));
fy29=matlabFunction(fy2(9,1));
fy210=matlabFunction(fy2(10,1));



%第3段振型

fy31=matlabFunction(fy3(1,1));
fy32=matlabFunction(fy3(2,1));
fy33=matlabFunction(fy3(3,1));
fy34=matlabFunction(fy3(4,1));
fy35=matlabFunction(fy3(5,1));
fy36=matlabFunction(fy3(6,1));
fy37=matlabFunction(fy3(7,1));
fy38=matlabFunction(fy3(8,1));
fy39=matlabFunction(fy3(9,1));
fy310=matlabFunction(fy3(10,1));



%第4段振型

fy41=matlabFunction(fy4(1,1));
fy42=matlabFunction(fy4(2,1));
fy43=matlabFunction(fy4(3,1));
fy44=matlabFunction(fy4(4,1));
fy45=matlabFunction(fy4(5,1));
fy46=matlabFunction(fy4(6,1));
fy47=matlabFunction(fy4(7,1));
fy48=matlabFunction(fy4(8,1));
fy49=matlabFunction(fy4(9,1));
fy410=matlabFunction(fy4(10,1));



%第5段振型

fy51=matlabFunction(fy5(1,1));
fy52=matlabFunction(fy5(2,1));
fy53=matlabFunction(fy5(3,1));
fy54=matlabFunction(fy5(4,1));
fy55=matlabFunction(fy5(5,1));
fy56=matlabFunction(fy5(6,1));
fy57=matlabFunction(fy5(7,1));
fy58=matlabFunction(fy5(8,1));
fy59=matlabFunction(fy5(9,1));
fy510=matlabFunction(fy5(10,1));



%第6段振型

fy61=matlabFunction(fy6(1,1));
fy62=matlabFunction(fy6(2,1));
fy63=matlabFunction(fy6(3,1));
fy64=matlabFunction(fy6(4,1));
fy65=matlabFunction(fy6(5,1));
fy66=matlabFunction(fy6(6,1));
fy67=matlabFunction(fy6(7,1));
fy68=matlabFunction(fy6(8,1));
fy69=matlabFunction(fy6(9,1));
fy610=matlabFunction(fy6(10,1));




%第7段振型

fy71=matlabFunction(fy7(1,1));
fy72=matlabFunction(fy7(2,1));
fy73=matlabFunction(fy7(3,1));
fy74=matlabFunction(fy7(4,1));
fy75=matlabFunction(fy7(5,1));
fy76=matlabFunction(fy7(6,1));
fy77=matlabFunction(fy7(7,1));
fy78=matlabFunction(fy7(8,1));
fy79=matlabFunction(fy7(9,1));
fy710=matlabFunction(fy7(10,1));



%第8段振型

fy81=matlabFunction(fy8(1,1));
fy82=matlabFunction(fy8(2,1));
fy83=matlabFunction(fy8(3,1));
fy84=matlabFunction(fy8(4,1));
fy85=matlabFunction(fy8(5,1));
fy86=matlabFunction(fy8(6,1));
fy87=matlabFunction(fy8(7,1));
fy88=matlabFunction(fy8(8,1));
fy89=matlabFunction(fy8(9,1));
fy810=matlabFunction(fy8(10,1));


%第9段振型

fy91=matlabFunction(fy9(1,1));
fy92=matlabFunction(fy9(2,1));
fy93=matlabFunction(fy9(3,1));
fy94=matlabFunction(fy9(4,1));
fy95=matlabFunction(fy9(5,1));
fy96=matlabFunction(fy9(6,1));
fy97=matlabFunction(fy9(7,1));
fy98=matlabFunction(fy9(8,1));
fy99=matlabFunction(fy9(9,1));
fy910=matlabFunction(fy9(10,1));



%第10段振型

fy101=matlabFunction(fy10(1,1));
fy102=matlabFunction(fy10(2,1));
fy103=matlabFunction(fy10(3,1));
fy104=matlabFunction(fy10(4,1));
fy105=matlabFunction(fy10(5,1));
fy106=matlabFunction(fy10(6,1));
fy107=matlabFunction(fy10(7,1));
fy108=matlabFunction(fy10(8,1));
fy109=matlabFunction(fy10(9,1));
fy1010=matlabFunction(fy10(10,1));


%第11段振型

fy111=matlabFunction(fy11n(1,1));
fy112=matlabFunction(fy11n(2,1));
fy113=matlabFunction(fy11n(3,1));
fy114=matlabFunction(fy11n(4,1));
fy115=matlabFunction(fy11n(5,1));
fy116=matlabFunction(fy11n(6,1));
fy117=matlabFunction(fy11n(7,1));
fy118=matlabFunction(fy11n(8,1));
fy119=matlabFunction(fy11n(9,1));
fy1110=matlabFunction(fy11n(10,1));


%第12段振型

fy121=matlabFunction(fy12n(1,1));
fy122=matlabFunction(fy12n(2,1));
fy123=matlabFunction(fy12n(3,1));
fy124=matlabFunction(fy12n(4,1));
fy125=matlabFunction(fy12n(5,1));
fy126=matlabFunction(fy12n(6,1));
fy127=matlabFunction(fy12n(7,1));
fy128=matlabFunction(fy12n(8,1));
fy129=matlabFunction(fy12n(9,1));
fy1210=matlabFunction(fy12n(10,1));


%第13段振型

fy131=matlabFunction(fy13n(1,1));
fy132=matlabFunction(fy13n(2,1));
fy133=matlabFunction(fy13n(3,1));
fy134=matlabFunction(fy13n(4,1));
fy135=matlabFunction(fy13n(5,1));
fy136=matlabFunction(fy13n(6,1));
fy137=matlabFunction(fy13n(7,1));
fy138=matlabFunction(fy13n(8,1));
fy139=matlabFunction(fy13n(9,1));
fy1310=matlabFunction(fy13n(10,1));


%第14段振型

fy141=matlabFunction(fy14n(1,1));
fy142=matlabFunction(fy14n(2,1));
fy143=matlabFunction(fy14n(3,1));
fy144=matlabFunction(fy14n(4,1));
fy145=matlabFunction(fy14n(5,1));
fy146=matlabFunction(fy14n(6,1));
fy147=matlabFunction(fy14n(7,1));
fy148=matlabFunction(fy14n(8,1));
fy149=matlabFunction(fy14n(9,1));
fy1410=matlabFunction(fy14n(10,1));


%第15段振型

fy151=matlabFunction(fy15n(1,1));
fy152=matlabFunction(fy15n(2,1));
fy153=matlabFunction(fy15n(3,1));
fy154=matlabFunction(fy15n(4,1));
fy155=matlabFunction(fy15n(5,1));
fy156=matlabFunction(fy15n(6,1));
fy157=matlabFunction(fy15n(7,1));
fy158=matlabFunction(fy15n(8,1));
fy159=matlabFunction(fy15n(9,1));
fy1510=matlabFunction(fy15n(10,1));


%第16段振型

fy161=matlabFunction(fy16n(1,1));
fy162=matlabFunction(fy16n(2,1));
fy163=matlabFunction(fy16n(3,1));
fy164=matlabFunction(fy16n(4,1));
fy165=matlabFunction(fy16n(5,1));
fy166=matlabFunction(fy16n(6,1));
fy167=matlabFunction(fy16n(7,1));
fy168=matlabFunction(fy16n(8,1));
fy169=matlabFunction(fy16n(9,1));
fy1610=matlabFunction(fy16n(10,1));


%第17段振型

fy171=matlabFunction(fy17n(1,1));
fy172=matlabFunction(fy17n(2,1));
fy173=matlabFunction(fy17n(3,1));
fy174=matlabFunction(fy17n(4,1));
fy175=matlabFunction(fy17n(5,1));
fy176=matlabFunction(fy17n(6,1));
fy177=matlabFunction(fy17n(7,1));
fy178=matlabFunction(fy17n(8,1));
fy179=matlabFunction(fy17n(9,1));
fy1710=matlabFunction(fy17n(10,1));


%第18段振型

fy181=matlabFunction(fy18n(1,1));
fy182=matlabFunction(fy18n(2,1));
fy183=matlabFunction(fy18n(3,1));
fy184=matlabFunction(fy18n(4,1));
fy185=matlabFunction(fy18n(5,1));
fy186=matlabFunction(fy18n(6,1));
fy187=matlabFunction(fy18n(7,1));
fy188=matlabFunction(fy18n(8,1));
fy189=matlabFunction(fy18n(9,1));
fy1810=matlabFunction(fy18n(10,1));


%第19段振型

fy191=matlabFunction(fy19n(1,1));
fy192=matlabFunction(fy19n(2,1));
fy193=matlabFunction(fy19n(3,1));
fy194=matlabFunction(fy19n(4,1));
fy195=matlabFunction(fy19n(5,1));
fy196=matlabFunction(fy19n(6,1));
fy197=matlabFunction(fy19n(7,1));
fy198=matlabFunction(fy19n(8,1));
fy199=matlabFunction(fy19n(9,1));
fy1910=matlabFunction(fy19n(10,1));


%第20段振型

fy201=matlabFunction(fy20(1,1));
fy202=matlabFunction(fy20(2,1));
fy203=matlabFunction(fy20(3,1));
fy204=matlabFunction(fy20(4,1));
fy205=matlabFunction(fy20(5,1));
fy206=matlabFunction(fy20(6,1));
fy207=matlabFunction(fy20(7,1));
fy208=matlabFunction(fy20(8,1));
fy209=matlabFunction(fy20(9,1));
fy2010=matlabFunction(fy20(10,1));


%振型的平方，也就是为了后面正交性，做振型叠加法打下基础
aay11=@(x) (fy11(x)).^2;
aay12=@(x) (fy12(x)).^2;
aay13=@(x) (fy13(x)).^2;
aay14=@(x) (fy14(x)).^2;
aay15=@(x) (fy15(x)).^2;
aay16=@(x) (fy16(x)).^2;
aay17=@(x) (fy17(x)).^2;
aay18=@(x) (fy18(x)).^2;
aay19=@(x) (fy19(x)).^2;
aay110=@(x) (fy110(x)).^2;


aay21=@(x) (fy21(x)).^2;
aay22=@(x) (fy22(x)).^2;
aay23=@(x) (fy23(x)).^2;
aay24=@(x) (fy24(x)).^2;
aay25=@(x) (fy25(x)).^2;
aay26=@(x) (fy26(x)).^2;
aay27=@(x) (fy27(x)).^2;
aay28=@(x) (fy28(x)).^2;
aay29=@(x) (fy29(x)).^2;
aay210=@(x) (fy210(x)).^2;


aay31=@(x) (fy31(x)).^2;
aay32=@(x) (fy32(x)).^2;
aay33=@(x) (fy33(x)).^2;
aay34=@(x) (fy34(x)).^2;
aay35=@(x) (fy35(x)).^2;
aay36=@(x) (fy36(x)).^2;
aay37=@(x) (fy37(x)).^2;
aay38=@(x) (fy38(x)).^2;
aay39=@(x) (fy39(x)).^2;
aay310=@(x) (fy310(x)).^2;



aay41=@(x) (fy41(x)).^2;
aay42=@(x) (fy42(x)).^2;
aay43=@(x) (fy43(x)).^2;
aay44=@(x) (fy44(x)).^2;
aay45=@(x) (fy45(x)).^2;
aay46=@(x) (fy46(x)).^2;
aay47=@(x) (fy47(x)).^2;
aay48=@(x) (fy48(x)).^2;
aay49=@(x) (fy49(x)).^2;
aay410=@(x) (fy410(x)).^2;



aay51=@(x) (fy51(x)).^2;
aay52=@(x) (fy52(x)).^2;
aay53=@(x) (fy53(x)).^2;
aay54=@(x) (fy54(x)).^2;
aay55=@(x) (fy55(x)).^2;
aay56=@(x) (fy56(x)).^2;
aay57=@(x) (fy57(x)).^2;
aay58=@(x) (fy58(x)).^2;
aay59=@(x) (fy59(x)).^2;
aay510=@(x) (fy510(x)).^2;



aay61=@(x) (fy61(x)).^2;
aay62=@(x) (fy62(x)).^2;
aay63=@(x) (fy63(x)).^2;
aay64=@(x) (fy64(x)).^2;
aay65=@(x) (fy65(x)).^2;
aay66=@(x) (fy66(x)).^2;
aay67=@(x) (fy67(x)).^2;
aay68=@(x) (fy68(x)).^2;
aay69=@(x) (fy69(x)).^2;
aay610=@(x) (fy610(x)).^2;



aay71=@(x) (fy71(x)).^2;
aay72=@(x) (fy72(x)).^2;
aay73=@(x) (fy73(x)).^2;
aay74=@(x) (fy74(x)).^2;
aay75=@(x) (fy75(x)).^2;
aay76=@(x) (fy76(x)).^2;
aay77=@(x) (fy77(x)).^2;
aay78=@(x) (fy78(x)).^2;
aay79=@(x) (fy79(x)).^2;
aay710=@(x) (fy710(x)).^2;


aay81=@(x) (fy81(x)).^2;
aay82=@(x) (fy82(x)).^2;
aay83=@(x) (fy83(x)).^2;
aay84=@(x) (fy84(x)).^2;
aay85=@(x) (fy85(x)).^2;
aay86=@(x) (fy86(x)).^2;
aay87=@(x) (fy87(x)).^2;
aay88=@(x) (fy88(x)).^2;
aay89=@(x) (fy89(x)).^2;
aay810=@(x) (fy810(x)).^2;


aay91=@(x) (fy91(x)).^2;
aay92=@(x) (fy92(x)).^2;
aay93=@(x) (fy93(x)).^2;
aay94=@(x) (fy94(x)).^2;
aay95=@(x) (fy95(x)).^2;
aay96=@(x) (fy96(x)).^2;
aay97=@(x) (fy97(x)).^2;
aay98=@(x) (fy98(x)).^2;
aay99=@(x) (fy99(x)).^2;
aay910=@(x) (fy910(x)).^2;


aay101=@(x) (fy101(x)).^2;
aay102=@(x) (fy102(x)).^2;
aay103=@(x) (fy103(x)).^2;
aay104=@(x) (fy104(x)).^2;
aay105=@(x) (fy105(x)).^2;
aay106=@(x) (fy106(x)).^2;
aay107=@(x) (fy107(x)).^2;
aay108=@(x) (fy108(x)).^2;
aay109=@(x) (fy109(x)).^2;
aay1010=@(x) (fy1010(x)).^2;


aay111=@(x) (fy111(x)).^2;
aay112=@(x) (fy112(x)).^2;
aay113=@(x) (fy113(x)).^2;
aay114=@(x) (fy114(x)).^2;
aay115=@(x) (fy115(x)).^2;
aay116=@(x) (fy116(x)).^2;
aay117=@(x) (fy117(x)).^2;
aay118=@(x) (fy118(x)).^2;
aay119=@(x) (fy119(x)).^2;
aay1110=@(x) (fy1110(x)).^2;



aay121=@(x) (fy121(x)).^2;
aay122=@(x) (fy122(x)).^2;
aay123=@(x) (fy123(x)).^2;
aay124=@(x) (fy124(x)).^2;
aay125=@(x) (fy125(x)).^2;
aay126=@(x) (fy126(x)).^2;
aay127=@(x) (fy127(x)).^2;
aay128=@(x) (fy128(x)).^2;
aay129=@(x) (fy129(x)).^2;
aay1210=@(x) (fy1210(x)).^2;



aay131=@(x) (fy131(x)).^2;
aay132=@(x) (fy132(x)).^2;
aay133=@(x) (fy133(x)).^2;
aay134=@(x) (fy134(x)).^2;
aay135=@(x) (fy135(x)).^2;
aay136=@(x) (fy136(x)).^2;
aay137=@(x) (fy137(x)).^2;
aay138=@(x) (fy138(x)).^2;
aay139=@(x) (fy139(x)).^2;
aay1310=@(x) (fy1310(x)).^2;



aay141=@(x) (fy141(x)).^2;
aay142=@(x) (fy142(x)).^2;
aay143=@(x) (fy143(x)).^2;
aay144=@(x) (fy144(x)).^2;
aay145=@(x) (fy145(x)).^2;
aay146=@(x) (fy146(x)).^2;
aay147=@(x) (fy147(x)).^2;
aay148=@(x) (fy148(x)).^2;
aay149=@(x) (fy149(x)).^2;
aay1410=@(x) (fy1410(x)).^2;



aay151=@(x) (fy151(x)).^2;
aay152=@(x) (fy152(x)).^2;
aay153=@(x) (fy153(x)).^2;
aay154=@(x) (fy154(x)).^2;
aay155=@(x) (fy155(x)).^2;
aay156=@(x) (fy156(x)).^2;
aay157=@(x) (fy157(x)).^2;
aay158=@(x) (fy158(x)).^2;
aay159=@(x) (fy159(x)).^2;
aay1510=@(x) (fy1510(x)).^2;


aay161=@(x) (fy161(x)).^2;
aay162=@(x) (fy162(x)).^2;
aay163=@(x) (fy163(x)).^2;
aay164=@(x) (fy164(x)).^2;
aay165=@(x) (fy165(x)).^2;
aay166=@(x) (fy166(x)).^2;
aay167=@(x) (fy167(x)).^2;
aay168=@(x) (fy168(x)).^2;
aay169=@(x) (fy169(x)).^2;
aay1610=@(x) (fy1610(x)).^2;



aay171=@(x) (fy171(x)).^2;
aay172=@(x) (fy172(x)).^2;
aay173=@(x) (fy173(x)).^2;
aay174=@(x) (fy174(x)).^2;
aay175=@(x) (fy175(x)).^2;
aay176=@(x) (fy176(x)).^2;
aay177=@(x) (fy177(x)).^2;
aay178=@(x) (fy178(x)).^2;
aay179=@(x) (fy179(x)).^2;
aay1710=@(x) (fy1710(x)).^2;



aay181=@(x) (fy181(x)).^2;
aay182=@(x) (fy182(x)).^2;
aay183=@(x) (fy183(x)).^2;
aay184=@(x) (fy184(x)).^2;
aay185=@(x) (fy185(x)).^2;
aay186=@(x) (fy186(x)).^2;
aay187=@(x) (fy187(x)).^2;
aay188=@(x) (fy188(x)).^2;
aay189=@(x) (fy189(x)).^2;
aay1810=@(x) (fy1810(x)).^2;



aay191=@(x) (fy191(x)).^2;
aay192=@(x) (fy192(x)).^2;
aay193=@(x) (fy193(x)).^2;
aay194=@(x) (fy194(x)).^2;
aay195=@(x) (fy195(x)).^2;
aay196=@(x) (fy196(x)).^2;
aay197=@(x) (fy197(x)).^2;
aay198=@(x) (fy198(x)).^2;
aay199=@(x) (fy199(x)).^2;
aay1910=@(x) (fy1910(x)).^2;


aay201=@(x) (fy201(x)).^2;
aay202=@(x) (fy202(x)).^2;
aay203=@(x) (fy203(x)).^2;
aay204=@(x) (fy204(x)).^2;
aay205=@(x) (fy205(x)).^2;
aay206=@(x) (fy206(x)).^2;
aay207=@(x) (fy207(x)).^2;
aay208=@(x) (fy208(x)).^2;
aay209=@(x) (fy209(x)).^2;
aay2010=@(x) (fy2010(x)).^2;






ddy11=matlabFunction(diff(fy11,x,1));
ddy12=matlabFunction(diff(fy12,x,1));
ddy13=matlabFunction(diff(fy13,x,1));
ddy14=matlabFunction(diff(fy14,x,1));
ddy15=matlabFunction(diff(fy15,x,1));
ddy16=matlabFunction(diff(fy16,x,1));
ddy17=matlabFunction(diff(fy17,x,1));
ddy18=matlabFunction(diff(fy18,x,1));
ddy19=matlabFunction(diff(fy19,x,1));
ddy110=matlabFunction(diff(fy110,x,1));


%第2段

ddy21=matlabFunction(diff(fy21,x,1));
ddy22=matlabFunction(diff(fy22,x,1));
ddy23=matlabFunction(diff(fy23,x,1));
ddy24=matlabFunction(diff(fy24,x,1));
ddy25=matlabFunction(diff(fy25,x,1));
ddy26=matlabFunction(diff(fy26,x,1));
ddy27=matlabFunction(diff(fy27,x,1));
ddy28=matlabFunction(diff(fy28,x,1));
ddy29=matlabFunction(diff(fy29,x,1));
ddy210=matlabFunction(diff(fy210,x,1));


%第3段

ddy31=matlabFunction(diff(fy31,x,1));
ddy32=matlabFunction(diff(fy32,x,1));
ddy33=matlabFunction(diff(fy33,x,1));
ddy34=matlabFunction(diff(fy34,x,1));
ddy35=matlabFunction(diff(fy35,x,1));
ddy36=matlabFunction(diff(fy36,x,1));
ddy37=matlabFunction(diff(fy37,x,1));
ddy38=matlabFunction(diff(fy38,x,1));
ddy39=matlabFunction(diff(fy39,x,1));
ddy310=matlabFunction(diff(fy310,x,1));



%第4段

ddy41=matlabFunction(diff(fy41,x,1));
ddy42=matlabFunction(diff(fy42,x,1));
ddy43=matlabFunction(diff(fy43,x,1));
ddy44=matlabFunction(diff(fy44,x,1));
ddy45=matlabFunction(diff(fy45,x,1));
ddy46=matlabFunction(diff(fy46,x,1));
ddy47=matlabFunction(diff(fy47,x,1));
ddy48=matlabFunction(diff(fy48,x,1));
ddy49=matlabFunction(diff(fy49,x,1));
ddy410=matlabFunction(diff(fy410,x,1));




%第5段

ddy51=matlabFunction(diff(fy51,x,1));
ddy52=matlabFunction(diff(fy52,x,1));
ddy53=matlabFunction(diff(fy53,x,1));
ddy54=matlabFunction(diff(fy54,x,1));
ddy55=matlabFunction(diff(fy55,x,1));
ddy56=matlabFunction(diff(fy56,x,1));
ddy57=matlabFunction(diff(fy57,x,1));
ddy58=matlabFunction(diff(fy58,x,1));
ddy59=matlabFunction(diff(fy59,x,1));
ddy510=matlabFunction(diff(fy510,x,1));



%第6段

ddy61=matlabFunction(diff(fy61,x,1));
ddy62=matlabFunction(diff(fy62,x,1));
ddy63=matlabFunction(diff(fy63,x,1));
ddy64=matlabFunction(diff(fy64,x,1));
ddy65=matlabFunction(diff(fy65,x,1));
ddy66=matlabFunction(diff(fy66,x,1));
ddy67=matlabFunction(diff(fy67,x,1));
ddy68=matlabFunction(diff(fy68,x,1));
ddy69=matlabFunction(diff(fy69,x,1));
ddy610=matlabFunction(diff(fy610,x,1));



%第7段

ddy71=matlabFunction(diff(fy71,x,1));
ddy72=matlabFunction(diff(fy72,x,1));
ddy73=matlabFunction(diff(fy73,x,1));
ddy74=matlabFunction(diff(fy74,x,1));
ddy75=matlabFunction(diff(fy75,x,1));
ddy76=matlabFunction(diff(fy76,x,1));
ddy77=matlabFunction(diff(fy77,x,1));
ddy78=matlabFunction(diff(fy78,x,1));
ddy79=matlabFunction(diff(fy79,x,1));
ddy710=matlabFunction(diff(fy710,x,1));



%第8段

ddy81=matlabFunction(diff(fy81,x,1));
ddy82=matlabFunction(diff(fy82,x,1));
ddy83=matlabFunction(diff(fy83,x,1));
ddy84=matlabFunction(diff(fy84,x,1));
ddy85=matlabFunction(diff(fy85,x,1));
ddy86=matlabFunction(diff(fy86,x,1));
ddy87=matlabFunction(diff(fy87,x,1));
ddy88=matlabFunction(diff(fy88,x,1));
ddy89=matlabFunction(diff(fy89,x,1));
ddy810=matlabFunction(diff(fy810,x,1));


%第9段
ddy91=matlabFunction(diff(fy91,x,1));
ddy92=matlabFunction(diff(fy92,x,1));
ddy93=matlabFunction(diff(fy93,x,1));
ddy94=matlabFunction(diff(fy94,x,1));
ddy95=matlabFunction(diff(fy95,x,1));
ddy96=matlabFunction(diff(fy96,x,1));
ddy97=matlabFunction(diff(fy97,x,1));
ddy98=matlabFunction(diff(fy98,x,1));
ddy99=matlabFunction(diff(fy99,x,1));
ddy910=matlabFunction(diff(fy910,x,1));


%第10段

ddy101=matlabFunction(diff(fy101,x,1));
ddy102=matlabFunction(diff(fy102,x,1));
ddy103=matlabFunction(diff(fy103,x,1));
ddy104=matlabFunction(diff(fy104,x,1));
ddy105=matlabFunction(diff(fy105,x,1));
ddy106=matlabFunction(diff(fy106,x,1));
ddy107=matlabFunction(diff(fy107,x,1));
ddy108=matlabFunction(diff(fy108,x,1));
ddy109=matlabFunction(diff(fy109,x,1));
ddy1010=matlabFunction(diff(fy1010,x,1));


%第11段

ddy111=matlabFunction(diff(fy111,x,1));
ddy112=matlabFunction(diff(fy112,x,1));
ddy113=matlabFunction(diff(fy113,x,1));
ddy114=matlabFunction(diff(fy114,x,1));
ddy115=matlabFunction(diff(fy115,x,1));
ddy116=matlabFunction(diff(fy116,x,1));
ddy117=matlabFunction(diff(fy117,x,1));
ddy118=matlabFunction(diff(fy118,x,1));
ddy119=matlabFunction(diff(fy119,x,1));
ddy1110=matlabFunction(diff(fy1110,x,1));



%第12段

ddy121=matlabFunction(diff(fy121,x,1));
ddy122=matlabFunction(diff(fy122,x,1));
ddy123=matlabFunction(diff(fy123,x,1));
ddy124=matlabFunction(diff(fy124,x,1));
ddy125=matlabFunction(diff(fy125,x,1));
ddy126=matlabFunction(diff(fy126,x,1));
ddy127=matlabFunction(diff(fy127,x,1));
ddy128=matlabFunction(diff(fy128,x,1));
ddy129=matlabFunction(diff(fy129,x,1));
ddy1210=matlabFunction(diff(fy1210,x,1));




%第13段

ddy131=matlabFunction(diff(fy131,x,1));
ddy132=matlabFunction(diff(fy132,x,1));
ddy133=matlabFunction(diff(fy133,x,1));
ddy134=matlabFunction(diff(fy134,x,1));
ddy135=matlabFunction(diff(fy135,x,1));
ddy136=matlabFunction(diff(fy136,x,1));
ddy137=matlabFunction(diff(fy137,x,1));
ddy138=matlabFunction(diff(fy138,x,1));
ddy139=matlabFunction(diff(fy139,x,1));
ddy1310=matlabFunction(diff(fy1310,x,1));



%第14段

ddy141=matlabFunction(diff(fy141,x,1));
ddy142=matlabFunction(diff(fy142,x,1));
ddy143=matlabFunction(diff(fy143,x,1));
ddy144=matlabFunction(diff(fy144,x,1));
ddy145=matlabFunction(diff(fy145,x,1));
ddy146=matlabFunction(diff(fy146,x,1));
ddy147=matlabFunction(diff(fy147,x,1));
ddy148=matlabFunction(diff(fy148,x,1));
ddy149=matlabFunction(diff(fy149,x,1));
ddy1410=matlabFunction(diff(fy1410,x,1));



%第15段

ddy151=matlabFunction(diff(fy151,x,1));
ddy152=matlabFunction(diff(fy152,x,1));
ddy153=matlabFunction(diff(fy153,x,1));
ddy154=matlabFunction(diff(fy154,x,1));
ddy155=matlabFunction(diff(fy155,x,1));
ddy156=matlabFunction(diff(fy156,x,1));
ddy157=matlabFunction(diff(fy157,x,1));
ddy158=matlabFunction(diff(fy158,x,1));
ddy159=matlabFunction(diff(fy159,x,1));
ddy1510=matlabFunction(diff(fy1510,x,1));



%第16段

ddy161=matlabFunction(diff(fy161,x,1));
ddy162=matlabFunction(diff(fy162,x,1));
ddy163=matlabFunction(diff(fy163,x,1));
ddy164=matlabFunction(diff(fy164,x,1));
ddy165=matlabFunction(diff(fy165,x,1));
ddy166=matlabFunction(diff(fy166,x,1));
ddy167=matlabFunction(diff(fy167,x,1));
ddy168=matlabFunction(diff(fy168,x,1));
ddy169=matlabFunction(diff(fy169,x,1));
ddy1610=matlabFunction(diff(fy1610,x,1));




%第17段

ddy171=matlabFunction(diff(fy171,x,1));
ddy172=matlabFunction(diff(fy172,x,1));
ddy173=matlabFunction(diff(fy173,x,1));
ddy174=matlabFunction(diff(fy174,x,1));
ddy175=matlabFunction(diff(fy175,x,1));
ddy176=matlabFunction(diff(fy176,x,1));
ddy177=matlabFunction(diff(fy177,x,1));
ddy178=matlabFunction(diff(fy178,x,1));
ddy179=matlabFunction(diff(fy179,x,1));
ddy1710=matlabFunction(diff(fy1710,x,1));



%第18段

ddy181=matlabFunction(diff(fy181,x,1));
ddy182=matlabFunction(diff(fy182,x,1));
ddy183=matlabFunction(diff(fy183,x,1));
ddy184=matlabFunction(diff(fy184,x,1));
ddy185=matlabFunction(diff(fy185,x,1));
ddy186=matlabFunction(diff(fy186,x,1));
ddy187=matlabFunction(diff(fy187,x,1));
ddy188=matlabFunction(diff(fy188,x,1));
ddy189=matlabFunction(diff(fy189,x,1));
ddy1810=matlabFunction(diff(fy1810,x,1));



%第19段

ddy191=matlabFunction(diff(fy191,x,1));
ddy192=matlabFunction(diff(fy192,x,1));
ddy193=matlabFunction(diff(fy193,x,1));
ddy194=matlabFunction(diff(fy194,x,1));
ddy195=matlabFunction(diff(fy195,x,1));
ddy196=matlabFunction(diff(fy196,x,1));
ddy197=matlabFunction(diff(fy197,x,1));
ddy198=matlabFunction(diff(fy198,x,1));
ddy199=matlabFunction(diff(fy199,x,1));
ddy1910=matlabFunction(diff(fy1910,x,1));



%第20段

ddy201=matlabFunction(diff(fy201,x,1));
ddy202=matlabFunction(diff(fy202,x,1));
ddy203=matlabFunction(diff(fy203,x,1));
ddy204=matlabFunction(diff(fy204,x,1));
ddy205=matlabFunction(diff(fy205,x,1));
ddy206=matlabFunction(diff(fy206,x,1));
ddy207=matlabFunction(diff(fy207,x,1));
ddy208=matlabFunction(diff(fy208,x,1));
ddy209=matlabFunction(diff(fy209,x,1));
ddy2010=matlabFunction(diff(fy2010,x,1));

Alphay=[integral(aay11,0,50)+integral(aay21,50,100)+integral(aay31,100,150)+integral(aay41,150,200)+integral(aay51,200,250)+integral(aay61,250,300)+integral(aay71,300,350)+integral(aay81,350,400)+integral(aay91,400,450)+integral(aay101,450,500)+...
    integral(aay111,500,550)+integral(aay121,550,600)+integral(aay131,600,650)+integral(aay141,650,700)+integral(aay151,700,750)+integral(aay161,750,800)+integral(aay171,800,850)+integral(aay181,850,900)+integral(aay191,900,950)+integral(aay201,950,1000);
    integral(aay12,0,50)+integral(aay22,50,100)+integral(aay32,100,150)+integral(aay42,150,200)+integral(aay52,200,250)+integral(aay62,250,300)+integral(aay72,300,350)+integral(aay82,350,400)+integral(aay92,400,450)+integral(aay102,450,500)+...
    integral(aay112,500,550)+integral(aay122,550,600)+integral(aay132,600,650)+integral(aay142,650,700)+integral(aay152,700,750)+integral(aay162,750,800)+integral(aay172,800,850)+integral(aay182,850,900)+integral(aay192,900,950)+integral(aay202,950,1000);
    integral(aay13,0,50)+integral(aay23,50,100)+integral(aay33,100,150)+integral(aay43,150,200)+integral(aay53,200,250)+integral(aay63,250,300)+integral(aay73,300,350)+integral(aay83,350,400)+integral(aay93,400,450)+integral(aay103,450,500)+...
    integral(aay113,500,550)+integral(aay123,550,600)+integral(aay133,600,650)+integral(aay143,650,700)+integral(aay153,700,750)+integral(aay163,750,800)+integral(aay173,800,850)+integral(aay183,850,900)+integral(aay193,900,950)+integral(aay203,950,1000);
    integral(aay14,0,50)+integral(aay24,50,100)+integral(aay34,100,150)+integral(aay44,150,200)+integral(aay54,200,250)+integral(aay64,250,300)+integral(aay74,300,350)+integral(aay84,350,400)+integral(aay94,400,450)+integral(aay104,450,500)+...
    integral(aay114,500,550)+integral(aay124,550,600)+integral(aay134,600,650)+integral(aay144,650,700)+integral(aay154,700,750)+integral(aay164,750,800)+integral(aay174,800,850)+integral(aay184,850,900)+integral(aay194,900,950)+integral(aay204,950,1000);
    integral(aay15,0,50)+integral(aay25,50,100)+integral(aay35,100,150)+integral(aay45,150,200)+integral(aay55,200,250)+integral(aay65,250,300)+integral(aay75,300,350)+integral(aay85,350,400)+integral(aay95,400,450)+integral(aay105,450,500)+...
    integral(aay115,500,550)+integral(aay125,550,600)+integral(aay135,600,650)+integral(aay145,650,700)+integral(aay155,700,750)+integral(aay165,750,800)+integral(aay175,800,850)+integral(aay185,850,900)+integral(aay195,900,950)+integral(aay205,950,1000);
    integral(aay16,0,50)+integral(aay26,50,100)+integral(aay36,100,150)+integral(aay46,150,200)+integral(aay56,200,250)+integral(aay66,250,300)+integral(aay76,300,350)+integral(aay86,350,400)+integral(aay96,400,450)+integral(aay106,450,500)+...
    integral(aay116,500,550)+integral(aay126,550,600)+integral(aay136,600,650)+integral(aay146,650,700)+integral(aay156,700,750)+integral(aay166,750,800)+integral(aay176,800,850)+integral(aay186,850,900)+integral(aay196,900,950)+integral(aay206,950,1000);
    integral(aay17,0,50)+integral(aay27,50,100)+integral(aay37,100,150)+integral(aay47,150,200)+integral(aay57,200,250)+integral(aay67,250,300)+integral(aay77,300,350)+integral(aay87,350,400)+integral(aay97,400,450)+integral(aay107,450,500)+...
    integral(aay117,500,550)+integral(aay127,550,600)+integral(aay137,600,650)+integral(aay147,650,700)+integral(aay157,700,750)+integral(aay167,750,800)+integral(aay177,800,850)+integral(aay187,850,900)+integral(aay197,900,950)+integral(aay207,950,1000);
    integral(aay18,0,50)+integral(aay28,50,100)+integral(aay38,100,150)+integral(aay48,150,200)+integral(aay58,200,250)+integral(aay68,250,300)+integral(aay78,300,350)+integral(aay88,350,400)+integral(aay98,400,450)+integral(aay108,450,500)+...
    integral(aay118,500,550)+integral(aay128,550,600)+integral(aay138,600,650)+integral(aay148,650,700)+integral(aay158,700,750)+integral(aay168,750,800)+integral(aay178,800,850)+integral(aay188,850,900)+integral(aay198,900,950)+integral(aay208,950,1000);
    integral(aay19,0,50)+integral(aay29,50,100)+integral(aay39,100,150)+integral(aay49,150,200)+integral(aay59,200,250)+integral(aay69,250,300)+integral(aay79,300,350)+integral(aay89,350,400)+integral(aay99,400,450)+integral(aay109,450,500)+...
    integral(aay119,500,550)+integral(aay129,550,600)+integral(aay139,600,650)+integral(aay149,650,700)+integral(aay159,700,750)+integral(aay169,750,800)+integral(aay179,800,850)+integral(aay189,850,900)+integral(aay199,900,950)+integral(aay209,950,1000);
    integral(aay110,0,50)+integral(aay210,50,100)+integral(aay310,100,150)+integral(aay410,150,200)+integral(aay510,200,250)+integral(aay610,250,300)+integral(aay710,300,350)+integral(aay810,350,400)+integral(aay910,400,450)+integral(aay1010,450,500)+...
    integral(aay1110,500,550)+integral(aay1210,550,600)+integral(aay1310,600,650)+integral(aay1410,650,700)+integral(aay1510,700,750)+integral(aay1610,750,800)+integral(aay1710,800,850)+integral(aay1810,850,900)+integral(aay1910,900,950)+integral(aay2010,950,1000)];


Betay=[integral(fy11,0,50)+integral(fy21,50,100)+integral(fy31,100,150)+integral(fy41,150,200)+integral(fy51,200,250)+integral(fy61,250,300)+integral(fy71,300,350)+integral(fy81,350,400)+integral(fy91,400,450)+integral(fy101,450,500)+integral(fy111,500,550)+integral(fy121,550,600)+integral(fy131,600,650)+integral(fy141,650,700)+integral(fy151,700,750)+integral(fy161,750,800)+integral(fy171,800,850)+integral(fy181,850,900)+integral(fy191,900,950)+integral(fy201,950,1000);
    integral(fy12,0,50)+integral(fy22,50,100)+integral(fy32,100,150)+integral(fy42,150,200)+integral(fy52,200,250)+integral(fy62,250,300)+integral(fy72,300,350)+integral(fy82,350,400)+integral(fy92,400,450)+integral(fy102,450,500)+integral(fy112,500,550)+integral(fy122,550,600)+integral(fy132,600,650)+integral(fy142,650,700)+integral(fy152,700,750)+integral(fy162,750,800)+integral(fy172,800,850)+integral(fy182,850,900)+integral(fy192,900,950)+integral(fy202,950,1000);
    integral(fy13,0,50)+integral(fy23,50,100)+integral(fy33,100,150)+integral(fy43,150,200)+integral(fy53,200,250)+integral(fy63,250,300)+integral(fy73,300,350)+integral(fy83,350,400)+integral(fy93,400,450)+integral(fy103,450,500)+integral(fy113,500,550)+integral(fy123,550,600)+integral(fy133,600,650)+integral(fy143,650,700)+integral(fy153,700,750)+integral(fy163,750,800)+integral(fy173,800,850)+integral(fy183,850,900)+integral(fy193,900,950)+integral(fy203,950,1000);
    integral(fy14,0,50)+integral(fy24,50,100)+integral(fy34,100,150)+integral(fy44,150,200)+integral(fy54,200,250)+integral(fy64,250,300)+integral(fy74,300,350)+integral(fy84,350,400)+integral(fy94,400,450)+integral(fy104,450,500)+integral(fy114,500,550)+integral(fy124,550,600)+integral(fy134,600,650)+integral(fy144,650,700)+integral(fy154,700,750)+integral(fy164,750,800)+integral(fy174,800,850)+integral(fy184,850,900)+integral(fy194,900,950)+integral(fy204,950,1000);
    integral(fy15,0,50)+integral(fy25,50,100)+integral(fy35,100,150)+integral(fy45,150,200)+integral(fy55,200,250)+integral(fy65,250,300)+integral(fy75,300,350)+integral(fy85,350,400)+integral(fy95,400,450)+integral(fy105,450,500)+integral(fy115,500,550)+integral(fy125,550,600)+integral(fy135,600,650)+integral(fy145,650,700)+integral(fy155,700,750)+integral(fy165,750,800)+integral(fy175,800,850)+integral(fy185,850,900)+integral(fy195,900,950)+integral(fy205,950,1000);
    integral(fy16,0,50)+integral(fy26,50,100)+integral(fy36,100,150)+integral(fy46,150,200)+integral(fy56,200,250)+integral(fy66,250,300)+integral(fy76,300,350)+integral(fy86,350,400)+integral(fy96,400,450)+integral(fy106,450,500)+integral(fy116,500,550)+integral(fy126,550,600)+integral(fy136,600,650)+integral(fy146,650,700)+integral(fy156,700,750)+integral(fy166,750,800)+integral(fy176,800,850)+integral(fy186,850,900)+integral(fy196,900,950)+integral(fy206,950,1000);
    integral(fy17,0,50)+integral(fy27,50,100)+integral(fy37,100,150)+integral(fy47,150,200)+integral(fy57,200,250)+integral(fy67,250,300)+integral(fy77,300,350)+integral(fy87,350,400)+integral(fy97,400,450)+integral(fy107,450,500)+integral(fy117,500,550)+integral(fy127,550,600)+integral(fy137,600,650)+integral(fy147,650,700)+integral(fy157,700,750)+integral(fy167,750,800)+integral(fy177,800,850)+integral(fy187,850,900)+integral(fy197,900,950)+integral(fy207,950,1000);
    integral(fy18,0,50)+integral(fy28,50,100)+integral(fy38,100,150)+integral(fy48,150,200)+integral(fy58,200,250)+integral(fy68,250,300)+integral(fy78,300,350)+integral(fy88,350,400)+integral(fy98,400,450)+integral(fy108,450,500)+integral(fy118,500,550)+integral(fy128,550,600)+integral(fy138,600,650)+integral(fy148,650,700)+integral(fy158,700,750)+integral(fy168,750,800)+integral(fy178,800,850)+integral(fy188,850,900)+integral(fy198,900,950)+integral(fy208,950,1000);
    integral(fy19,0,50)+integral(fy29,50,100)+integral(fy39,100,150)+integral(fy49,150,200)+integral(fy59,200,250)+integral(fy69,250,300)+integral(fy79,300,350)+integral(fy89,350,400)+integral(fy99,400,450)+integral(fy109,450,500)+integral(fy119,500,550)+integral(fy129,550,600)+integral(fy139,600,650)+integral(fy149,650,700)+integral(fy159,700,750)+integral(fy169,750,800)+integral(fy179,800,850)+integral(fy189,850,900)+integral(fy199,900,950)+integral(fy209,950,1000);
    integral(fy110,0,50)+integral(fy210,50,100)+integral(fy310,100,150)+integral(fy410,150,200)+integral(fy510,200,250)+integral(fy610,250,300)+integral(fy710,300,350)+integral(fy810,350,400)+integral(fy910,400,450)+integral(fy1010,450,500)+integral(fy1110,500,550)+integral(fy1210,550,600)+integral(fy1310,600,650)+integral(fy1410,650,700)+integral(fy1510,700,750)+integral(fy1610,750,800)+integral(fy1710,800,850)+integral(fy1810,850,900)+integral(fy1910,900,950)+integral(fy2010,950,1000)];



M=diag([m*Alphay(1),m*Alphay(2),m*Alphay(3),m*Alphay(4),m*Alphay(5),m*Alphay(6),m*Alphay(7),m*Alphay(8),m*Alphay(9),m*Alphay(10)],0);    %质量矩阵

K1=diag([E*I*(r(1)^4)*Alphay(1),E*I*(r(2)^4)*Alphay(2),E*I*(r(3)^4)*Alphay(3),E*I*(r(4)^4)*Alphay(4),E*I*(r(5)^4)*Alphay(5),E*I*(r(6)^4)*Alphay(6),E*I*(r(7)^4)*Alphay(7),E*I*(r(8)^4)*Alphay(8),E*I*(r(9)^4)*Alphay(9),E*I*(r(10)^4)*Alphay(10)],0);    %刚度矩阵

C=diag([c(1)*Alphay(1),c(2)*Alphay(2),c(3)*Alphay(3),c(4)*Alphay(4),c(5)*Alphay(5),c(6)*Alphay(6),c(7)*Alphay(7),c(8)*Alphay(8),c(9)*Alphay(9),c(10)*Alphay(10)],0);    %阻尼矩阵



K2=K1+a0*M+a1*C;    %等效刚度矩阵

y(:,1)=[0;0;0;0;0;0;0;0;0;0];     %广义坐标初值
y1(:,1)=[0;0;0;0;0;0;0;0;0;0];    %广义坐标1阶导数初值
y2(:,1)=[0;0;0;0;0;0;0;0;0;0];    %广义坐标2阶导数初值



for i=1:10%length(t)-1
    tic
    i=i
    
    %竖向流体阻力
    
    %第1阶模态 暂时关闭
Dy1=0; 
Dy2=0;
Dy3=0;
Dy4=0;
Dy5=0;
Dy6=0;
Dy7=0;
Dy8=0;
Dy9=0;
Dy10=0;

     g1=(((abs((y1(1,i)*ddy11(x)+y1(2,i)*ddy12(x)+y1(3,i)*ddy13(x)+y1(4,i)*ddy14(x)+y1(5,i)*ddy15(x)+y1(6,i)*ddy16(x)+y1(7,i)*ddy17(x)+y1(8,i)*ddy18(x)+y1(9,i)*ddy19(x)+y1(10,i)*ddy110(x))))^1));
     g2=(((abs((y1(1,i)*ddy21(x)+y1(2,i)*ddy22(x)+y1(3,i)*ddy23(x)+y1(4,i)*ddy24(x)+y1(5,i)*ddy25(x)+y1(6,i)*ddy26(x)+y1(7,i)*ddy27(x)+y1(8,i)*ddy28(x)+y1(9,i)*ddy29(x)+y1(10,i)*ddy210(x))))^1));
     g3=(((abs((y1(1,i)*ddy31(x)+y1(2,i)*ddy32(x)+y1(3,i)*ddy33(x)+y1(4,i)*ddy34(x)+y1(5,i)*ddy35(x)+y1(6,i)*ddy36(x)+y1(7,i)*ddy37(x)+y1(8,i)*ddy38(x)+y1(9,i)*ddy39(x)+y1(10,i)*ddy310(x))))^1));
     g4=(((abs((y1(1,i)*ddy41(x)+y1(2,i)*ddy42(x)+y1(3,i)*ddy43(x)+y1(4,i)*ddy44(x)+y1(5,i)*ddy45(x)+y1(6,i)*ddy46(x)+y1(7,i)*ddy47(x)+y1(8,i)*ddy48(x)+y1(9,i)*ddy49(x)+y1(10,i)*ddy410(x))))^1));
     g5=(((abs((y1(1,i)*ddy51(x)+y1(2,i)*ddy52(x)+y1(3,i)*ddy53(x)+y1(4,i)*ddy54(x)+y1(5,i)*ddy55(x)+y1(6,i)*ddy56(x)+y1(7,i)*ddy57(x)+y1(8,i)*ddy58(x)+y1(9,i)*ddy59(x)+y1(10,i)*ddy510(x))))^1));
     g6=(((abs((y1(1,i)*ddy61(x)+y1(2,i)*ddy62(x)+y1(3,i)*ddy63(x)+y1(4,i)*ddy64(x)+y1(5,i)*ddy65(x)+y1(6,i)*ddy66(x)+y1(7,i)*ddy67(x)+y1(8,i)*ddy68(x)+y1(9,i)*ddy69(x)+y1(10,i)*ddy610(x))))^1));
     g7=(((abs((y1(1,i)*ddy71(x)+y1(2,i)*ddy72(x)+y1(3,i)*ddy73(x)+y1(4,i)*ddy74(x)+y1(5,i)*ddy75(x)+y1(6,i)*ddy76(x)+y1(7,i)*ddy77(x)+y1(8,i)*ddy78(x)+y1(9,i)*ddy79(x)+y1(10,i)*ddy710(x))))^1));
     g8=(((abs((y1(1,i)*ddy81(x)+y1(2,i)*ddy82(x)+y1(3,i)*ddy83(x)+y1(4,i)*ddy84(x)+y1(5,i)*ddy85(x)+y1(6,i)*ddy86(x)+y1(7,i)*ddy87(x)+y1(8,i)*ddy88(x)+y1(9,i)*ddy89(x)+y1(10,i)*ddy810(x))))^1));
     g9=(((abs((y1(1,i)*ddy91(x)+y1(2,i)*ddy92(x)+y1(3,i)*ddy93(x)+y1(4,i)*ddy94(x)+y1(5,i)*ddy95(x)+y1(6,i)*ddy96(x)+y1(7,i)*ddy97(x)+y1(8,i)*ddy98(x)+y1(9,i)*ddy99(x)+y1(10,i)*ddy910(x))))^1));
     g10=(((abs((y1(1,i)*ddy101(x)+y1(2,i)*ddy102(x)+y1(3,i)*ddy103(x)+y1(4,i)*ddy104(x)+y1(5,i)*ddy105(x)+y1(6,i)*ddy106(x)+y1(7,i)*ddy107(x)+y1(8,i)*ddy108(x)+y1(9,i)*ddy109(x)+y1(10,i)*ddy1010(x))))^1));
     g11=(((abs((y1(1,i)*ddy111(x)+y1(2,i)*ddy112(x)+y1(3,i)*ddy113(x)+y1(4,i)*ddy114(x)+y1(5,i)*ddy115(x)+y1(6,i)*ddy116(x)+y1(7,i)*ddy117(x)+y1(8,i)*ddy118(x)+y1(9,i)*ddy119(x)+y1(10,i)*ddy1110(x))))^1));
     g12=(((abs((y1(1,i)*ddy121(x)+y1(2,i)*ddy122(x)+y1(3,i)*ddy123(x)+y1(4,i)*ddy124(x)+y1(5,i)*ddy125(x)+y1(6,i)*ddy126(x)+y1(7,i)*ddy127(x)+y1(8,i)*ddy128(x)+y1(9,i)*ddy129(x)+y1(10,i)*ddy1210(x))))^1));
     g13=(((abs((y1(1,i)*ddy131(x)+y1(2,i)*ddy132(x)+y1(3,i)*ddy133(x)+y1(4,i)*ddy134(x)+y1(5,i)*ddy135(x)+y1(6,i)*ddy136(x)+y1(7,i)*ddy137(x)+y1(8,i)*ddy138(x)+y1(9,i)*ddy139(x)+y1(10,i)*ddy1310(x))))^1));
     g14=(((abs((y1(1,i)*ddy141(x)+y1(2,i)*ddy142(x)+y1(3,i)*ddy143(x)+y1(4,i)*ddy144(x)+y1(5,i)*ddy145(x)+y1(6,i)*ddy146(x)+y1(7,i)*ddy147(x)+y1(8,i)*ddy148(x)+y1(9,i)*ddy149(x)+y1(10,i)*ddy1410(x))))^1));
     g15=(((abs((y1(1,i)*ddy151(x)+y1(2,i)*ddy152(x)+y1(3,i)*ddy153(x)+y1(4,i)*ddy154(x)+y1(5,i)*ddy155(x)+y1(6,i)*ddy156(x)+y1(7,i)*ddy157(x)+y1(8,i)*ddy158(x)+y1(9,i)*ddy159(x)+y1(10,i)*ddy1510(x))))^1));
     g16=(((abs((y1(1,i)*ddy161(x)+y1(2,i)*ddy162(x)+y1(3,i)*ddy163(x)+y1(4,i)*ddy164(x)+y1(5,i)*ddy165(x)+y1(6,i)*ddy166(x)+y1(7,i)*ddy167(x)+y1(8,i)*ddy168(x)+y1(9,i)*ddy169(x)+y1(10,i)*ddy1610(x))))^1));
     g17=(((abs((y1(1,i)*ddy171(x)+y1(2,i)*ddy172(x)+y1(3,i)*ddy173(x)+y1(4,i)*ddy174(x)+y1(5,i)*ddy175(x)+y1(6,i)*ddy176(x)+y1(7,i)*ddy177(x)+y1(8,i)*ddy178(x)+y1(9,i)*ddy179(x)+y1(10,i)*ddy1710(x))))^1));
     g18=(((abs((y1(1,i)*ddy181(x)+y1(2,i)*ddy182(x)+y1(3,i)*ddy183(x)+y1(4,i)*ddy184(x)+y1(5,i)*ddy185(x)+y1(6,i)*ddy186(x)+y1(7,i)*ddy187(x)+y1(8,i)*ddy188(x)+y1(9,i)*ddy189(x)+y1(10,i)*ddy1810(x))))^1));
     g19=(((abs((y1(1,i)*ddy191(x)+y1(2,i)*ddy192(x)+y1(3,i)*ddy193(x)+y1(4,i)*ddy194(x)+y1(5,i)*ddy195(x)+y1(6,i)*ddy196(x)+y1(7,i)*ddy197(x)+y1(8,i)*ddy198(x)+y1(9,i)*ddy199(x)+y1(10,i)*ddy1910(x))))^1));
     g20=(((abs((y1(1,i)*ddy201(x)+y1(2,i)*ddy202(x)+y1(3,i)*ddy203(x)+y1(4,i)*ddy204(x)+y1(5,i)*ddy205(x)+y1(6,i)*ddy206(x)+y1(7,i)*ddy207(x)+y1(8,i)*ddy208(x)+y1(9,i)*ddy209(x)+y1(10,i)*ddy2010(x))))^1));
 
     ggggg1=(((((y1(1,i)*ddy11(x)+y1(2,i)*ddy12(x)+y1(3,i)*ddy13(x)+y1(4,i)*ddy14(x)+y1(5,i)*ddy15(x)+y1(6,i)*ddy16(x)+y1(7,i)*ddy17(x)+y1(8,i)*ddy18(x)+y1(9,i)*ddy19(x)+y1(10,i)*ddy110(x))))^1));
     ggggg2=(((((y1(1,i)*ddy21(x)+y1(2,i)*ddy22(x)+y1(3,i)*ddy23(x)+y1(4,i)*ddy24(x)+y1(5,i)*ddy25(x)+y1(6,i)*ddy26(x)+y1(7,i)*ddy27(x)+y1(8,i)*ddy28(x)+y1(9,i)*ddy29(x)+y1(10,i)*ddy210(x))))^1));
     ggggg3=(((((y1(1,i)*ddy31(x)+y1(2,i)*ddy32(x)+y1(3,i)*ddy33(x)+y1(4,i)*ddy34(x)+y1(5,i)*ddy35(x)+y1(6,i)*ddy36(x)+y1(7,i)*ddy37(x)+y1(8,i)*ddy38(x)+y1(9,i)*ddy39(x)+y1(10,i)*ddy310(x))))^1));
     ggggg4=(((((y1(1,i)*ddy41(x)+y1(2,i)*ddy42(x)+y1(3,i)*ddy43(x)+y1(4,i)*ddy44(x)+y1(5,i)*ddy45(x)+y1(6,i)*ddy46(x)+y1(7,i)*ddy47(x)+y1(8,i)*ddy48(x)+y1(9,i)*ddy49(x)+y1(10,i)*ddy410(x))))^1));
     ggggg5=(((((y1(1,i)*ddy51(x)+y1(2,i)*ddy52(x)+y1(3,i)*ddy53(x)+y1(4,i)*ddy54(x)+y1(5,i)*ddy55(x)+y1(6,i)*ddy56(x)+y1(7,i)*ddy57(x)+y1(8,i)*ddy58(x)+y1(9,i)*ddy59(x)+y1(10,i)*ddy510(x))))^1));
     ggggg6=(((((y1(1,i)*ddy61(x)+y1(2,i)*ddy62(x)+y1(3,i)*ddy63(x)+y1(4,i)*ddy64(x)+y1(5,i)*ddy65(x)+y1(6,i)*ddy66(x)+y1(7,i)*ddy67(x)+y1(8,i)*ddy68(x)+y1(9,i)*ddy69(x)+y1(10,i)*ddy610(x))))^1));
     ggggg7=(((((y1(1,i)*ddy71(x)+y1(2,i)*ddy72(x)+y1(3,i)*ddy73(x)+y1(4,i)*ddy74(x)+y1(5,i)*ddy75(x)+y1(6,i)*ddy76(x)+y1(7,i)*ddy77(x)+y1(8,i)*ddy78(x)+y1(9,i)*ddy79(x)+y1(10,i)*ddy710(x))))^1));
     ggggg8=(((((y1(1,i)*ddy81(x)+y1(2,i)*ddy82(x)+y1(3,i)*ddy83(x)+y1(4,i)*ddy84(x)+y1(5,i)*ddy85(x)+y1(6,i)*ddy86(x)+y1(7,i)*ddy87(x)+y1(8,i)*ddy88(x)+y1(9,i)*ddy89(x)+y1(10,i)*ddy810(x))))^1));
     ggggg9=(((((y1(1,i)*ddy91(x)+y1(2,i)*ddy92(x)+y1(3,i)*ddy93(x)+y1(4,i)*ddy94(x)+y1(5,i)*ddy95(x)+y1(6,i)*ddy96(x)+y1(7,i)*ddy97(x)+y1(8,i)*ddy98(x)+y1(9,i)*ddy99(x)+y1(10,i)*ddy910(x))))^1));
     ggggg10=(((((y1(1,i)*ddy101(x)+y1(2,i)*ddy102(x)+y1(3,i)*ddy103(x)+y1(4,i)*ddy104(x)+y1(5,i)*ddy105(x)+y1(6,i)*ddy106(x)+y1(7,i)*ddy107(x)+y1(8,i)*ddy108(x)+y1(9,i)*ddy109(x)+y1(10,i)*ddy1010(x))))^1));
     ggggg11=(((((y1(1,i)*ddy111(x)+y1(2,i)*ddy112(x)+y1(3,i)*ddy113(x)+y1(4,i)*ddy114(x)+y1(5,i)*ddy115(x)+y1(6,i)*ddy116(x)+y1(7,i)*ddy117(x)+y1(8,i)*ddy118(x)+y1(9,i)*ddy119(x)+y1(10,i)*ddy1110(x))))^1));
     ggggg12=(((((y1(1,i)*ddy121(x)+y1(2,i)*ddy122(x)+y1(3,i)*ddy123(x)+y1(4,i)*ddy124(x)+y1(5,i)*ddy125(x)+y1(6,i)*ddy126(x)+y1(7,i)*ddy127(x)+y1(8,i)*ddy128(x)+y1(9,i)*ddy129(x)+y1(10,i)*ddy1210(x))))^1));
     ggggg13=(((((y1(1,i)*ddy131(x)+y1(2,i)*ddy132(x)+y1(3,i)*ddy133(x)+y1(4,i)*ddy134(x)+y1(5,i)*ddy135(x)+y1(6,i)*ddy136(x)+y1(7,i)*ddy137(x)+y1(8,i)*ddy138(x)+y1(9,i)*ddy139(x)+y1(10,i)*ddy1310(x))))^1));
     ggggg14=(((((y1(1,i)*ddy141(x)+y1(2,i)*ddy142(x)+y1(3,i)*ddy143(x)+y1(4,i)*ddy144(x)+y1(5,i)*ddy145(x)+y1(6,i)*ddy146(x)+y1(7,i)*ddy147(x)+y1(8,i)*ddy148(x)+y1(9,i)*ddy149(x)+y1(10,i)*ddy1410(x))))^1));
     ggggg15=(((((y1(1,i)*ddy151(x)+y1(2,i)*ddy152(x)+y1(3,i)*ddy153(x)+y1(4,i)*ddy154(x)+y1(5,i)*ddy155(x)+y1(6,i)*ddy156(x)+y1(7,i)*ddy157(x)+y1(8,i)*ddy158(x)+y1(9,i)*ddy159(x)+y1(10,i)*ddy1510(x))))^1));
     ggggg16=(((((y1(1,i)*ddy161(x)+y1(2,i)*ddy162(x)+y1(3,i)*ddy163(x)+y1(4,i)*ddy164(x)+y1(5,i)*ddy165(x)+y1(6,i)*ddy166(x)+y1(7,i)*ddy167(x)+y1(8,i)*ddy168(x)+y1(9,i)*ddy169(x)+y1(10,i)*ddy1610(x))))^1));
     ggggg17=(((((y1(1,i)*ddy171(x)+y1(2,i)*ddy172(x)+y1(3,i)*ddy173(x)+y1(4,i)*ddy174(x)+y1(5,i)*ddy175(x)+y1(6,i)*ddy176(x)+y1(7,i)*ddy177(x)+y1(8,i)*ddy178(x)+y1(9,i)*ddy179(x)+y1(10,i)*ddy1710(x))))^1));
     ggggg18=(((((y1(1,i)*ddy181(x)+y1(2,i)*ddy182(x)+y1(3,i)*ddy183(x)+y1(4,i)*ddy184(x)+y1(5,i)*ddy185(x)+y1(6,i)*ddy186(x)+y1(7,i)*ddy187(x)+y1(8,i)*ddy188(x)+y1(9,i)*ddy189(x)+y1(10,i)*ddy1810(x))))^1));
     ggggg19=(((((y1(1,i)*ddy191(x)+y1(2,i)*ddy192(x)+y1(3,i)*ddy193(x)+y1(4,i)*ddy194(x)+y1(5,i)*ddy195(x)+y1(6,i)*ddy196(x)+y1(7,i)*ddy197(x)+y1(8,i)*ddy198(x)+y1(9,i)*ddy199(x)+y1(10,i)*ddy1910(x))))^1));
     ggggg20=(((((y1(1,i)*ddy201(x)+y1(2,i)*ddy202(x)+y1(3,i)*ddy203(x)+y1(4,i)*ddy204(x)+y1(5,i)*ddy205(x)+y1(6,i)*ddy206(x)+y1(7,i)*ddy207(x)+y1(8,i)*ddy208(x)+y1(9,i)*ddy209(x)+y1(10,i)*ddy2010(x))))^1));
 
     
     gg1=((g1)^B);
     gg2=((g2)^B);
     gg3=((g3)^B);
     gg4=((g4)^B);
     gg5=((g5)^B);
     gg6=((g6)^B);
     gg7=((g7)^B);
     gg8=((g8)^B);
     gg9=((g9)^B);
     gg10=((g10)^B);
     gg11=((g11)^B);
     gg12=((g12)^B);
     gg13=((g13)^B);
     gg14=((g14)^B);
     gg15=((g15)^B);
     gg16=((g16)^B);
     gg17=((g17)^B);
     gg18=((g18)^B);
     gg19=((g19)^B);
     gg20=((g20)^B);

     ggg1=(sign(ggggg1));
     ggg2=(sign(ggggg2));
     ggg3=(sign(ggggg3));
     ggg4=(sign(ggggg4));
     ggg5=(sign(ggggg5));
     ggg6=(sign(ggggg6));
     ggg7=(sign(ggggg7));
     ggg8=(sign(ggggg8));
     ggg9=(sign(ggggg9));
     ggg10=(sign(ggggg10));
     ggg11=(sign(ggggg11));
     ggg12=(sign(ggggg12));
     ggg13=(sign(ggggg13));
     ggg14=(sign(ggggg14));
     ggg15=(sign(ggggg15));
     ggg16=(sign(ggggg16));
     ggg17=(sign(ggggg17));
     ggg18=(sign(ggggg18));
     ggg19=(sign(ggggg19));
     ggg20=(sign(ggggg20));
     
     gggg1=ggg1*gg1;
     gggg2=ggg2*gg2;
     gggg3=ggg3*gg3;
     gggg4=ggg4*gg4;
     gggg5=ggg5*gg5;
     gggg6=ggg6*gg6;
     gggg7=ggg7*gg7;
     gggg8=ggg8*gg8;
     gggg9=ggg9*gg9;
     gggg10=ggg10*gg10;
     gggg11=ggg11*gg11;
     gggg12=ggg12*gg12;
     gggg13=ggg13*gg13;
     gggg14=ggg14*gg14;
     gggg15=ggg15*gg15;
     gggg16=ggg16*gg16;
     gggg17=ggg17*gg17;
     gggg18=ggg18*gg18;
     gggg19=ggg19*gg19;
     gggg20=ggg20*gg20;   
     
     dddy1=diff(gggg1,x,1);
     dddy2=diff(gggg2,x,1);
     dddy3=diff(gggg3,x,1);
     dddy4=diff(gggg4,x,1);
     dddy5=diff(gggg5,x,1);
     dddy6=diff(gggg6,x,1);
     dddy7=diff(gggg7,x,1);
     dddy8=diff(gggg8,x,1);
     dddy9=diff(gggg9,x,1);
     dddy10=diff(gggg10,x,1);
     dddy11=diff(gggg11,x,1);
     dddy12=diff(gggg12,x,1);
     dddy13=diff(gggg13,x,1);
     dddy14=diff(gggg14,x,1);
     dddy15=diff(gggg15,x,1);
     dddy16=diff(gggg16,x,1);
     dddy17=diff(gggg17,x,1);
     dddy18=diff(gggg18,x,1);
     dddy19=diff(gggg19,x,1);
     dddy20=diff(gggg20,x,1); 

     tmpv1 = (double(subs(dddy1,'x',47.5)));
     tmpv2 = (double(subs(dddy2,'x',52.5)));
     tmpv3 = (double(subs(dddy3,'x',147.5)));
     tmpv4 = (double(subs(dddy4,'x',152.5)));
     tmpv5 = (double(subs(dddy5,'x',247.5)));
     tmpv6 = (double(subs(dddy6,'x',252.5)));
     tmpv7 = (double(subs(dddy7,'x',347.5)));
     tmpv8 = (double(subs(dddy8,'x',352.5)));
     tmpv9 = (double(subs(dddy9,'x',447.5)));
     tmpv10 = (double(subs(dddy10,'x',452.5)));
     tmpv11 = (double(subs(dddy11,'x',547.5)));
     tmpv12 = (double(subs(dddy12,'x',552.5)));
     tmpv13 = (double(subs(dddy13,'x',647.5)));
     tmpv14 = (double(subs(dddy14,'x',652.5)));
     tmpv15 = (double(subs(dddy15,'x',747.5)));
     tmpv16 = (double(subs(dddy16,'x',752.5)));
     tmpv17 = (double(subs(dddy17,'x',847.5)));
     tmpv18 = (double(subs(dddy18,'x',852.5)));
     tmpv19 = (double(subs(dddy19,'x',947.5)));
     tmpv20 = (double(subs(dddy20,'x',952.5)));

 
    

P(1,1)=(-1*P0(i,2)*fy101(f2)+Dy1+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy11(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy21(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy31(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy41(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy51(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy61(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy71(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy81(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy91(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy101(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy111(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy121(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy131(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy141(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy151(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy161(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy171(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy181(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy191(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy201(952.5)*(tmpv20))*BB);
%     Dy2
    P(2,1)=(-1*P0(i,2)*fy102(f2)+Dy2+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy12(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy22(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy32(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy42(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy52(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy62(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy72(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy82(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy92(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy102(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy112(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy122(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy132(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy142(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy152(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy162(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy172(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy182(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy192(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy202(952.5)*(tmpv20))*BB);    
%     Dy3
    P(3,1)=(-1*P0(i,2)*fy103(f2)+Dy3+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy13(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy23(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy33(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy43(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy53(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy63(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy73(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy83(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy93(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy103(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy113(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy123(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy133(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy143(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy153(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy163(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy173(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy183(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy193(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy203(952.5)*(tmpv20))*BB);
%    Dy4 
    P(4,1)=(-1*P0(i,2)*fy104(f2)+Dy4+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy14(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy24(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy34(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy44(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy54(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy64(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy74(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy84(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy94(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy104(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy114(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy124(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy134(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy144(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy154(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy164(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy174(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy184(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy194(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy204(952.5)*(tmpv20))*BB);    
%    Dy5 
    P(5,1)=(-1*P0(i,2)*fy105(f2)+Dy5+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy15(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy25(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy35(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy45(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy55(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy65(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy75(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy85(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy95(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy105(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy115(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy125(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy135(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy145(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy155(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy165(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy175(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy185(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy195(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy205(952.5)*(tmpv20))*BB);    
%     Dy6
    P(6,1)=(-1*P0(i,2)*fy106(f2)+Dy6+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy16(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy26(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy36(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy46(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy56(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy66(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy76(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy86(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy96(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy106(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy116(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy126(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy136(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy146(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy156(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy166(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy176(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy186(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy196(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy206(952.5)*(tmpv20))*BB);    
%     Dy7
    P(7,1)=(-1*P0(i,2)*fy107(f2)+Dy7+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy17(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy27(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy37(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy47(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy57(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy67(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy77(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy87(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy97(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy107(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy117(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy127(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy137(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy147(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy157(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy167(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy177(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy187(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy197(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy207(952.5)*(tmpv20))*BB);    
    
%     Dy8
    P(8,1)=(-1*P0(i,2)*fy108(f2)+Dy8+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy18(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy28(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy38(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy48(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy58(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy68(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy78(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy88(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy98(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy108(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy118(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy128(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy138(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy148(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy158(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy168(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy178(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy188(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy198(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy208(952.5)*(tmpv20))*BB);    
    
%     Dy9
    P(9,1)=(-1*P0(i,2)*fy109(f2)+Dy9+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy19(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy29(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy39(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy49(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy59(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy69(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy79(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy89(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy99(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy109(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy119(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy129(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy139(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy149(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy159(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy169(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy179(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy189(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy199(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy209(952.5)*(tmpv20))*BB);    
    
    
%     Dy10
    P(10,1)=(-1*P0(i,2)*fy1010(f2)+Dy10+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy110(47.5)*(tmpv1))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy210(52.5)*(tmpv2))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy310(147.5)*(tmpv3))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy410(152.5)*(tmpv4))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy510(247.5)*(tmpv5))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy610(252.5)*(tmpv6))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy710(347.5)*(tmpv7))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy810(352.5)*(tmpv8))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy910(447.5)*(tmpv9))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1010(452.5)*(tmpv10))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1110(547.5)*(tmpv11))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1210(552.5)*(tmpv12))+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1310(647.5)*(tmpv13))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1410(652.5)*(tmpv14))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1510(747.5)*(tmpv15))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1610(752.5)*(tmpv16))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1710(847.5)*(tmpv17))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1810(852.5)*(tmpv18))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy1910(947.5)*(tmpv19))*BB+...
        CC*((8*cd*(e^AA)+4*cd*(ee)^2)*fy2010(952.5)*(tmpv20))*BB);  

   P1=P+M*(a0*y(:,i)+a2*y1(:,i)+a3*y2(:,i))+C*(a1*y(:,i)+a4*y1(:,i)+a5*y2(:,i));   %i时刻等效荷载
   
   y(:,i+1)=K2\P1;
   
   y2(:,i+1)=a0*(y(:,i+1)-y(:,i))-a2*(y1(:,i))-a3*(y2(:,i));
   
   y1(:,i+1)= y1(:,i)+a6*(y2(:,i))+a7*(y2(:,i+1));
  toc  

end

figure(2)   %管体x=550竖向位移时程曲线


yy1b=fy11(25)*y(1,:)+fy12(25)*y(2,:)+fy13(25)*y(3,:)+fy14(25)*y(4,:)+fy15(25)*y(5,:)+fy16(25)*y(6,:)+fy17(25)*y(7,:)+fy18(25)*y(8,:)+fy19(25)*y(9,:)+fy110(25)*y(10,:);
yy1=fy11(50)*y(1,:)+fy12(50)*y(2,:)+fy13(50)*y(3,:)+fy14(50)*y(4,:)+fy15(50)*y(5,:)+fy16(50)*y(6,:)+fy17(50)*y(7,:)+fy18(50)*y(8,:)+fy19(50)*y(9,:)+fy110(50)*y(10,:);

yy2b=fy21(75)*y(1,:)+fy22(75)*y(2,:)+fy23(75)*y(3,:)+fy24(75)*y(4,:)+fy25(75)*y(5,:)+fy26(75)*y(6,:)+fy27(75)*y(7,:)+fy28(75)*y(8,:)+fy29(75)*y(9,:)+fy210(75)*y(10,:);
yy2=fy21(100)*y(1,:)+fy22(100)*y(2,:)+fy23(100)*y(3,:)+fy24(100)*y(4,:)+fy25(100)*y(5,:)+fy26(100)*y(6,:)+fy27(100)*y(7,:)+fy28(100)*y(8,:)+fy29(100)*y(9,:)+fy210(100)*y(10,:);

yy3b=fy31(125)*y(1,:)+fy32(125)*y(2,:)+fy33(125)*y(3,:)+fy34(125)*y(4,:)+fy35(125)*y(5,:)+fy36(125)*y(6,:)+fy37(125)*y(7,:)+fy38(125)*y(8,:)+fy39(125)*y(9,:)+fy310(125)*y(10,:);
yy3=fy31(150)*y(1,:)+fy32(150)*y(2,:)+fy33(150)*y(3,:)+fy34(150)*y(4,:)+fy35(150)*y(5,:)+fy36(150)*y(6,:)+fy37(150)*y(7,:)+fy38(150)*y(8,:)+fy39(150)*y(9,:)+fy310(150)*y(10,:);

yy4b=fy41(175)*y(1,:)+fy42(175)*y(2,:)+fy43(175)*y(3,:)+fy44(175)*y(4,:)+fy45(175)*y(5,:)+fy46(175)*y(6,:)+fy47(175)*y(7,:)+fy48(175)*y(8,:)+fy49(175)*y(9,:)+fy410(175)*y(10,:);
yy4=fy41(200)*y(1,:)+fy42(200)*y(2,:)+fy43(200)*y(3,:)+fy44(200)*y(4,:)+fy45(200)*y(5,:)+fy46(200)*y(6,:)+fy47(200)*y(7,:)+fy48(200)*y(8,:)+fy49(200)*y(9,:)+fy410(200)*y(10,:);

yy5b=fy51(225)*y(1,:)+fy52(225)*y(2,:)+fy53(225)*y(3,:)+fy54(225)*y(4,:)+fy55(225)*y(5,:)+fy56(225)*y(6,:)+fy57(225)*y(7,:)+fy58(225)*y(8,:)+fy59(225)*y(9,:)+fy510(225)*y(10,:);
yy5=fy51(250)*y(1,:)+fy52(250)*y(2,:)+fy53(250)*y(3,:)+fy54(250)*y(4,:)+fy55(250)*y(5,:)+fy56(250)*y(6,:)+fy57(250)*y(7,:)+fy58(250)*y(8,:)+fy59(250)*y(9,:)+fy510(250)*y(10,:);

yy6b=fy61(275)*y(1,:)+fy62(275)*y(2,:)+fy63(275)*y(3,:)+fy64(275)*y(4,:)+fy65(275)*y(5,:)+fy66(275)*y(6,:)+fy67(275)*y(7,:)+fy68(275)*y(8,:)+fy69(275)*y(9,:)+fy610(275)*y(10,:);
yy6=fy61(300)*y(1,:)+fy62(300)*y(2,:)+fy63(300)*y(3,:)+fy64(300)*y(4,:)+fy65(300)*y(5,:)+fy66(300)*y(6,:)+fy67(300)*y(7,:)+fy68(300)*y(8,:)+fy69(300)*y(9,:)+fy610(300)*y(10,:);

yy7b=fy71(325)*y(1,:)+fy72(325)*y(2,:)+fy73(325)*y(3,:)+fy74(325)*y(4,:)+fy75(325)*y(5,:)+fy76(325)*y(6,:)+fy77(325)*y(7,:)+fy78(325)*y(8,:)+fy79(325)*y(9,:)+fy710(325)*y(10,:);
yy7=fy71(350)*y(1,:)+fy72(350)*y(2,:)+fy73(350)*y(3,:)+fy74(350)*y(4,:)+fy75(350)*y(5,:)+fy76(350)*y(6,:)+fy77(350)*y(7,:)+fy78(350)*y(8,:)+fy79(350)*y(9,:)+fy710(350)*y(10,:);

yy8b=fy81(375)*y(1,:)+fy82(375)*y(2,:)+fy83(375)*y(3,:)+fy84(375)*y(4,:)+fy85(375)*y(5,:)+fy86(375)*y(6,:)+fy87(375)*y(7,:)+fy88(375)*y(8,:)+fy89(375)*y(9,:)+fy810(375)*y(10,:);
yy8=fy81(400)*y(1,:)+fy82(400)*y(2,:)+fy83(400)*y(3,:)+fy84(400)*y(4,:)+fy85(400)*y(5,:)+fy86(400)*y(6,:)+fy87(400)*y(7,:)+fy88(400)*y(8,:)+fy89(400)*y(9,:)+fy810(400)*y(10,:);

yy9b=fy91(425)*y(1,:)+fy92(425)*y(2,:)+fy93(425)*y(3,:)+fy94(425)*y(4,:)+fy95(425)*y(5,:)+fy96(425)*y(6,:)+fy97(425)*y(7,:)+fy98(425)*y(8,:)+fy99(425)*y(9,:)+fy910(425)*y(10,:);
yy9=fy91(450)*y(1,:)+fy92(450)*y(2,:)+fy93(450)*y(3,:)+fy94(450)*y(4,:)+fy95(450)*y(5,:)+fy96(450)*y(6,:)+fy97(450)*y(7,:)+fy98(450)*y(8,:)+fy99(450)*y(9,:)+fy910(450)*y(10,:);

yy10b=fy101(475)*y(1,:)+fy102(475)*y(2,:)+fy103(475)*y(3,:)+fy104(475)*y(4,:)+fy105(475)*y(5,:)+fy106(475)*y(6,:)+fy107(475)*y(7,:)+fy108(475)*y(8,:)+fy109(475)*y(9,:)+fy1010(475)*y(10,:);
yy10=fy101(500)*y(1,:)+fy102(500)*y(2,:)+fy103(500)*y(3,:)+fy104(500)*y(4,:)+fy105(500)*y(5,:)+fy106(500)*y(6,:)+fy107(500)*y(7,:)+fy108(500)*y(8,:)+fy109(500)*y(9,:)+fy1010(500)*y(10,:);

yy11b=fy111(525)*y(1,:)+fy112(525)*y(2,:)+fy113(525)*y(3,:)+fy114(525)*y(4,:)+fy115(525)*y(5,:)+fy116(525)*y(6,:)+fy117(525)*y(7,:)+fy118(525)*y(8,:)+fy119(525)*y(9,:)+fy1110(525)*y(10,:);         %x=550竖向位移时程曲线
yy11=fy111(550)*y(1,:)+fy112(550)*y(2,:)+fy113(550)*y(3,:)+fy114(550)*y(4,:)+fy115(550)*y(5,:)+fy116(550)*y(6,:)+fy117(550)*y(7,:)+fy118(550)*y(8,:)+fy119(550)*y(9,:)+fy1110(550)*y(10,:);         %x=550竖向位移时程曲线

yy12b=fy121(575)*y(1,:)+fy122(575)*y(2,:)+fy123(575)*y(3,:)+fy124(575)*y(4,:)+fy125(575)*y(5,:)+fy126(575)*y(6,:)+fy127(575)*y(7,:)+fy128(575)*y(8,:)+fy129(575)*y(9,:)+fy1210(575)*y(10,:);         %x=550竖向位移时程曲线
yy12=fy121(600)*y(1,:)+fy122(600)*y(2,:)+fy123(600)*y(3,:)+fy124(600)*y(4,:)+fy125(600)*y(5,:)+fy126(600)*y(6,:)+fy127(600)*y(7,:)+fy128(600)*y(8,:)+fy129(600)*y(9,:)+fy1210(600)*y(10,:);         %x=550竖向位移时程曲线

yy13b=fy131(625)*y(1,:)+fy132(625)*y(2,:)+fy133(625)*y(3,:)+fy134(625)*y(4,:)+fy135(625)*y(5,:)+fy136(625)*y(6,:)+fy137(625)*y(7,:)+fy138(625)*y(8,:)+fy139(625)*y(9,:)+fy1310(625)*y(10,:);
yy13=fy131(650)*y(1,:)+fy132(650)*y(2,:)+fy133(650)*y(3,:)+fy134(650)*y(4,:)+fy135(650)*y(5,:)+fy136(650)*y(6,:)+fy137(650)*y(7,:)+fy138(650)*y(8,:)+fy139(650)*y(9,:)+fy1310(650)*y(10,:);

yy14b=fy141(675)*y(1,:)+fy142(675)*y(2,:)+fy143(675)*y(3,:)+fy144(675)*y(4,:)+fy145(675)*y(5,:)+fy146(675)*y(6,:)+fy147(675)*y(7,:)+fy148(675)*y(8,:)+fy149(675)*y(9,:)+fy1410(675)*y(10,:);
yy14=fy141(700)*y(1,:)+fy142(700)*y(2,:)+fy143(700)*y(3,:)+fy144(700)*y(4,:)+fy145(700)*y(5,:)+fy146(700)*y(6,:)+fy147(700)*y(7,:)+fy148(700)*y(8,:)+fy149(700)*y(9,:)+fy1410(700)*y(10,:);

yy15b=fy151(725)*y(1,:)+fy152(725)*y(2,:)+fy153(725)*y(3,:)+fy154(725)*y(4,:)+fy155(725)*y(5,:)+fy156(725)*y(6,:)+fy157(725)*y(7,:)+fy158(725)*y(8,:)+fy159(725)*y(9,:)+fy1510(725)*y(10,:);
yy15=fy151(750)*y(1,:)+fy152(750)*y(2,:)+fy153(750)*y(3,:)+fy154(750)*y(4,:)+fy155(750)*y(5,:)+fy156(750)*y(6,:)+fy157(750)*y(7,:)+fy158(750)*y(8,:)+fy159(750)*y(9,:)+fy1510(750)*y(10,:);

yy16b=fy161(775)*y(1,:)+fy162(775)*y(2,:)+fy163(775)*y(3,:)+fy164(775)*y(4,:)+fy165(775)*y(5,:)+fy166(775)*y(6,:)+fy167(775)*y(7,:)+fy168(775)*y(8,:)+fy169(775)*y(9,:)+fy1610(775)*y(10,:);
yy16=fy161(800)*y(1,:)+fy162(800)*y(2,:)+fy163(800)*y(3,:)+fy164(800)*y(4,:)+fy165(800)*y(5,:)+fy166(800)*y(6,:)+fy167(800)*y(7,:)+fy168(800)*y(8,:)+fy169(800)*y(9,:)+fy1610(800)*y(10,:);

yy17b=fy171(825)*y(1,:)+fy172(825)*y(2,:)+fy173(825)*y(3,:)+fy174(825)*y(4,:)+fy175(825)*y(5,:)+fy176(825)*y(6,:)+fy177(825)*y(7,:)+fy178(825)*y(8,:)+fy179(825)*y(9,:)+fy1710(825)*y(10,:);
yy17=fy171(850)*y(1,:)+fy172(850)*y(2,:)+fy173(850)*y(3,:)+fy174(850)*y(4,:)+fy175(850)*y(5,:)+fy176(850)*y(6,:)+fy177(850)*y(7,:)+fy178(850)*y(8,:)+fy179(850)*y(9,:)+fy1710(850)*y(10,:);

yy18b=fy181(875)*y(1,:)+fy182(875)*y(2,:)+fy183(875)*y(3,:)+fy184(875)*y(4,:)+fy185(875)*y(5,:)+fy186(875)*y(6,:)+fy187(875)*y(7,:)+fy188(875)*y(8,:)+fy189(875)*y(9,:)+fy1810(875)*y(10,:);
yy18=fy181(900)*y(1,:)+fy182(900)*y(2,:)+fy183(900)*y(3,:)+fy184(900)*y(4,:)+fy185(900)*y(5,:)+fy186(900)*y(6,:)+fy187(900)*y(7,:)+fy188(900)*y(8,:)+fy189(900)*y(9,:)+fy1810(900)*y(10,:);

yy19b=fy191(925)*y(1,:)+fy192(925)*y(2,:)+fy193(925)*y(3,:)+fy194(925)*y(4,:)+fy195(925)*y(5,:)+fy196(925)*y(6,:)+fy197(925)*y(7,:)+fy198(925)*y(8,:)+fy199(925)*y(9,:)+fy1910(925)*y(10,:);
yy19=fy191(950)*y(1,:)+fy192(950)*y(2,:)+fy193(950)*y(3,:)+fy194(950)*y(4,:)+fy195(950)*y(5,:)+fy196(950)*y(6,:)+fy197(950)*y(7,:)+fy198(950)*y(8,:)+fy199(950)*y(9,:)+fy1910(950)*y(10,:);

yy20b=fy201(975)*y(1,:)+fy202(975)*y(2,:)+fy203(975)*y(3,:)+fy204(975)*y(4,:)+fy205(975)*y(5,:)+fy206(975)*y(6,:)+fy207(975)*y(7,:)+fy208(975)*y(8,:)+fy209(975)*y(9,:)+fy2010(975)*y(10,:);
yy20=fy201(1000)*y(1,:)+fy202(1000)*y(2,:)+fy203(1000)*y(3,:)+fy204(1000)*y(4,:)+fy205(1000)*y(5,:)+fy206(1000)*y(6,:)+fy207(1000)*y(7,:)+fy208(1000)*y(8,:)+fy209(1000)*y(9,:)+fy2010(1000)*y(10,:);

yyy=[yy1b;yy1;yy2b;yy2;yy3b;yy3;yy4b;yy4;yy5b;yy5;yy6b;yy6;yy7b;yy7;yy8b;yy8;yy9b;yy9;yy10b;yy10;yy11b;yy11;yy12b;yy12;yy13b;yy13;yy14b;yy14;yy15b;yy15;yy16b;yy16;yy17b;yy17;yy18b;yy18;yy19b;yy19;yy20b;yy20]';


toc