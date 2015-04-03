load('synth3views_2clusters.mat') ;
% numCluster
numCluster = numel(unique(truth)) ;
% dataSet 
dataSet = {X1, X2, X3} ;

% single view spectual clustering------------------------------------------
fprintf('single view spectual clustering...\n') ;
for i=1:3
[single_K, V, nmi] = Single_View_Cluster(dataSet{i}, numCluster, truth) ;
fprintf(2, 'nmi of view %d is %f\n', i, nmi) ;
end

% cotraining spectual clustering-------------------------------------------
fprintf('multi view spectual clustering...\n') ;
[K, U, nmi] = Cotrain_Spectual_Cluster(dataSet, numCluster, truth) ;
fprintf(2, 'nmi of cotraining is %f\n', nmi);