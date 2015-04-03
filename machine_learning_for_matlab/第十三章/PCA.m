function [lowDm, reconData] = PCA(dataSet)
[m, n] = size(dataSet) ;
meanVals = mean(dataSet, 1) ;
eigValsRank = zeros(1, n) ;
covMatrix = cov(dataSet) ; % ����Э�������
[eigVectors, eigVals] = eig(covMatrix) ;
for i=1:n
    eigValsRank(1,i) = eigVals(i,i) ;
end
eigValsRank = [eigValsRank ; eigVectors] ; % ������ֵ����
eigValsRank = sortrows(eigValsRank') ;
eigValsRank = eigValsRank' ;
redVectors = eigValsRank(2:end, end) ; % �������ֵ����������
for i=1:m
    dataSet(i,:) = dataSet(i,:) - meanVals ;
end
lowDm = dataSet * redVectors ; % ��ά�ȿռ�
reconData = lowDm * redVectors' ;
for i=1:m
    reconData(i,:) = reconData(i,:) + meanVals ; 
end
end