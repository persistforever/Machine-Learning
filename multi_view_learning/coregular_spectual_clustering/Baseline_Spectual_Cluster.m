function V = Baseline_Spectual_Cluster(K, numCluster)
    [m, n] = size(K) ;
    % cal diagnal D
    D = diag(sum(K,2)) ;
    L = inv(sqrt(D))*K*inv(sqrt(D)) ;
    L = (L + L')/2 ;
    opts.disp = 0;
    [V, D] = eigs(L,numCluster,'LA',opts);  
    % regularization
    norm_mat = repmat(sqrt(sum(V.*V, 2)), 1, size(V, 2)) ;
    norm_mat(find(norm_mat == 0)) = 1 ;
    V = V./norm_mat ;
end