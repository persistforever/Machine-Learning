function [classfier, numWrong] = NativeBayes_for_MultinomialModel(trainData, trainLabel, testData, testLabel)
    % main function of native bayes for multinomial model
    % content : in each sample, each vacabulary with 0...infinite 
    % label : each label
    %----------------------------------------------------------------------
    
    [m_train, n] = size(trainData) ;
    m_test = size(testData, 1) ;
    numCluster = numel(unique(trainLabel)) ;
    
    % start construct classifier
    fprintf('construct classifier...\n') ;
    % each class prior probability
    for j=1:numCluster
        class_prior(1,j) = sum(double(trainLabel == j))/m_train ;
    end
    
    % each word in each class
    word_class = zeros(n, numCluster) ;
    for j=1:numCluster
        exist = (trainLabel == j) ;
        prior = trainData(find(trainLabel == j), :) ;
        denominator = sum(sum(prior)) ;
        for i=1:n
            molecular = trainData(:,i)'*exist ;
            word_class(i,j) = (molecular+1)/(denominator+n) ;
        end
    end
    
    % test classifier
    fprintf('test classifier...\n') ;
    % each document in each class
    docu_class = zeros(m_test, numCluster) + 1  ;
    set(0,'RecursionLimit',2000) ;
    for j=1:numCluster
        j
        for i=1:m_test
            det_d = factorial(round(sum(testData(i,:))/10)) ;
            for k=1:n
                docu_class(i,j) = docu_class(i,j) * ( word_class(k,j).^testData(i,k) ...
                    / factorial(testData(i,k)) ) ;
            end
            docu_class(i,j) = docu_class(i,j) * det_d ;
        end
    end
    
    % each document probality
    docu_prior = zeros(1,m_test) ;
    for i=1:m_test
        for j=1:numCluster
            docu_prior(1,i) = docu_prior(1,i) + class_prior(1,j)*docu_class(i,j) ;
        end
    end
    
    % test classifier
    classfier = zeros(m_test, numCluster) ;
    classLabel = zeros(m_test, 1) ;
    for i=1:m_test
        for j=1:numCluster
            classfier(i,j) = class_prior(1,j)*docu_class(i,j)/docu_prior(1,i) ;
            classfier(i,j) = round(classfier(i,j)) ;
        end
        classLabel(i,1) = find(classfier(i,:) == max(classfier(i,:))) ;
    end
    numWrong = sum(double(classLabel ~= testLabel)) ;
end