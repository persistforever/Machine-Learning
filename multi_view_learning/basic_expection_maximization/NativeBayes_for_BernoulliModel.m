function uDataLabel = NativeBayes_for_BernoulliModel(labeledData, lDataLabel, unlabeledData)
    % main function of native bayes for bernoulli model
    % labeledData : D^l
    % unlabeledData : D^u
    % lDataLabel : the label of D^l
    %----------------------------------------------------------------------
    
    [m_train, n] = size(labeledData) ;
    m_test = size(unlabeledData, 1) ;
    numCluster = numel(unique(lDataLabel)) ;
    
    % start construct classifier
    fprintf('construct classifier...\n') ;
    % each class prior probability
    for j=1:numCluster
        class_prior(1,j) = sum(double(lDataLabel == j))/m_train ;
    end
    
    % each word in each class
    word_class = zeros(n, numCluster) ;
    for j=1:numCluster
        prior = double(lDataLabel == j) ;
        denominator = sum(prior) ;
        for i=1:n
            molecular = labeledData(:,i)'*prior ;
            word_class(i,j) = (molecular+1)/(denominator+2) ;
        end
    end
    
    % test classifier
    fprintf('test classifier...\n') ;
    % each document in each class
    docu_class = zeros(m_test, numCluster)+1e200 ;
    for j=1:numCluster
        for i=1:m_test
            for k=1:n
                docu_class(i,j) = docu_class(i,j) * ( unlabeledData(i,k)*word_class(k,j) ...
                    + (1-unlabeledData(i,k))*(1-word_class(k,j)) ) ;
            end
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
    uDataLabel = zeros(m_test, 1) ;
    for i=1:m_test
        for j=1:numCluster
            classfier(i,j) = class_prior(1,j)*docu_class(i,j)/docu_prior(1,i) ;
            classfier(i,j) = round(classfier(i,j)) ;
        end
        uDataLabel(i,1) = find(classfier(i,:) == max(classfier(i,:))) ;
    end
end