function [error, L] = COREG_algorithm(lData, uData, tData, k, T, p)
    % main function of COREG algorithm
    % lData - labeled example set
    % uData - unlabeled example set
    % tData - test example set
    % k - number of nearest neighbours
    % T - maximum number of learning iterations
    % p1, p2 - distance order of 2 regressor
    % ---------------------------------------------------------------------
    
    % step 1 : initialize
    L{1} = lData ;
    L{2} = lData ;
    error = zeros(T,1) ;
    
    % step 2 : create uData_prime
    size_prime = 100 ;
    choosed = randperm(size(uData, 1)) ;
    choosed = choosed(1:size_prime) ;
    uData_prime = uData(choosed, :) ;
    
    % step 3 : iterative T 
    fprintf('COREG iteration: ') ;
    for i=1:T
        fprintf(strcat(num2str(i), ', ')) ;
        for j=1:2
            deta = zeros(size(uData_prime, 1), 2) ;
            for l=1:size(uData_prime, 1)
                xu = uData_prime(l,1) ;
                [y_hat, omiga] = k_nearest_neighbour(xu, L{j}, k, p(j)) ;  
                deta_xu = 0 ;
                for m=1:size(omiga, 1)
                    [h, ~] = k_nearest_neighbour(omiga(m,1), L{j}, k, p(j)) ;
                    [h_hat, ~] = k_nearest_neighbour(omiga(m,1), [L{j} ; [xu, y_hat]], k, p(j)) ;
                    deta_xu = deta_xu + ( (omiga(m,2) - h ).^2 - (omiga(m,2) - h_hat).^2 ) ;
                end
                deta(l,:) = [deta_xu, y_hat] ;
            end
            if sum(deta(:,1) > 0) > 0
                [~, row] = max(deta) ;
                set{j} = [uData_prime(row), deta(row,2)] ;
                uData_prime(row,:) = [] ;
            else
                set{j} = [] ;
            end
        end
        L{1} = [L{1} ; set{2}] ;
        L{2} = [L{2} ; set{1}] ; 
        if isempty(set{1}) && isempty(set{2})
            break ;
        else
            % create uData_prime
            choosed = randperm(size(uData, 1)) ;
            choosed = choosed(1:size_prime) ;
            uData_prime = uData(choosed, :) ;
        end
    
        % step 4 : utilize regressor to estimate tData and cal the error
        for j=1:size(tData, 1)
            [tData(j,3), ~] = k_nearest_neighbour(tData(j,1), L{1}, k, p(1)) ;
            [tData(j,4), ~] = k_nearest_neighbour(tData(j,1), L{2}, k, p(2)) ;
            tData(j,3) = ( tData(j,3) + tData(j,4) ) / 2 ;
        end
        tData = tData(:,1:3) ;
        error(i,1) = sum( (tData(:,2) - tData(:,3)).^2 ) ;
    end
    fprintf('\n') ;
    
    %% ploting
    %{
    figure;
    hold on ;
    plot(tData(:,1), tData(:,2), 'r.');
    plot(tData(:,1), tData(:,3), 'b.');
    hold off ;
    %}
end