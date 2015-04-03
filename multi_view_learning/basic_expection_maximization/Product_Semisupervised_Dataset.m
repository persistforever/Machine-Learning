function [labeledData, unlabeledData, lDataLabel, uDataLabel] = Product_Semisupervised_Dataset(dataSet, label)
    % function to product semi supervised data 
    % content : 1040*2500 original data
    % label : 1040 labels
    % labeledData : the Data that have been labeled
    % unlabeledData : the Data that habe not been labeled
    % dataLabel : the label of labeledData
    % ---------------------------------------------------------------------
    
    [m, n] = size(dataSet) ;
    k = 10 ;
    disjoint_subset = Split_Subset(dataSet, label, k) ;
    % labeledData and dataLabel
    need = 2 ;
    labeledData = zeros(1, n-1) ;
    lDataLabel = zeros(1, 1) ;
    for i=1:need
        lDataLabel = [lDataLabel ; disjoint_subset{1,i}(:, end)] ;
        labeledData = [labeledData ; disjoint_subset{1,i}(:, 1:end-1)] ;
    end
    lDataLabel(1, :) = [] ;
    labeledData(1, :) = [] ;
    % unlabeledData
    unlabeledData = zeros(1, n-1) ;
    uDataLabel = zeros(1, 1) ;
    for i=need+1:k
        uDataLabel = [uDataLabel ; disjoint_subset{1,i}(:, end)] ;
        unlabeledData = [unlabeledData ; disjoint_subset{1,i}(:, 1:end-1)] ;
    end
    uDataLabel(1, :) = [] ;
    unlabeledData(1, :) = [] ;
end