function y = chooseBestFeaturetoSliptData(myData)
[m,n] = size(myData) ; %m行n列，有n-1个特征值
shannonEnt = zeros(n-1,1) ;
for i=1:n-1
    classlabel = unique(myData(:,i)) ;
    for j=1:numel(classlabel)
        subData = splitData(myData,i,classlabel(j)) ;
        [row,col] = size(subData) ;
        prob = row/m ;
        shannonEnt(i,1) = shannonEnt(i,1) + prob * calShannonEnt(subData) ;
    end
end
gain = zeros(n-1,1) ;
gain(:,1) = calShannonEnt(myData) - shannonEnt ;
y = find(gain == max(gain)) ;
end