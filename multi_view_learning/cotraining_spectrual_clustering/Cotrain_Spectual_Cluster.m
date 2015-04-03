function [K, U, nmi] = Cotrain_Spectual_Cluster(dataSet, numCluster, label)
    % main function of the cotraining spectual clustering algorithms
    % dataSet : cell of the data, each cell is a view of data
    % numCluster : number of the cluster for classifying
    % label : the truth label of each samples
    % ---------------------------------------------------------------------
    
    numView = size(dataSet, 2) ;
    [m, n] = size(dataSet{1}) ;
    
    % step1 : cal cell K
    fprintf('calculate the kernal matrix...\n') ;
    for i=1:numView
%         fprintf('calculate the kernal matrix of view %d...\n', i) ;
        data = dataSet{i} ;
        options.KernelType = 'Gaussian' ; % gauusian kernel
        options.sigma = Optimal_Sigma(data) ; % sigma
        temp = zeros(m, m) ;
        K{i} = Calculate_Kernel(data, data, options) ;
    end
    
    % step2 : initialize U{i} and iterative cal U{i}
    fprintf('iterative calculate U1 and U2...\n') ;
    for i=1:numView 
        temp = Baseline_Spectual_Cluster(K{i}, numCluster) ;
        U{i} = temp ;
    end
    iter = 10 ; % num of iteration
    % iterative cal U{i}
    for i=1:iter
%         fprintf('iteration is %d\n', i) ;
        S_all = zeros(m, m) ;
        for j=1:numView
            S_all = S_all + U{j}*U{j}' ;
        end
        for j=1:numView
            temp = (S_all - U{j}*U{j}') * K{j} ;
            S{j} = (temp + temp')/2 ;
            % cal laplacians of S{i}
            U{j} = Baseline_Spectual_Cluster(S{j}, numCluster) ;
        end
    end
    % row normalize U1 and U2
    for i=1:numView
        norm_mat = repmat(sqrt(sum(U{i}.*U{i}, 2)), 1, size(U{i}, 2)) ;
        norm_mat(find(norm_mat == 0)) = 1 ;
        U{i} = U{i}./norm_mat ;
    end
    
    % step3 : kmeans and cal nmi
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
%     fprintf('nmi: %f\n', nmi);
end