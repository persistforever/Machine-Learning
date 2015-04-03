function [error] = LABELED_algorithm(lData, tData, k, T, p)
    % main function of LABELED algorithm
    % lData - labeled example set
    % uData - unlabeled example set
    % tData - test example set
    % k - number of nearest neighbours
    % T - maximum number of learning iterations
    % p - distance order of regressor
    % ---------------------------------------------------------------------
    
    error = zeros(T,1) ;
    
    % step 1 : estimate tData and cal the error
    for j=1:size(tData, 1)
        [tData(j,3), ~] = k_nearest_neighbour(tData(j,1), lData, k, p) ;
    end
    tData = tData(:,1:3) ;
    error(1:T,1) = sum( (tData(:,2) - tData(:,3)).^2 ) ;
end