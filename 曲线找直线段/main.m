clear
clc
%%导入数据~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
load("data.mat")
x=zz;
y=cc;


%%计算关键点~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
num_key_point=4;	%关键点数
keyPoints=simplify_curve(x,y,num_key_point); 


%%结果绘制~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%原始数据
figure;
plot(x, y,'b-','LineWidth',1);
hold on;
xlabel('X');
ylabel('Y');

%绘制关键点并连接
plot(keyPoints.x,keyPoints.y,'ro','MarkerSize',8,'LineWidth', 2);
plot(keyPoints.x, keyPoints.y,'r--','LineWidth',2);
legend('原始曲线', '关键点', '拟合直线');
hold off;



