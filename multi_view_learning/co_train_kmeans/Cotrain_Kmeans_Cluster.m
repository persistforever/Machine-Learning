function [IDX, nmi] = Cotrain_Kmeans_Cluster(dataSet, numCluster, label)
    % main function of the single view kmeans clustering algorithm
    % dataSet : view set
    % numCluster : number of the cluster for classifying
    % label : the truth label of each samples
    % ---------------------------------------------------------------------
    
    % step 0 : init parms
    numView = 2 ;
    
    % step 1 : init view 2
    IDX{2} = zeros(size(dataSet{2},1), 1) ;
    tmp = rand(size(dataSet{2},1), 1) ;
    IDX{2}((tmp>0.5),1) = 1 ;
    IDX{2}((tmp<=0.5),1) = 2 ;
    
    % step 2 : iterative 2 views
    numIter = 10 ;
    for i=1:numIter
        for j=1:numView
            other = 3-j ;
            % cal Centroids : E step
            C{j} = zeros(numCluster, size(dataSet{j}, 2)) ;
            for p=1:numCluster
                points = find(IDX{other}==p) ;
                points = dataSet{j}(points, :) ;
                C{j}(p,:) = mean(points, 1) ;
            end
            % cal IDX : M step
            sumd = zeros(size(dataSet{j}, 1), numCluster) ;
            for p=1:size(dataSet{j}, 1)
                for q=1:numCluster
                    sumd(p,q) = sum((C{j}(q,:)-dataSet{j}(p,:)).^2) ;
                end
                [~,IDX{j}(p,1)] = max(sumd(p,:)) ;
            end
        end
        % step 3 : combine 2 view 
        [~,nmi(i),~] = compute_nmi(label, IDX{1}) ;
    end
end