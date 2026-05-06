function keyPoints=simplify_curve(x,y,num_key_point)
%x,y: 原始曲线坐标
%num_key_point: 要选取的关键点数量(不包括起点和终点)

%初始关键点为起点和终点
keyIndices=[1,length(x)];

%递归分割曲线,直到达到所需的关键点数量
while length(keyIndices)<num_key_point+2
    maxError=-1;
    indexToAdd=-1;

    %在当前分割段中找到误差最大的点
    for i=1:length(keyIndices)-1
        startIdx=keyIndices(i);
        endIdx=keyIndices(i+1);
        [~,idx]=max_distance(x(startIdx:endIdx),y(startIdx:endIdx));
        globalIdx=startIdx+idx-1;
        error=max_distance(x(startIdx:endIdx),y(startIdx:endIdx),true);

        if error>maxError
            maxError=error;
            indexToAdd=globalIdx;
        end
    end

    if indexToAdd==-1
        break; 				%无法继续分割
    end

    %添加新的关键点
    keyIndices=[keyIndices,indexToAdd];
    keyIndices=sort(keyIndices);
end

%获取关键点坐标
keyPoints.x=x(keyIndices);
keyPoints.y=y(keyIndices);
end