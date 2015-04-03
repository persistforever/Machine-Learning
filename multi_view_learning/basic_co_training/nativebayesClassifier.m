function [label, classfier] = nativebayesClassifier(nbStructor, testData)
    % classifying part of native bayes for bernoulli model
    % testData : in each test examples, each vacabulary with 0/1 
    % testLabel : each label
    %----------------------------------------------------------------------
    
    [m_test, n] = size(testData) ;
    numCluster = nbStructor.numCluster ;
    class_prior = nbStructor.class_prior ;
    word_class = nbStructor.word_class ;
    % each document in each class
    docu_class = zeros(m_test, numCluster) ;
    for j=1:numCluster
        for i=1:m_test
            for k=1:n
                docu_class(i,j) = docu_class(i,j) + log( testData(i,k)*word_class(k,j) ...
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
    label = zeros(m_test, 1) ;
    for i=1:m_test
        for j=1:numCluster
            classfier(i,j) = class_prior(1,j) + docu_class(i,j) ;
            classfier(i,j) = round(classfier(i,j)) ;
        end
        [~,label(i,1)] = max(classfier(i,:)) ;
        label(i,1) = label(i,1)-1 ;
    end
end