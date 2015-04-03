function sigma = Optimal_Sigma(dataSet)
    [m, n] = size(dataSet) ;
    % º∆À„≈∑ œæ‡¿Î
    eur_dist = pdist(dataSet) ;
    sigma = median( reshape(eur_dist, 1, size(eur_dist, 1), size(eur_dist, 2)) ) ;
end