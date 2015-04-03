function [uLabel, wrongRate] = Basic_Expection_Maximum(labeledData, unlabeledData, lDataLabel, uDataLabel)
    % function of EM algorithm
    % labeledData : D^l
    % unlabeledData : D^u
    % lDataLabel : the label of D^l
    % uDataLabel : the label of D^u
    % ---------------------------------------------------------------------
    
    % step 1 : train the labeledData and test the unlabeledData
    fprintf('initialize the classifier...\n') ;
    uLabel = NativeBayes_for_BernoulliModel(labeledData, lDataLabel, unlabeledData) ;
    
    % step 2 : iterative the E step and M step
    fprintf('iterative the EM...\n') ;
    numIter = 5 ;
    wrongRate = zeros(numIter, 1) ;
    for i=1:numIter
        uLabel = NativeBayes_for_BernoulliModel([labeledData; unlabeledData], [lDataLabel; uLabel], unlabeledData) ;
        wrongRate(i, 1) = sum(uDataLabel ~= uLabel) / (size(uDataLabel, 1)) ;
    end
    
    % step 3 : cal the wrong rate 
    wrongRate = mean(wrongRate) ;
    fprintf('the right rate is %f\n', 1-wrongRate) ;
end