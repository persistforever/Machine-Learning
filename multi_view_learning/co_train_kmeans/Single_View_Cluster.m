function [IDX, nmi] = Single_View_Cluster(dataSet, numCluster, label)
    % main function of the single view kmeans clustering algorithm
    % dataSet : each view
    % numCluster : number of the cluster for classifying
    % label : the truth label of each samples
    % ---------------------------------------------------------------------
    
    [IDX, ~] = kmeans(dataSet, numCluster);
    [~,nmi,~] = compute_nmi(label, IDX) ;
end