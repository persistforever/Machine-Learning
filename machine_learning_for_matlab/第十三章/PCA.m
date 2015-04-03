function [lowDm, reconData] = PCA(dataSet)
[m, n] = size(dataSet) ;
meanVals = mean(dataSet, 1) ;
eigValsRank = zeros(1, n) ;
covMatrix = cov(dataSet) ; % 计算协方差矩阵
[eigVectors, eigVals] = eig(covMatrix) ;
for i=1:n
    eigValsRank(1,i) = eigVals(i,i) ;
end
eigValsRank = [eigValsRank ; eigVectors] ; % 对特征值排序
eigValsRank = sortrows(eigValsRank') ;
eigValsRank = eigValsRank' ;
redVectors = eigValsRank(2:end, end) ; % 最高特征值的特征向量
for i=1:m
    dataSet(i,:) = dataSet(i,:) - meanVals ;
end
lowDm = dataSet * redVectors ; % 低维度空间
reconData = lowDm * redVectors' ;
for i=1:m
    reconData(i,:) = reconData(i,:) + meanVals ; 
end
end