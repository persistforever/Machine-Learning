function y=calShanonEnt(myData)
[m,n] = size(myData) ;%m行n列的矩阵
labelDic(:,1) = unique(myData(:,end)) ; %每个标签所含的数量
labelDic(:,2) = zeros ;
for i=1:m
    index = find(labelDic(:,1) == myData(i,end)) ;
    labelDic(index,2) = labelDic(index,2)+1 ;
end
shannonEnt = 0 ;
for i=1:numel(labelDic(:,1))
    prob = labelDic(i,2)/m ;
    shannonEnt = shannonEnt - prob*log2(prob) ;
end
y = shannonEnt ;
end