function class = adaBoostClassify(data, classifyArr)
mm = size(data,1) ; % ��������
m = size(classifyArr, 1) ; % ����������
aggClass = zeros(mm,1) ;
for i=1:m
    dim = classifyArr(i,1) ;
    ineq = classifyArr(i,2) ;
    thead = classifyArr(i,3) ;
    alpha = classifyArr(i,4) ;
    [wrong, bestClass] = StumClassify(data, dim, thead, ineq, zeros(mm,1)) ;
    aggClass = aggClass + bestClass*alpha ;
end
class = sign(aggClass) ;
end