%% 初始化
clear
close all
clc
warning off
% 数据读取
addpath(genpath(pwd));
load vmddata.mat  %加载处理好的特征数据
data = vmddata;
% 数据载入
bv = 120;    %每种状态数据有120组
% 加标签值
hhh = size(data,2);
for i=1:size(data,1)/bv
    data(1+bv*(i-1):bv*i,hhh+1)=i;
end
input=data(:,1:hhh);
output =data(:,end);

jg = bv;   %每组120个样本
tn = 90;    %选前tn个样本进行训练
input_train = []; output_train = [];
input_test = []; output_test = [];
for i = 1:max(data(:,end))
    input_train=[input_train;input(1+jg*(i-1):jg*(i-1)+tn,:)];
    output_train=[output_train;output(1+jg*(i-1):jg*(i-1)+tn,:)];
    input_test=[input_test;input(jg*(i-1)+tn+1:i*jg,:)];
    output_test=[output_test;output(jg*(i-1)+tn+1:i*jg,:)];
end
input_train = input_train';
input_test = input_test';
%归一化
[inputn_train,inputps]=mapminmax(input_train);
[inputn_test,inputtestps]=mapminmax('apply',input_test,inputps); 
output_train = categorical(output_train);
output_test =  categorical(output_test);

for i = 1:size(input_train,2)
    Train_xNorm{i,:} = reshape(inputn_train(:,i),hhh,1,1);
end

for i = 1:size(input_test,2)
    Test_xNorm{i,:} = reshape(inputn_test(:,i),hhh,1,1);
end

numFeatures = size(input,2);
numHiddens = 120;
numClasses = 10;

layers0 = [ ...
    
    sequenceInputLayer([numFeatures,1,1],'name','input')   %输入层设置
    sequenceFoldingLayer('name','fold')         %使用序列折叠层对图像序列的时间步长进行独立的卷积运算。
    
    convolution2dLayer([6,1],8,'Stride',[1,1],'name','conv1')  %添加卷积层，64，1表示过滤器大小，10过滤器个数，Stride是垂直和水平过滤的步长
    batchNormalizationLayer('name','batchnorm1')  % BN层，用于加速训练过程，防止梯度消失或梯度爆炸
    reluLayer('name','relu1')       % ReLU激活层，用于保持输出的非线性性及修正梯度的问题
     
    maxPooling2dLayer([2,1],'Stride',2,'Padding','same','name','maxpool')   % 第一层池化层，包括3x3大小的池化窗口，步长为1，same填充方式
    sequenceUnfoldingLayer('name','unfold')       %独立的卷积运行结束后，要将序列恢复
    flattenLayer('name','flatten')
    
    bilstmLayer(30,'Outputmode','last','name','hidden1') 
    dropoutLayer(0.2,'name','dropout_1')        % Dropout层，以概率为0.2丢弃输入

    fullyConnectedLayer(numClasses,'name','fullconnect')   % 全连接层设置（影响输出维度）（cell层出来的输出层） %
    
    softmaxLayer('Name','softmax')
    classificationLayer('name','output')];

lgraph0 = layerGraph(layers0);
lgraph0 = connectLayers(lgraph0,'fold/miniBatchSize','unfold/miniBatchSize');


%% Set the hyper parameters for unet training
options0 = trainingOptions('adam', ...                 % 优化算法Adam
    'MaxEpochs', 150, ...                            % 最大训练次数
    'GradientThreshold', 1, ...                       % 梯度阈值
    'InitialLearnRate', 0.01, ...         % 初始学习率
    'LearnRateSchedule', 'piecewise', ...             % 学习率调整
    'LearnRateDropPeriod',100, ...                   % 训练100次后开始调整学习率
    'LearnRateDropFactor',0.01, ...                    % 学习率调整因子
    'L2Regularization', 0.001, ...         % 正则化参数
    'ExecutionEnvironment', 'cpu',...                 % 训练环境
    'Verbose', 1, ...                                 % 关闭优化过程
    'Plots', 'none');                    % 画出曲线
% % start training
t0 = tic;  %开始计时
net = trainNetwork(Train_xNorm,output_train, lgraph0,options0 );
toc(t0); % 从t0开始到此处的执行时间
%% Accuracy assessment
pred = classify(net, Test_xNorm);
accuracy=sum(output_test==pred)/length(pred);   %计算预测的确率

% 标准bilstm作图
% 画方框图
figure
confMat = confusionmat(output_test,pred);  %output_test是真实值标签
zjyanseplotConfMat(confMat.');
xlabel('Predicted label')
ylabel('Real label')
title(['VMD-CNN-bilstm的测试集正确率 = ',num2str(accuracy*100),' %'])
% 作图
figure
scatter(1:length(pred),pred,'r^')
hold on
scatter(1:length(pred),output_test,'b*')
legend('预测类别','真实类别','NorthWest')
title(['VMD-CNN-bilstm的测试集正确率 = ',num2str(accuracy*100),' %'])
xlabel('预测样本编号')
ylabel('分类结果')
box on
set(gca,'fontsize',12)


