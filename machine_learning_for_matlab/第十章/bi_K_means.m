function [centroid, J, label] = bi_K_means(dataSet, k, generation)
m = size(dataSet,1) ;
J = zeros(generation,1) ; % 消耗函数
centroid = mean(dataSet,1) ; % 初始化一个聚类中心
label = zeros(m,1)+1 ; % 标签
while size(centroid,1) < k
end
end