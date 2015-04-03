function res = mainTest(trainingdata, testdata)
rightNum = 0 ; % 正确的个数
allNum = 0 ; % 所有测试集的个数
tempTrainData = trainingdata ;
tempTestData = testdata ;
for number=0:9
    number
    trainingdata = tempTrainData ;
    testdata = tempTestData ;
    [tm,tn] = size(trainingdata) ; %训练集的行列
    [sm,sn] = size(testdata) ; %测试集的行列
    for i=1:tm %先计算数字0
        if trainingdata(i,end) ~= i
            trainingdata(i,end) = 1 ;
        else
            trainingdata(i,end) = 0 ;
        end
    end
    for i=1:sm %先计算数字0
        if testdata(i,end) ~= i
            testdata(i,end) = 1 ;
        else 
            testdata(i,end) = 0 ;
        end
    end
    theta = gradAscent(trainingdata,50) ;
    res = theta ;
    allNum = allNum + sm ;
    for i=1:sm
        if classifyVector(testdata(i,:),theta) == testdata(i,end) ;
            rightNum = rightNum + 1 ;
        end
    end
    tempTrainData(find(tempTrainData(:,end)==number),:) = [] ;
    tempTestData(find(tempTestData(:,end)==number),:) = [] ;
end
res = 1-rightNum/allNum ;
end