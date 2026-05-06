%%  清空环境变量
warning off             % 关闭报警信息
close all               % 关闭开启的图窗
clear                   % 清空变量
clc                     % 清空命令行

load('Result.mat');

%%  绘图
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid

figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比'; ['RMSE=' num2str(error2)]};
title(string)
xlim([1, N])
grid

%%  误差曲线迭代图
figure;
plot(1 : length(BestFit), BestFit, 'LineWidth', 1.5);
xlabel('粒子群迭代次数');
ylabel('适应度值');
xlim([1, length(BestFit)])
string = {'模型迭代误差变化'};
title(string)
grid on


%%  相关指标计算
%  R2
R1 = 1 - norm(T_train - T_sim1)^2 / norm(T_train - mean(T_train))^2;
R2 = 1 - norm(T_test -  T_sim2)^2 / norm(T_test -  mean(T_test ))^2;

disp(['训练集数据的R2为：', num2str(R1)])
disp(['测试集数据的R2为：', num2str(R2)])

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


