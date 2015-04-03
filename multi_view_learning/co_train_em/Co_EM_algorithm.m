function [right_rate] = Co_EM_algorithm(lbData, ulbData, tstData)
    % function of co EM algorightm
    % input : lbData - labeled training examples
    %         ulbData - unlabeled examples
    %         tstData - test examples to examine 
    % ---------------------------------------------------------------------
    
    % step 1 : init param with lbData{1}
    numView = size(ulbData, 2) ;
    classifier{1} = nativebayesTrain(lbData{1}, lbData{3}) ;
    classifier{2} = nativebayesTrain(lbData{2}, lbData{3}) ;
    
    k = 10 ;
    right_rate = zeros(k,1) ;
    % step 2 : loop for k iterations 
    for i=1:k
        for j=1:numView
            other = 3-j ;
            % E step
            [labelC, ~] = nativebayesClassifier(classifier{j}, ulbData{j}) ;
            
            % M step
            classifier{other} = nativebayesTrain([lbData{other} ; ulbData{other}], [lbData{3} ; labelC]) ;
        end
    
        % step 3 : test
        m_test = size(tstData{1}, 1) ;
        clff = zeros(m_test, 2) ;
        for clf=1:numView
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
    plot(right_rate, 'r.-') ;
end