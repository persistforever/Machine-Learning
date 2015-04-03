function [subSet, label, error] = Cross_Validation(dataSet, label, distribution)
    % the function of cross validation algorithm for test error of native
    % bayes text classify, split dataSet into k part, choose one part for
    % testing and other part for training
    % dataSet : the set of samples
    % label : the label of each samples
    % error : mean error of k times training
    % ---------------------------------------------------------------------
    
    % step 1 : split data
    [m, n] = size(dataSet) ;
    error = zeros(1,9) ;
    for k=2:10
        fprintf('split data into %d subset...\n', k) ;
        t_dataSet = [dataSet, label] ;
        subSet = Split_Subset(t_dataSet, label, k) ;

        % step 2 : for each model test
%         fprintf('loop %d times for testing...\n', k) ;
        numWrong = 0 ;
        for i=1:k
            % trainData
            trainData = zeros(1, n+1) ;
            for j=1:k
                if j~=i      
                   trainData = [trainData ; subSet{j}] ;
                end
            end
            trainData(1,:) = [] ;
            trainLabel = trainData(:,end) ;
            trainData = trainData(:,1:end-1) ;   
            % testData
            testLabel = subSet{i}(:,end) ;
            testData = subSet{i}(:,1:end-1) ;
            switch lower(distribution)
                case lower('bernoulli')
                    [~, wrong] = NativeBayes_for_BernoulliModel(trainData, trainLabel, testData, testLabel) ;
                case lower('multinomial')
                    [~, wrong] = NativeBayes_for_MultinomialModel(trainData, trainLabel, testData, testLabel) ;
            end
            numWrong = numWrong + wrong ;
        end
        error(1,k-1) = numWrong/(k*m) ;
        fprintf('right rate is %f...\n', 1-error(1,k-1)) ;
    end
end