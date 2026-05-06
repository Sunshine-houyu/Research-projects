%% 淘个代码 %%
% 2023/08/06%
%微信公众号搜索：淘个代码
%% 复合指标：最小排列熵/互信息信息熵
function [ff,idx] = compositeEntropyCost(c,data)

X = data;
% alpha = 2300;       % moderate bandwidth constraint：适度的带宽约束/惩罚因子
alpha = fix(c(1));       % moderate bandwidth constraint：适度的带宽约束/惩罚因子
tau = 1;          % noise-tolerance (no strict fidelity enforcement)：噪声容限（没有严格的保真度执行）
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
    fitness1 = PermutationEntropy(u(i,:),M,T);  %这里直接调用排列熵函数
    fitness2 = calmi(u(i,:)',X);  %这里直接调用互信息熵函数
    fitness(i) = fitness1/fitness2;
end
[ff,idx] = min(fitness);
end



%计算两列向量之间的互信息熵
%u1：输入计算的向量1
%u2：输入计算的向量2
%wind_size：向量的长度
function mi = calmi(u1, u2)
x = [u1, u2];
n = length(u1);
[xrow, xcol] = size(x);
bin = zeros(xrow,xcol);
pmf = zeros(n, 2);
for i = 1:2
    minx = min(x(:,i));
    maxx = max(x(:,i));
    binwidth = (maxx - minx) / n;
    edges = minx + binwidth*(0:n);
    histcEdges = [-Inf edges(2:end-1) Inf];
    [occur,bin(:,i)] = histc(x(:,i),histcEdges,1); %通过直方图方式计算单个向量的直方图分布
    pmf(:,i) = occur(1:n)./xrow;
end
%计算u1和u2的联合概率密度
jointOccur = accumarray(bin,1,[n,n]);  %（xi，yi）两个数据同时落入n*n等分方格中的数量即为联合概率密度
jointPmf = jointOccur./xrow;
Hx = -(pmf(:,1))'*log2(pmf(:,1)+eps);
Hy = -(pmf(:,2))'*log2(pmf(:,2)+eps);
Hxy = -(jointPmf(:))'*log2(jointPmf(:)+eps);
MI = Hx+Hy-Hxy;
mi = MI/sqrt(Hx*Hy);
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
