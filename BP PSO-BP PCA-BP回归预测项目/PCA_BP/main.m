clc
clear
load('Result.mat');

%% V. 评价指标
%%  均方根误差 RMSE
error1 = sqrt(sum((T_sim1 - T_train).^2)./M);
error2 = sqrt(sum((T_test - T_sim2).^2)./N);

%%
%决定系数
R1 = 1 - (sum((T_sim1 - T_train).^2) / sum((T_sim1 - mean(T_train)).^2));

R2 = 1 - (sum((T_sim2 - T_test).^2) / sum((T_sim2 - mean(T_test)).^2));

%%
%均方误差 MSE
mse1 = sum((T_sim1 - T_train).^2)./M;
mse2 = sum((T_sim2 - T_test).^2)./N;
%%
%RPD 剩余预测残差
SE1=std(T_sim1-T_train);
RPD=std(T_train)/SE1;

SE=std(T_sim2-T_test);
RPD1=std(T_test)/SE;
%% 平均绝对误差MAE
MAE1 = mean(abs(T_train - T_sim1));
MAE2 = mean(abs(T_test - T_sim2));
%% 平均绝对百分比误差MAPE
MAPE1 = mean(abs((T_train - T_sim1)./T_train));
MAPE2 = mean(abs((T_test - T_sim2)./T_test));
%%  训练集绘图
figure
%plot(1:M,T_train,'r-*',1:M,T_sim1,'b-o','LineWidth',1)
plot(1:M,T_train,'r-',1:M,T_sim1,'b-','LineWidth',1)
legend('真实值','预测值')
xlabel('预测样本')
ylabel('预测结果')
string={'训练集预测结果对比';['(R^2 =' num2str(R1) ' RMSE= ' num2str(error1) ' MSE= ' num2str(mse1) ' RPD= ' num2str(RPD) ')' ]};
title(string)
%% 预测集绘图
figure
plot(1:N,T_test,'r-',1:N,T_sim2,'b-','LineWidth',1)
legend('真实值','预测值')
xlabel('预测样本')
ylabel('预测结果')
string={'测试集预测结果对比';['(R^2 =' num2str(R2) ' RMSE= ' num2str(error2)  ' MSE= ' num2str(mse2) ' RPD1= ' num2str(RPD1) ')']};
title(string)
%% 打印出评价指标
disp(['-----------------------误差计算--------------------------'])
disp(['隐含层节点数为',num2str(11),'时的预测集的评价结果如下所示：'])
disp(['平均绝对误差MAE为：',num2str(MAE2)])
disp(['均方误差MSE为：       ',num2str(mse2)])
disp(['均方根误差RMSEP为：  ',num2str(error2)])
disp(['决定系数R^2为：  ',num2str(R2)])
disp(['剩余预测残差RPD为：  ',num2str(RPD1)])
disp(['平均绝对百分比误差MAPE为：  ',num2str(MAPE2)])
%% 运行时间
%toc
% MAE
mae1 = sum(abs(T_sim1 - T_train), 2)' ./ M ;
mae2 = sum(abs(T_sim2 - T_test ), 2)' ./ N ;

disp(['训练集数据的MAE为：', num2str(mae1)])
disp(['测试集数据的MAE为：', num2str(mae2)])

% RMSE
rmse1 = sqrt(sum((T_sim1 - T_train).^2, 2)' ./ M); % 训练集RMSE
rmse2 = sqrt(sum((T_sim2 - T_test).^2, 2)' ./ N); % 测试集RMSE

disp(['训练集数据的RMSE为：', num2str(rmse1)])
disp(['测试集数据的RMSE为：', num2str(rmse2)])

% MAPE
mape1 = sum(abs((T_sim1 - T_train) ./ T_train), 2)' ./ M; % 训练集MAPE
mape2 = sum(abs((T_sim2 - T_test) ./ T_test), 2)' ./ N; % 测试集MAPE

disp(['训练集数据的MAPE为：', num2str(mape1 * 100), '%']) % 输出为百分比
disp(['测试集数据的MAPE为：', num2str(mape2 * 100), '%']) % 输出为百分比



%% 4.3 新的物资需求模型(基于CIWOA最终预测为例)
%    假设有 4 类物资: 食物, 水, 医疗, 帐篷
S_pred_all = [T_sim1(1:160)';T_sim2'];
XX=cell2mat(allData);
XX=XX(:,1:10);


% 下面是一些假设系数(可自行调整)
seasonData = XX(:,2);  % 第13列为发生季节（1=春,2=夏,3=秋,4=冬）
alpha_food    = [5,  0.8,  0.1];
alpha_water   = [10, 0.5,  0.2];
alpha_medical = [2,  0.5,  0.05];
alpha_tent    = [0.1,0.08, 0.02];
beta_food    = 0.001;
beta_water   = 0.0005;
beta_medical = 0.0003;
beta_tent    = 0.005;
gamma_season_food    = [1.0, 1.0, 1.0, 1.2];
gamma_season_water   = [1.1, 1.3, 1.2, 1.1];
gamma_season_medical = [1.2, 1.1, 1.1, 1.3];
gamma_season_tent    = [1.2, 1.0, 1.1, 1.3];

demands_food    = zeros(numSamples,1);
demands_water   = zeros(numSamples,1);
demands_medical = zeros(numSamples,1);
demands_tent    = zeros(numSamples,1);

for i = 1:numSamples
    S   = S_pred_all(i);  % 预测的受灾人口
    Imax= XX(i,5);     % 最大破坏烈度
    Is  = XX(i,3);     % 设防烈度(或地震等级等)
    diffVal = max(0, Imax - Is);  % 烈度差
    N_af= XX(i,7);     % 当地人口密度(或其他)
    Hf  = XX(i,8);     % 房屋破坏数量
    season = seasonData(i);  % 使用修正后的季节参数 地震季节(1~4)
    % 季节因子索引（确保值在1-4之间）
    season_idx = max(1, min(4, round(season)));

    % 食物
    demands_food(i) = ( alpha_food(1)*S + alpha_food(2)*N_af + alpha_food(3)*diffVal ...
        + beta_food*Hf ) ...
        * gamma_season_food(season_idx);
    % 饮水
    demands_water(i)= ( alpha_water(1)*S + alpha_water(2)*N_af + alpha_water(3)*diffVal ...
        + beta_water*Hf ) ...
        * gamma_season_water(season_idx);
    % 医疗
    demands_medical(i)= ( alpha_medical(1)*S + alpha_medical(2)*N_af + alpha_medical(3)*diffVal ...
        + beta_medical*Hf ) ...
        * gamma_season_medical(season_idx);
    % 帐篷
    demands_tent(i)  = ( alpha_tent(1)*S + alpha_tent(2)*N_af + alpha_tent(3)*diffVal ...
        + beta_tent*Hf ) ...
        * gamma_season_tent(season_idx);
end

disp('=== 前5条地震的物资需求预测(基于PCA-BP) ===');
for i=1:5   %想要a条到b条    就改成for i=a:b  a<b<=200
    disp(['第', num2str(i),'条(地点=', allData{i,1},'): ', ...
        '食物(kg)=', num2str(demands_food(i)), ...
        ', 水(L)=', num2str(demands_water(i)), ...
        ', 医疗(件)=', num2str(demands_medical(i)), ...
        ', 帐篷(顶)=', num2str(demands_tent(i))]);
end