%% 淘个代码 %%
% 2023/08/06%
%微信公众号搜索：淘个代码
%% 最小排列熵的适应度函数
function [ff,idx] = PermutationEntropyCost(c,data)

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
M = 3;  % 嵌入维数
T = 1;  % 延迟时间
for i = 1:K
    fitness(i,:) = PermutationEntropy(u(i,:),M,T);  %这里直接调用信息熵函数
end
[ff,idx] = min(fitness);
end




%% 排列熵算法
function [pe ,hist] = PermutationEntropy(y,m,t)

%  Calculate the permutation entropy(PE)
%  排列熵算法的提出者：Bandt C，Pompe B. Permutation entropy:a natural complexity measure for time series[J]. Physical Review Letters,2002,88(17):174102.

%  Input:   y: time series;
%           m: order of permuation entropy 嵌入维数
%           t: delay time of permuation entropy,延迟时间

% Output: 
%           pe:    permuation entropy
%           hist:  the histogram for the order distribution
ly = length(y);
permlist = perms(1:m);
[h,~]=size(permlist);
c(1:length(permlist))=0;

 for j=1:ly-t*(m-1)
     [~,iv]=sort(y(j:t:j+t*(m-1)));
     for jj=1:h
         if (abs(permlist(jj,:)-iv))==0
             c(jj) = c(jj) + 1 ;
         end
     end
 end
hist = c;
c=c(c~=0);
p = c/sum(c);
pe = -sum(p .* log(p));
% 归一化
pe=pe/log(factorial(m));
end
