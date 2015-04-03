function smallPicture = imgCompress(origData, numSV, thresh)
pictureMatrix = importData(origData) ;
[U, Sigma, V] = svd(pictureMatrix) ;
V = V' ;
smallPicture = U(:, 1:numSV) * Sigma(1:numSV, 1:numSV) * V(1:numSV, :) ;
[m, n] = size(smallPicture) ;
for i=1:m 
    for j=1:n
        if smallPicture(i,j) > thresh
            smallPicture(i,j) = 1 ;
        else
            smallPicture(i,j) = 0 ;
        end
    end
end
end