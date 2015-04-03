function res = multiTest(testData, trainData, numGeneration)
[m,n] = size(testData) ;
testData = [zeros(m,1)+1 testData];
rate = zeros(numGeneration,1) ;
for k=1:numGeneration
    k
    theta = gradAscent(trainData,200);
    rightNum = 0 ;
    for i=1:m
        temp = classifyVector(testData(i,1:end-1),theta);
        if temp == testData(i,end) ;
            rightNum = rightNum + 1 ;
        end
    end
    rate(k,1) = 1-rightNum/m ;
end
hold on ;
plot(1:10,rate(1:10,1),'b') ;
for k=1:10
    k
    theta = impStocGradAscent(trainData,200);
    rightNum = 0 ;
    for i=1:m
        temp = classifyVector(testData(i,1:end-1),theta);
        if temp == testData(i,end) ;
            rightNum = rightNum + 1 ;
        end
    end
    rate(k,1) = 1-rightNum/m ;
end
plot(1:10,rate(1:10,1),'r.') ;
hold off ;
res = mean(rate) ;
end