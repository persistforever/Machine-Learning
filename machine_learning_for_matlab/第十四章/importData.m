function pictureMatrix = importData(origData)
m = size(origData, 1) ;
n = 32 ;
for i=1:m
    temp = cell2mat(origData(i,1)) ;
    for j=1:n
        pictureMatrix(i,j) = str2double(temp(1,j)) ;
    end
end
end