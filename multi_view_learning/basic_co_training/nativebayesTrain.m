function nbStructor = nativebayesTrain(trainData, trainLabel)
    % traing part of native bayes for bernoulli model
    % trainData : in each sample, each vacabulary with 0/1 
    % trainLabel : each label
    %----------------------------------------------------------------------
    
    [m_train, n] = size(trainData) ;
    numCluster = numel(unique(trainLabel)) ;
    
    % step 1 : each class prior probability
    class_prior = zeros(1, numCluster) ;
    for j=1:numCluster
        class_prior(1,j) = sum(double(trainLabel == j-1))/m_train ;
    end
    
    % step 2 : each word in each class
    word_class = zeros(n, numCluster) ;
    for j=1:numCluster
        prior = double(trainLabel == j-1) ;
        denominator = sum(prior) ;
        for i=1:n
            molecular = trainData(:,i)'*prior ;
            word_class(i,j) = (molecular+1)/(denominator+n) ;
        end
    end
    
    % step 3 : construct native bayes classifier
    nbStructor.numCluster = numCluster ;
    nbStructor.class_prior = class_prior ;
    nbStructor.word_class = word_class ;
end