function [right_rate] = Basic_EM_Algorithm(lbData, ulbData, tstData)
    % function of basic EM algorightm
    % input : lbData - labeled training examples
    %         ulbData - unlabeled examples
    %         tstData - test examples to examine 
    % ---------------------------------------------------------------------
    
    % step 1 : init param with lbData{1}
    view_seq = 2 ;
    classifier = nativebayesTrain(lbData{view_seq}, lbData{3}) ;
    
    k = 10 ;
    right_rate = zeros(k,1) ;
    % step 2 : loop for k iterations 
    for i=1:k
%         [labelC, ~] = nativebayesClassifier(classifier, ulbData{view_seq}) ;
%         classifier = nativebayesTrain([lbData{view_seq} ; ulbData{view_seq}], [lbData{3} ; labelC]) ;
    
        % step 3 : test
        m_test = size(tstData{view_seq}, 1) ;
        [label, ~] = nativebayesClassifier(classifier, tstData{view_seq}) ;
        right_rate(i) = sum(double(label == tstData{3}))/m_test ;
    end
    
%     %% ploting
%     plot(right_rate, 'r.-') ;
end