function centroid = randCenter(dataSet, k)
n = size(dataSet,2) ;
bound = zeros(3,n) ; % ���ݵı߽�
centroid = zeros(k,n) ; % k����������
for i=1:n
    bound(1,i) = min(dataSet(:,i)) ;
    bound(2,i) = max(dataSet(:,i)) ;
    bound(3,i) = bound(2,i) - bound(1,i) ;
end
for i=1:k
    for j=1:n
        centroid(i,j) = rand(1,1) * bound(3,j) + bound(1,j) ;
    end
end
end