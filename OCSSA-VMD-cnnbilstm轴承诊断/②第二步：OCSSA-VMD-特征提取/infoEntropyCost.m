%% 淘个代码 %%
% 2023/08/06%
%微信公众号搜索：淘个代码
%% 最小信息熵的适应度函数
function [ff,idx] = infoEntropyCost(c,data)
X = data;
% alpha = 2300;       % moderate bandwidth constraint：适度的带宽约束/惩罚因子
alpha = fix(c(1));       % moderate bandwidth constraint：适度的带宽约束/惩罚因子
tau = 0;          % noise-tolerance (no strict fidelity enforcement)：噪声容限（没有严格的保真度执行）
K = fix(c(2));              % modes：分解的模态数
% K = 10;              % modes：分解的模态数
DC = 0;             % no DC part imposed：无直流部分
init = 1;           % initialize omegas uniformly  ：omegas的均匀初始化
tol = 1e-7;     
%--------------- Run actual VMD code:数据进行vmd分解---------------------------
[u, u_hat, omega] = VMD(X, alpha, tau, K, DC, init, tol);
for i = 1:K
    fitness(i,:) = entropy(u(i,:));  %这里直接调用信息熵函数
end
[ff,idx] = min(fitness);
end





