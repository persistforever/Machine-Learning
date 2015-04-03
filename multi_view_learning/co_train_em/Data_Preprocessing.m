function [ctView, lkView, label] = Data_Preprocessing()
    % function of data preprocessing, from 'task*.mat'
    % dataSet : set L of labeled examples
    %           set U of unlabeled examples
    %           set U' of u examples randomly from U
    % ---------------------------------------------------------------------
    
    % create ctView and lkView with 1040 labeled examples
    ctView = zeros(1, 2500) ;
    lkView = zeros(1, 859) ;
    label = zeros(1, 1) ;
    for i=1:4
        data = importdata(strcat('task', num2str(i), '.mat')) ;
        ctView = [ctView ; data.fea{1,1}] ;
        lkView = [lkView ; data.fea{1,2}] ;
        label = [label ; data.gnd] ;
    end
    ctView(1,:) = [] ;
    lkView(1,:) = [] ;
    label(1,:) = [] ;
    ctView( ctView~=0 ) = 1 ;
    lkView( lkView~=0 ) = 1 ;
    posi_IX = find(label == 1) ;
    nege_IX = find(label == 4) ;
    ctView = [ctView(posi_IX, :) ; ctView(nege_IX, :)] ;
    lkView = [lkView(posi_IX, :) ; lkView(nege_IX, :)] ;
    label = [label(posi_IX, :) ; label(nege_IX,:)] ;
    label(label ~= 1) = 0 ;
end