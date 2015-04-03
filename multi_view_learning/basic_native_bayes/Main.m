load('bernoulli_model.mat') ;

% Bernoulli distribution native bayes -------------------------------------
dataSet = content ;
[subSet, label, error] = Cross_Validation(dataSet, label, 'bernoulli') ;
% fprintf('the right rate is %f\n', 1-error) ;

% ploting
figure ;
title('text classification with word set model') ;
plot(2:10,1-error, 'b-o') ;
xlabel('iteration(s)') ;
ylabel('right rate(%)') ;
hold off ;
