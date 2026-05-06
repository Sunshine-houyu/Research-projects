clc
clear
%%导入数据
data=readtable('data.xlsx');
data.Properties.VariableNames= {'Year','TotalPopulation','ElderlyRatio','GenderRatio', ...
                                 'BirthRate','BirthNumberPer10k', 'AverageIncome', ...
                                 'NaturalGrowthRate','SocialSecurityExpenditure','GDP','UrbanizationRate'};


%%数据清洗
%移除缺失值
data_cleaned=removevars(data,{'AverageIncome'});
data_cleaned=rmmissing(data_cleaned);

%移除异常值：总人口中超过3倍标准差的值
outlier_threshold=isoutlier(data_cleaned.TotalPopulation,'movmedian',5);  %移动窗口法检测异常值
data_cleaned(find(outlier_threshold==1),:)=[];


%%逐步回归分析
%提取自变量和因变量
x=data_cleaned{:,{'ElderlyRatio','GenderRatio','BirthRate','BirthNumberPer10k', ...
              'NaturalGrowthRate','SocialSecurityExpenditure','GDP','UrbanizationRate'}};
y=data_cleaned.TotalPopulation;

%进行逐步回归分析
stepwise(x,y)











%获取选择的自变量
selected_variables=data_cleaned.Properties.VariableNames(in+2);
disp('选择的显著自变量:');
disp(selected_variables);


%%回归分析_regress
%选择显著自变量数据
X_selected=data_cleaned{:,selected_variables};

%添加回归中的截距
X_with_constant=[ones(size(X_selected,1),1),X_selected];

%开始分析
[b,bint,r,rint,stats]=regress(y,X_with_constant);


%%人口预测
%预测数据提取
data=removevars(data,{'AverageIncome'});
X_future_selected=data{:,selected_variables};
X_future_selected=X_future_selected(63:71,:);

%为预测数据添加常数项列
X_future_with_constant=[ones(size(X_future_selected,1),1),X_future_selected];

%使用回归模型进行预测
population_predicted=X_future_with_constant*b;

disp('2011-2019年全国总人口预测结果:');
disp(population_predicted);
