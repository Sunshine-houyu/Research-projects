%% 淘个代码 %%
% 2023/06/15 %
%微信公众号搜索：淘个代码，获取更多免费代码
%%
function new_data = tezhengtiqu(a,k,idx,da)
a = round(a);
k=round(k);
%----------------导入数据-----------------------------------------
X = da;
%--------- some sample parameters forVMD：对于VMD样品参数进行设置---------------
alpha = a;       % moderate bandwidth constraint：适度的带宽约束/惩罚因子
tau = 0;          % noise-tolerance (no strict fidelity enforcement)：噪声容限（没有严格的保真度执行）
K = k;              % modes：分解的模态数
DC = 0;             % no DC part imposed：无直流部分
init = 1;           % initialize omegas uniformly  ：omegas的均匀初始化
tol = 1e-6;         
%--------------- Run actual VMD code:数据进行vmd分解---------------------------
for i =1:size(X,1)
    [u, u_hat, omega] = VMD(X(i,:), alpha, tau, K, DC, init, tol);
    zuijia_u=u(idx,:);  %这里就是把适应度最小的u的那一行，作为当前信号的最优的IMF分量
    %计算最佳IMF的均值，方差，峰值，峭度，有效值，峰值因子，脉冲因子，波形因子，裕度因子共九个指标作为当前信号的特征向量
    xdata = zuijia_u;
    junzhi=mean(xdata);  %均值
    fangcha=mean((xdata-junzhi).^2);   %方差
    p=max(xdata)-min(xdata);  %峰值
    k=kurtosis(xdata);  %峭度
    r=rms(xdata); %有效值
    c=p/r;    %峰值因子
    v=p/mean(abs(xdata)); %脉冲因子
    s=r/mean(abs(xdata));  %波形因子
    ma=p/mean(sqrt(abs(xdata)))^2;  %裕度因子
    new_data(i,:) = [junzhi,fangcha,p,k,r,c,v,s,ma];  %将9个指标作为最佳IMF的特征向量；
end

