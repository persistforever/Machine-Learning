function y = splitData(myData, axis, value)
[m,n] = size(myData) ;
retData = zeros(1,n) ;
num = 1 ;
for i=1:m
    if myData(i,axis) == value
        retData(num,:) = myData(i,:) ;
        num = num + 1 ;
    end
end
retData(:,axis) = [] ;
y = retData ;
end