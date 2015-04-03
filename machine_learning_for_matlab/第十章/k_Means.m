function [centroid, J, label] = k_Means(dataSet, k, generation)
m = size(dataSet,1) ;
inf = 1e6 ;
centroid = randCenter(dataSet, k) ; % 初始化聚类中心
label = zeros(m,1) ; % 类标签
J = zeros(k, 1) ; % 消耗函数
for v=1:k
    for i=1:generation
         % 计算每个点分配到哪个聚类中心
        for j=1:m
            minDist = inf ;
            for l=1:v
                dist = calcuDist(dataSet(j,:), centroid(l,:)) ;
                if  dist < minDist
                    minDist = dist ;
                    label(j,1) = l ;
                end
            end
        end

        % 重新计算每个聚类中心
        for j=1:v
            dataClass = dataSet(find(label(:,1)==j),:) ;
            centroid(j,:) = mean(dataClass) ;
        end

        %计算整体的J
        tempJ = 0 ;
        for j=1:m
            tempJ = tempJ + calcuDist(dataSet(j,:), centroid(label(j,1),:)) ;
        end
    end
    J(v,1) = tempJ ;
%     plotData(dataSet, centroid) ;
end
figure ;
plot(J,'o-b') ;
end