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

% coregular parewise spectual clustering-------------------------------------------
fprintf('coregular parewise multi view spectual clustering...\n') ;
[K, U, nmi] = Coregular_Pairwise_for_Multiview(dataSet, numCluster, truth) ;
fprintf(2, 'nmi of parewise coregular is %f\n', nmi);

% coregular centroid spectual clustering-------------------------------------------
fprintf('coregular centroid multi view spectual clustering...\n') ;
[K, U, nmi] = Coregular_Centroid_for_Multiview(dataSet, numCluster, truth) ;
fprintf(2, 'nmi of centroid coregular is %f\n', nmi);