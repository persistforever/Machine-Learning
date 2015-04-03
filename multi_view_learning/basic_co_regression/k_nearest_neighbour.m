function [y_hat, neighbour] = k_nearest_neighbour(xu, lData, k, p)
    % function of find nearest_neighbour
    % input : xu - ulabeled data
    %         lData - labeled data
    %         k - number of nearest neighbour
    %         p - distance order
    % output : y_hat - estimation of h(xu)
    %          neighbour - k nearest neighbour in lData of xu 
    % ---------------------------------------------------------------------
    
    xx = repmat(xu, size(lData,1), 1) ;
    lData(:,end+1) = (sum((lData(:,1:end-1) - xx).^p, 2)).^(1/p) ;
    lData = sortrows(lData, size(lData, 2)) ;
    neighbour = lData(1:k, 1:end-1) ;
    y_hat = mean(neighbour(:,2)) ;
end