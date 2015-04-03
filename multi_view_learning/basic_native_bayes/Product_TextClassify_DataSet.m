function [content, label] = Product_TextClassify_DataSet(model)
    % product the dataset of native bayes text classify
    % model : choice 'bernoulli' or 'multinomial'
    % content(bool) : each vacabulary exist in each sample
    % label : each sample's label
    %----------------------------------------------------------------------
    
    content = zeros(1, 2500) ;
    label = zeros(1, 1) ;
    for i=1:4
        data = importdata(strcat('task', num2str(i), '.mat')) ;
        content = [content ; data.fea{1,1}] ;
        label = [label ; data.gnd] ;
    end
    content(1,:) = [] ;
    label(1,:) = [] ;
    if model == 'bernoulli'
        content( find(content~=0) ) = 1 ;
    end
end