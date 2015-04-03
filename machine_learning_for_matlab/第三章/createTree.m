function tree = createTree(myData,labels)
[m,n] = size(myData) ;
if length(unique((myData(:,end)))) == 1  %如果数据只有一个类则结束
    tree = myData(1,end) ;
    return ;
end
if n==1 %如果没有属性可以划分，则结束
    tree = cell(1,1) ;
    return ;
end 
bestFeature = chooseBestFeaturetoSliptData(myData) ;
bestFeatureLabel = labels{1,bestFeature} ;
classlabel = unique(myData(:,bestFeature)) ;
tree = cell(1,numel(classlabel)+1) ;
tree{1,1} = labels{1,bestFeature} ;
labels(bestFeature) = [] ;
for i=1:numel(classlabel)
    subValue = classlabel(i) ;
    subLabel = labels 
    tree{1,i+1} = createTree(splitData(myData,bestFeature,subValue),subLabel) ;
end