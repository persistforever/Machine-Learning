function wrongRate = mainTest(train, trainGroup, test, testGroup)
[m,n] = size(test); 
wrongRate = 0 ;
for i=1:10
    i
    wrongRate = wrongRate + SvmClassifyWrongNumber(train, trainGroup, test, testGroup, i-1) ;
    wrongRate
end
wrongRate = 100*(1-wrongRate/m) ;
end