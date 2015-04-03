function [centroid, J, label] = k_Means(dataSet, k, generation)
m = size(dataSet,1) ;
inf = 1e6 ;
centroid = randCenter(dataSet, k) ; % ��ʼ����������
label = zeros(m,1) ; % ���ǩ
J = zeros(k, 1) ; % ���ĺ���
for v=1:k
    for i=1:generation
         % ����ÿ������䵽�ĸ���������
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

        % ���¼���ÿ����������
        for j=1:v
            dataClass = dataSet(find(label(:,1)==j),:) ;
            centroid(j,:) = mean(dataClass) ;
        end

        %���������J
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