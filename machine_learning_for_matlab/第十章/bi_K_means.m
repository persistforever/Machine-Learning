function [centroid, J, label] = bi_K_means(dataSet, k, generation)
m = size(dataSet,1) ;
J = zeros(generation,1) ; % ���ĺ���
centroid = mean(dataSet,1) ; % ��ʼ��һ����������
label = zeros(m,1)+1 ; % ��ǩ
while size(centroid,1) < k
end
end