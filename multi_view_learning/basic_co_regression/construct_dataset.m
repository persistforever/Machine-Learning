function [lData, uData, tData] = construct_dataset(left, right, size)
    % function to construct the dataset of co-regression
    % size - size of dataSet
    % lData - labeled example set
    % uData - unlabeled example set
    % tData - test example set
    % ---------------------------------------------------------------------
    
    x = left : (right-left)/(size-1) : right ; % independent varible
    
    y = sin(abs(x))./abs(x) ; % real-value
    
    num = 1:1:size ;
    % create t_x
    t_x = 4 : 4 : size ;
    
    rest_x = num ;
    rest_x(t_x) = [] ;
    % create l_x
    ll_x = 1 : 10 : size*0.75-9 ;
    l_x = rest_x(ll_x) ;
    % create u_x 
    u_x = rest_x ;
    u_x(ll_x) = [] ;
    % create lData, uData, tData 
    lData = [x(l_x) ; y(l_x)]' ;
    uData = x(u_x)' ;
    tData = [x(t_x) ; y(t_x)]' ;
    
    %% ploting
    %{
    figure ;
    hold on ;
    plot(x, y, 'b') ;
    plot(lData(:,1), lData(:,2), 'r.') ;
    plot(uData(:,1), uData(:,2), 'g.') ;
    plot(tData(:,1), tData(:,2), 'y.') ;
    hold off ;
    %}
end