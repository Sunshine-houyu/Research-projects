clc;
clear;
addpath(genpath(pwd));
%DE是驱动端数据 FE是风扇端数据 BA是加速度数据 选择其中一个就行
load 97.mat  %正常
load 105.mat  %直径0.007英寸，转速为1797时的  内圈故障
load 118.mat   %直径0.007，转速为1797时的  滚动体故障
load 130.mat  %直径0.007，转速为1797时的  外圈故障
load 169.mat   %直径0.014英寸，转速为1797时的  内圈故障
load 185.mat    %直径0.014英寸，转速为1797时的  滚动体故障
load 197.mat    %直径0.014英寸，转速为1797时的  外圈故障
load 209.mat   %直径0.021英寸，转速为1797时的  内圈故障
load 222.mat  %直径0.021英寸，转速为1797时的  滚动体故障
load 234.mat  %直径0.021英寸，转速为1797时的 外圈故障
% 一共是10个状态，每个状态有120组样本，每个样本的数据量大小为：1×2048
w=1000;                  % w是滑动窗口的大小1000
s=2048;                  % 每个故障表示有2048个故障点
m = 120;            %每种故障有120个样本
D0=[];
for i =1:m
    D0 = [D0,X097_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D0 = D0';
D1=[];
for i =1:m
    D1 = [D1,X105_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D1 = D1';

D2=[];
for i =1:m
    D2 = [D2,X118_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D2 = D2';
D3=[];
for i =1:m
    D3 = [D3,X130_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D3 = D3';
D4=[];
for i =1:m
    D4 = [D4,X169_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D4 = D4';
D5=[];
for i =1:m
    D5 = [D5,X185_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D5 = D5';
D6=[];
for i =1:m
    D6 = [D6,X197_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D6 = D6';
D7=[];
for i =1:m
    D7 = [D7,X209_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D7 = D7';
D8=[];
for i =1:m
    D8 = [D8,X222_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D8 = D8';
D9=[];
for i =1:m
    D9 = [D9,X234_DE_time(1+w*(i-1):w*(i-1)+s)];
end
D9 = D9';
data = [D0;D1;D2;D3;D4;D5;D6;D7;D8;D9];
save data_total_1797.mat data
rmpath(genpath(pwd))