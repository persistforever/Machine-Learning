function res = SvmClassifyWrongNumber(train, trainGroup, test, testGroup, number)
trainGroup = SplitData(trainGroup, number) ;
svmmachine = svmtrain(train,trainGroup,'kernel_function','polynomial','polyorder',2) ;
testGroup = SplitData(testGroup, number) ;
testLabel = svmclassify(svmmachine,test) ;
[m,n] = size(testLabel) ;
num = 0 ;
for i=1:m
    if testLabel(i,1) ~= testGroup(i,1)
        num = num + 1 ;
    end
end
res = num ;
end