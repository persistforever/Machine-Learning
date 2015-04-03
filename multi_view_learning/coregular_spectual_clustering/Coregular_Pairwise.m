function [K, L, U] = Coregular_Pairwise(dataSet, numCluster, label)
    % main function of the coregulaization for double view
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
    
    % step 2 : iterative cal U
    fprintf('iterative modified Laplacian...\n') ;
    numIter = 10 ;
    lambda = 0.5 ;
    for i=1:numIter
        % modified laplacian 1
        m_L = U{2}*U{2}' ;
        m_L = (m_L + m_L') / 2 ;
        [U{1}, e] = eigs( L{1}+lambda*m_L ,numCluster,'LA',opts);
        % modified laplacian 2
        m_L = U{1}*U{1}' ;
        m_L = (m_L + m_L') / 2 ;
        [U{2}, e] = eigs( L{2}+lambda*m_L ,numCluster,'LA',opts);
    end
    norm_mat = repmat(sqrt(sum(U{1}.*U{1}, 2)), 1, size(U{1}, 2)) ;
    norm_mat(find(norm_mat == 0)) = 1 ;
    U{1} = U{1}./norm_mat ;
    
    % step 3 : kmeans and cal nmi
    fprintf('kmeans step and calculate nmi...\n') ;
    kmeans_iter = 20 ;
    nmi = zeros(kmeans_iter, 1) ;
    avgent = zeros(kmeans_iter, 1) ;
    cluster = zeros(m, 1) ;
    for i=1:kmeans_iter
        cluster = kmeans(U{1}, numCluster, 'emptyaction', 'drop') ;
        [A nmi(i) avgent(i)] = compute_nmi (label, cluster) ;
    end
    nmi = mean(nmi) ;
    fprintf('nmi: %f\n', nmi);
end