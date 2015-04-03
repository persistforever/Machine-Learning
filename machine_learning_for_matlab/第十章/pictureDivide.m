function resData = pictureDivide(origData, k)
figure ;
imshow(origData);
[a, b, c] = size(origData) ;
dataSet = zeros(a*b,c) ;
resData = zeros(a,b,c) ;
num = 0 ;
for i=1:a % ÕûÀí¾ØÕó
    for j=1:b
        num = num + 1 ;
        dataSet(num,:) = origData(i,j,:) ;
    end
end
[IDX, C] = kmeans(dataSet,k) ; % ¾ÛÀà
m = size(IDX,1) ;
resSet = zeros(m,c) ;
for i=1:m
    resSet(i,:) = C(IDX(i,1),:) ;
end
num = 0 ;
for i=1:a
    for j=1:b
        num = num + 1 ;
        resData(i,j,:) = resSet(num,:) ;
    end
end
resData = uint8(resData) ;
figure ;
imshow(resData);
end