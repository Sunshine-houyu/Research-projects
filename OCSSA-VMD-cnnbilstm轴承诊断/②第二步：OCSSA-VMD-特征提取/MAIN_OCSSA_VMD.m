%% 淘个代码 %%
% 2023/08/21
%微信公众号搜索：淘个代码
%%  此程序运行需要很长的时间！！
% vmddata.mat就是最终特征提取的结果！

%% 以最小包络熵、最小样本熵、最小信息熵、最小排列熵，排列熵/互信息熵，为目标函数（任选其一），采用OCSSA算法优化VMD，求取VMD最佳的两个参数
clear
clc
close all
addpath(genpath(pwd))
xz = 5;  %xz, 选择1，以最小包络熵为适应度函数，
% 选择2，以最小样本熵为适应度函数，
% 选择3，以最小信息熵为适应度函数，
% 选择4，以最小排列熵为适应度函数，
% 选择5，以复合指标：排列熵/互信息熵为适应度函数。
if xz == 1  
    fobj=@EnvelopeEntropyCost;          %最小包络熵
elseif xz == 2
    fobj=@SampleEntropyCost;            %最小样本熵
elseif xz == 3  
    fobj=@infoEntropyCost;              %最小信息熵
elseif xz == 4
    fobj=@PermutationEntropyCost;       %最小排列熵
elseif xz == 5
    fobj=@compositeEntropyCost;       %复合指标：排列熵/互信息熵
end
load data_total_1797.mat   %这里选取转速为1797的10种故障，大家也可以选取其他类型的数据
D=2;             % 优化变量数目
lb=[100 3];      % 下限值，分别是a,k
ub=[2500 10];        % 上限值
T=15;       % 最大迭代数目
N=20;        % 种群规模
vmddata = [];
for i=1:10   %因为有十种故障状态
    disp(['正在对第',num2str(i),'个故障类型的数据进行VMD优化……请耐心等待！'])
    every_data = data(1+120*(i-1):120*i,:);  %一种状态是120个样本，每次选120个样本进行VMD优化和特征提取
    da = every_data(1,:);  %从当前状态的数据中任选一组数据进行VMD优化即可。
    [OCSSABest_score,OCSSABest_pos,Bestidx,OCSSA_curve] = OCSSA(N,T,lb,ub,D,fobj,da');
    display(['第',num2str(i),'个故障类型数据的最佳VMD参数是：', num2str(fix(OCSSABest_pos)),'最佳IMF分量是：IMF',num2str(Bestidx)]);  %输出最佳位置
    %% 以下为将最佳的a,k，idx回带VMD中，并进行9种时域指标特征提取
    bbh = fix(OCSSABest_pos);%最佳位置取整
    zuijiazhi(i,:)=[bbh,Bestidx];   %把最佳的惩罚因子，模态分量，最小适应度值对应IMF分量的索引值保存在变量zuijiazhi里    
    quxian(i,:)=OCSSA_curve;  %把每种状态优化VMD寻优的曲线保存在quxian变量中
    new_data = tezhengtiqu(bbh(1),bbh(2),Bestidx,every_data);  %将优化得到的两个参数和最小适应度的索引值带回VMD中，提取得到当前状态的特征向量
    vmddata =  [vmddata;new_data];  %将每个状态提取得到的特征向量都放在一起
end
    save vmddata.mat vmddata  %将提取的特征向量保存为mat文件
    save zuijiazhi.mat zuijiazhi  %第一列为最佳的惩罚因子，第二列为最佳的模态分量，第三列为最小适应度值对应IMF分量的索引值
    save quxian.mat quxian  %每一行为一个状态的VMD优化收敛曲线
    %% 删除路径，以免被其他函数混淆
rmpath(genpath(pwd))
