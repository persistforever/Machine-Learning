function [K, U, nmi] = Coregular_Centroid_for_Multiview(dataSet, numCluster, label)
    % main function of the centroid coregulaization for multi view
    % dataSet : each view
    % numCluster : number of the cluster for classifying
    % label : the truth label of each samples
    % ---------------------------------------------------------------------
    
    numView = size(dataSet, 2) ;
    [m, n] = size(dataSet{1}) ;
    
    % step 1 : cal the L of each view
    fprintf('calculate the laplacian matrix...\n') ;
    for i=1:numView
        fprintf('for view %d...\n', i) ;
        % K
        data = dataSet{i} ;
        options.KernelType = 'Gaussian' ;
        options.sigma = Optimal_Sigma(data) ;
        K{i} = Calculate_Kernel(data, data, options) ;
        % D
        D{i} = diag(sum(K{i}, 2)) ;
        % L
        L{i} = inv(sqrt(D{i}))*K{i}*inv(sqrt(D{i})) ;
        L{i} = (L{i} + L{i}')/2 ;
        opts.disp = 0;
        % U
        [u, e] = eigs(L{i},numCluster,'LA',opts);  
        norm_mat = repmat(sqrt(sum(u.*u, 2)), 1, size(u, 2)) ;
        norm_mat(find(norm_mat == 0)) = 1 ;
        U{i} = u./norm_mat ;
    end
    
    % step 2 : iterative Ustar and each view's U
    fprintf('iterative the Ustar and each U...\n') ;
    numIter = 10 ;
    lambda = zeros(1, numView) + (1/numView) ;
    Lstar = zeros(m, m) ;
    Ltemp = zeros(m, m) ;
    for j=1:numIter
        for i=1:numView
            % cal Ustar
            Lstar = Lstar + lambda(i)*U{i}*U{i}' ;
            Lstar = (Lstar + Lstar') / 2 ;
            [Ustar, e] = eigs( Lstar ,numCluster,'LA',opts);
            % cal each U
            Ltemp = Ltemp + Ustar*Ustar' ;
            Ltemp = (Ltemp + Ltemp') / 2 ;
            [U{i}, e] = eigs( L{i}+lambda(i)*Ltemp, numCluster,'LA',opts ) ;
        end
    end
    norm_mat = repmat(sqrt(sum(Ustar.*Ustar, 2)), 1, size(Ustar, 2)) ;
    norm_mat(find(norm_mat == 0)) = 1 ;
    Ustar = Ustar./norm_mat ;
    
    % step 3 : kmeans and cal nmi
    fprintf('kmeans step and calculate nmi...\n') ;
    kmeans_iter = 20 ;
    nmi = zeros(kmeans_iter, 1) ;
    avgent = zeros(kmeans_iter, 1) ;
    cluster = zeros(m, 1) ;
    for i=1:kmeans_iter
        cluster = kmeans(Ustar, numCluster, 'emptyaction', 'drop') ;
        [A nmi(i) avgent(i)] = compute_nmi (label, cluster) ;
    end
    nmi = mean(nmi) ;
%     fprintf('nmi: %f\n', nmi);
end