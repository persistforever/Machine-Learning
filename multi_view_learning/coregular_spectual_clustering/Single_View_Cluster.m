function [K, V, nmi] = Single_View_Cluster(dataSet, numCluster, label)
    % main function of the single view clustering algorithm
    % dataSet : each view
    % numCluster : number of the cluster for classifying
    % label : the truth label of each samples
    % ---------------------------------------------------------------------
    
    [m, n] = size(dataSet) ;
    % step 1 : call K
    fprintf('calculate the kernal matrix...\n') ;
    K = zeros(m, m) ;
    options.KernelType = 'Gaussian' ; % gauusian kernel
    options.sigma = Optimal_Sigma(dataSet) ; % sigma
    K = Calculate_Kernel(dataSet, dataSet, options) ;
    % cal diagnal matrix D
    D = diag(sum(K,2)) ;
    L = inv(sqrt(D))*K*inv(sqrt(D)) ;
    L = (L + L')/2 ;
    opts.disp = 0;
    [V, D] = eigs(L,numCluster,'LA',opts);  
    norm_mat = repmat(sqrt(sum(V.*V, 2)), 1, size(V, 2)) ;
    norm_mat(find(norm_mat == 0)) = 1 ;
    V = V./norm_mat ;
    
    % step2 : kmeans and cal nmi
    fprintf('kmeans step and calculate nmi...\n') ;
    kmeans_iter = 20 ;
    nmi = zeros(kmeans_iter, 1) ;
    avgent = zeros(kmeans_iter, 1) ;
    cluster = zeros(m, 1) ;
    for i=1:kmeans_iter
        cluster = kmeans(V, numCluster, 'emptyaction', 'drop') ;
        [A nmi(i) avgent(i)] = compute_nmi (label, cluster) ;
    end
    nmi = mean(nmi) ;
%     fprintf('nmi: %f\n', nmi);
end