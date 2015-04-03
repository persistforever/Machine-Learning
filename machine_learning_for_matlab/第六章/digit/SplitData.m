function trainLabel = SplitData(trainLabel, labelNeedClassify)
[m,n] = size(trainLabel) ;
for i=1:m
    if trainLabel(i,1) ==  labelNeedClassify
        trainLabel(i,1) = 1 ;
    else
        trainLabel(i,1) = -1 ;
    end
end
end