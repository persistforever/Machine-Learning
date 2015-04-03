% 导入训练集数字到data矩阵中，每行为每个样本，总共1936个样本
file1 = dir('E:\我的文件\学习文件\数模\机器学习\机器学习实战\源代码和数据集\machinelearninginaction\Ch02\digits\testDigits');
data = zeros(1000,1024) ;
len1 = length(file1) ;
for n=3:len1
    n
    A = importdata(strcat('E:\我的文件\学习文件\数模\机器学习\机器学习实战\源代码和数据集\machinelearninginaction\Ch02\digits\testDigits\',file1(n,1).name),'',32);
    for i=1:32
        str = cell2mat(A(i,1)) ;
        for j=1:32
            data(n-2,(i-1)*32+j) = str2double(str(j)) ;
        end
    end
end

% 导入训练标签
label = zeros(len1-2,1) ;
for i=3:len1
    label(i-2,1) = str2double(file1(i,1).name(1,1)) ;
end

% 导入测试集数字到data矩阵中，每行为每个样本，总共1936个样本
file2 = dir('E:\我的文件\学习文件\数模\机器学习\机器学习实战\源代码和数据集\machinelearninginaction\Ch02\digits\testDigits');
data = zeros(1000,1024) ;
len2 = length(file2) ;
for n=3:len2
    n
    A = importdata(strcat('E:\我的文件\学习文件\数模\机器学习\机器学习实战\源代码和数据集\machinelearninginaction\Ch02\digits\testDigits\',file2(n,1).name),'',32);
    for i=1:32
        str = cell2mat(A(i,1)) ;
        for j=1:32
            data(n-2,(i-1)*32+j) = str2double(str(j)) ;
        end
    end
end

% 导入测试标签
label = zeros(len2-2,1) ;
for i=3:len2
    label(i-2,1) = str2double(file2(i,1).name(1,1)) ;
end

n = len2-2 ; %测试数
m = len1-2 ; %训练数
%计算距离
dist = zeros(n,m) ;
for i=1:n
    i
    for j=1:m
        temp = testdata(i,:) - trainingdata(j,:) ;
        dist(i,j) = sqrt(temp*temp') ;
    end
end

%找出最小的5个
judgelabel = zeros(n,1) ;
for i=1:n
    [temp,id] = sort(dist(i,:)) ;
    chose_id = zeros(5,1) ;
    for j=1:5
        chose_id(j,1) = traininglabel(id(1,j)) ;
    end
    number = zeros(1,10) ;
    for j=1:5
        number(chose_id(j,1)+1) = number(chose_id(j,1)+1) + 1 ;
    end
    [y,judgelabel(i,1)] = max(number) ;
    judgelabel(i,1) = judgelabel(i,1) - 1 ;
end

%计算错误率
num = 0 ;
for i=1:n
    if judgelabel(i,1) ~= testlabel(i,1)
        num = num + 1 ;
    end
end
wrong_rate = num/n ;
wrong_rate 