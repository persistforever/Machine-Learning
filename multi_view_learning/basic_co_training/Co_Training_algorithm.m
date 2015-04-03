function [right_rate] = Co_Training_algorithm(lbData, ulbData, tstData)
    % function of co training algorightm
    % input : lbData - labeled training examples
    %         ulbData - unlabeled examples
    %         tstData - test examples to examine 
    % ---------------------------------------------------------------------
    
    % step 1 : choose u examples from ulbData to create pool U'
    numView = size(ulbData, 2) ;
    ulbPool = cell(1,numView) ;
    classifier = cell(1,numView) ;
    size_prime = 75 ;
    for i=1:numView
        choosed = randperm(size(ulbData{i}, 1)) ;
        choosed = choosed(1:size_prime) ;
        ulbPool{i} = ulbData{i}(choosed, :) ;
    end
    
    k = 30 ;
    right_rate = zeros(k,1) ;
    p = 1 ;
    n = 3 ;
    % step 2 : loop for k iterations 
    for i=1:k
        posi_pos = zeros(1, 1) ;
        nege_pos = zeros(1, 1) ;
        for clf=1:numView
            % use L train clf
            classifier{clf} = nativebayesTrain(lbData{clf}, lbData{3}) ;
            % use clf label p and n from ulbPool
            [labelC, ~] = nativebayesClassifier(classifier{clf}, ulbPool{clf}) ;
            posi = find(labelC == 1) ;
            choosed = randperm(size(posi, 1)) ;
            choosed = choosed(1:p) ;
            posi_pos = [posi_pos; posi(choosed,:)] ;
            nege = find(labelC == 0) ;
            choosed = randperm(size(nege, 1)) ;
            choosed = choosed(1:n) ;
            nege_pos = [nege_pos; nege(choosed,:)] ;
        end
        posi_pos(1,:) = [] ;
        nege_pos(1,:) = [] ;
        % add to lbData
        for j=1:2
            lbData{j} = [lbData{j} ; ulbPool{j}([posi_pos ; nege_pos],:)] ;
            ulbPool{j}([posi_pos ; nege_pos], :) = [] ;
        end
        lbData{3} = [lbData{3} ; ones(2*p,1) ; zeros(2*n,1)] ;
        % replanish ulbPool
        replan_num = 2*(n+p) ;
        choosed = randperm(size(ulbData{1}, 1)) ;
        choosed = choosed(1:replan_num) ;
        for j=1:2
            ulbPool{j} = [ulbPool{j} ; ulbData{j}(choosed, :)] ;
        end
    
        % step 3 : test
        m_test = size(tstData{1}, 1) ;
        clff = zeros(m_test, 2) ;
        for clf=1:numView
            classifier{clf} = nativebayesTrain(lbData{clf}, lbData{3}) ;
            [~, clfC] = nativebayesClassifier(classifier{clf}, tstData{clf}) ;
            clff = clff+clfC ;
        end
        label = zeros(m_test, 1) ;
        for j=1:m_test
            [~,label(j)] = max(clff(j,:)) ;
        end
        label = label - 1 ;
        right_rate(i) = 1-sum(double(label ~= tstData{3}))/m_test ;
    end
    
    %% ploting
    plot(right_rate, 'r*-') ;
    right_rate = mean(right_rate(1:10)) ;
end