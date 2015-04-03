function estiScore = standEst(dataSet, user, item, type)
n = size(dataSet, 2) ; % ��Ʒ����
simTotal = 0 ; % �����ƶ�
ratSimTotal = 0 ;  % �����ƶ�
for i=1:n
    uesrRate = dataSet(user, i) ;
    if 0 == uesrRate
        continue ;
    end
    overLap = dataSet(find(dataSet(:,i).*dataSet(:,item) ~= 0), :) ;
    len = size(overLap, 1) ;
    if 0 == len
        similarity = 0 ;
    else
        similarity = CalSimilarity(overLap(:,i), overLap(:,item), type) ;
    end
    simTotal = simTotal + similarity ;
    ratSimTotal = ratSimTotal + similarity * uesrRate ;
end
if 0 == simTotal
    estiScore = 0 ;
else
    estiScore = ratSimTotal / simTotal ;
end