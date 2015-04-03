load('bernoulli_model.mat') ;

% basic EM algorithm
[labeledData, unlabeledData, lDataLabel, uDataLabel] = Product_Semisupervised_Dataset([content, label], label);
[uLabel, wrongRate] = Basic_Expection_Maximum(labeledData, unlabeledData, lDataLabel, uDataLabel) ;