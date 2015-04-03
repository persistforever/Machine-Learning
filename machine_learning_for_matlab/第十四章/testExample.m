function newMatrix = testExample(dataSet)
k = 3 ;
[U, Sigma, V] = svd(dataSet) ;
V = V' ;
newMatrix = U(:,1:k) * Sigma(1:k,1:k) * V(1:k,:) ;
end