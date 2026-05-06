clc
clear all

%参数定义
R1=10; % 内径
R2=20; % 外径
H=5; % 高度
r_min=0.3; % 小球体最小半径
r_max=1; % 小球体最大半径
vol_ratio=0.3; % 小球体总体积与中空圆柱体体积比

%计算中空圆柱体体积
vol_cylinder=pi*H*(R2^2-R1^2);

%生成圆柱体模型
angle = linspace(0,2*pi);
Xc = [R1*cos(angle); R2*cos(angle); R2*cos(angle); R1*cos(angle)];
Yc = [R1*sin(angle); R2*sin(angle); R2*sin(angle); R1*sin(angle)];
Zc = [zeros(size(angle));zeros(size(angle));H*ones(size(angle));H*ones(size(angle))];

%计算小球体总体积
vol_balls=vol_ratio*vol_cylinder;

%初始化小球体数组
balls=[];

%循环生成小球体
while true
    %随机生成小球体半径
    r=r_min+(r_max-r_min)*rand();
    
    %随机生成小球体位置
    while true
        radii=normrnd((R1+R2)/2, (R2-R1)/6);
        theta=2*pi*rand();
        x=radii*cos(theta);
        y=radii*sin(theta);
        z=H*rand();
        
        if sqrt(x^2+y^2)>=R1+r && sqrt(x^2+y^2)<=R2-r && z+r<=H && z-r>=0
            break;
        end
    end
    
    %检查小球体是否与其他小球体重叠
    overlap=false;
    for i=1:size(balls,1)
        d=sqrt((x-balls(i,1))^2+(y-balls(i,2))^2+(z-balls(i,3))^2);
        if d<r+balls(i,4)
            overlap=true;
            break;
        end
    end
    
    %如果小球体不重叠，则添加到数组中
    if~overlap
        balls=[balls;x y z r];
    end
    
    %计算当前小球体总体积
    vol_balls_current=sum((4/3)*pi*balls(:,4).^3);
    
    %如果当前小球体总体积大于目标总体积，则退出循环
    if vol_balls_current>vol_balls
        break;
    end
end

%输出每个小球体的坐标和半径信息
fprintf('Total number of balls: %d\n', size(balls,1));
for i = 1:size(balls,1)
    fprintf('Ball %d: x=%.2f mm,y=%.2f mm, z=%.2f mm, radius=%.2f mm\n', i, balls(i,1), balls(i,2), balls(i,3), balls(i,4));
end

%绘制中空圆柱体和小球体
figure;
surf(Xc,Yc,Zc,'FaceAlpha',0.1,'EdgeAlpha',0.1);
hold on;
for i = 1:size(balls,1)
    [X,Y,Z] = sphere();
    X = X*balls(i,4)+balls(i,1);
    Y = Y*balls(i,4)+balls(i,2);
    Z = Z*balls(i,4)+balls(i,3);
    surf(X,Y,Z);
end
axis equal;
hold off;
xlabel('x');
ylabel('y');
zlabel('z');

save;