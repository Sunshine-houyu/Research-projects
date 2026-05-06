function [maxDist,index]=max_distance(xSegment,ySegment,returnError)
%计算曲线段中点到直线的最大垂直距离
%xSegment,ySegment:曲线段坐标
%returnError: 如果为true,返回最大距离:否则返回最大距离的索引

%直线方程:从第一个点到最后一个点
x1=xSegment(1);
y1=ySegment(1);
x2=xSegment(end);
y2=ySegment(end);

%计算直线的系数 A*x+B*y+C=0
A=y2-y1;
B=x1-x2;
C=x2*y1-x1*y2;

%计算所有点到直线的距离
distances=abs(A*xSegment+B*ySegment+C)/sqrt(A^2+B^2);

%排除起点和终点
[maxDist,index]=max(distances(2:end-1));
index=index+1; 					%调整索引,排除第一个点
if nargin==3 && returnError
    maxDist=maxDist;
end
end