function res = mainTest(trainingdata, testdata)
rightNum = 0 ; % ��ȷ�ĸ���
allNum = 0 ; % ���в��Լ��ĸ���
tempTrainData = trainingdata ;
tempTestData = testdata ;
for number=0:9
    number
    trainingdata = tempTrainData ;
    testdata = tempTestData ;
    [tm,tn] = size(trainingdata) ; %ѵ����������
    [sm,sn] = size(testdata) ; %���Լ�������
    for i=1:tm %�ȼ�������0
        if trainingdata(i,end) ~= i
            trainingdata(i,end) = 1 ;
        else
            trainingdata(i,end) = 0 ;
        end
    end
    for i=1:sm %�ȼ�������0
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