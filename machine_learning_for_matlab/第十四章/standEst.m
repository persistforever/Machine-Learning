function estiScore = standEst(dataSet, user, item, type)
n = size(dataSet, 2) ; % 商品个数
simTotal = 0 ; % 总相似度
ratSimTotal = 0 ;  % 分相似度
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