function [classfier, numWrong] = NativeBayes_for_BernoulliModel(trainData, trainLabel, testData, testLabel)
    % main function of native bayes for bernoulli model
    % content : in each sample, each vacabulary with 0/1 
    % label : each label
    %----------------------------------------------------------------------
    
    [m_train, n] = size(trainData) ;
    m_test = size(testData, 1) ;
    numCluster = numel(unique(trainLabel)) ;
    
    % start construct classifier
%     fprintf('learning part...\n') ;
    % each class prior probability
    class_prior = zeros(1, numCluster) ;
    for j=1:numCluster
        class_prior(1,j) = (sum(double(trainLabel == j))+1)/(m_train+numCluster) ;
    end
    
    % conditional probability
    word_class = zeros(n, numCluster) ;
    for j=1:numCluster
        prior = double(trainLabel == j) ;
        denominator = sum(prior) ;
        for i=1:n
            molecular = trainData(:,i)'*prior ;
            word_class(i,j) = (molecular+1)/(denominator+n) ;
        end
    end
    
    % test classifier
%     fprintf('classify part...\n') ;
    % each document in each class
    docu_class = zeros(m_test, numCluster)+1e200 ;
    for j=1:numCluster
        for i=1:m_test
            for k=1:n
                docu_class(i,j) = docu_class(i,j) * ( testData(i,k)*word_class(k,j) ...
                    + (1-testData(i,k))*(1-word_class(k,j)) ) ;
            end
        end
    end
    
%     % each document probality
%     docu_prior = zeros(1,m_test) ;
%     for i=1:m_test
%         for j=1:numCluster
%             docu_prior(1,i) = docu_prior(1,i) + class_prior(1,j)*docu_class(i,j) ;
%         end
%     end
    
    % test classifier
    classfier = zeros(m_test, numCluster) ;
    classLabel = zeros(m_test, 1) ;
    for i=1:m_test
        for j=1:numCluster
            classfier(i,j) = class_prior(1,j)*docu_class(i,j) ;
            classfier(i,j) = round(classfier(i,j)) ;
        end
        [~,classLabel(i,1)] = max(classfier(i,:)) ;
    end
    numWrong = sum(double(classLabel ~= testLabel)) ;
end