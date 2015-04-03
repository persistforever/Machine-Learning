function y=calShanonEnt(myData)
[m,n] = size(myData) ;%m��n�еľ���
labelDic(:,1) = unique(myData(:,end)) ; %ÿ����ǩ����������
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