function recMatrix = recommend(dataSet, user)
recMatrix = zeros(1,2) ;
if 0 ~= ismember(0, dataSet(user,:))
    unrateItem = find(dataSet(user,:) == 0) ;
    len = size(unrateItem, 2) ;
    for i=1:len
        estiScore = standEst(dataSet, user, unrateItem(1,i), 'cos') ;
        recMatrix = [recMatrix ; [unrateItem(1,i), estiScore] ] ;
    end
end
recMatrix = recMatrix(2:end, :) ;
end