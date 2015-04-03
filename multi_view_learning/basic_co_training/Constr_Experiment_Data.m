function [tstData, lbData, ulbData] = Constr_Experiment_Data(viewData, label)
    % function of constructing the data for experiment
    % input : viewData - data of view(2 view)
    %         label - label of view
    % ouput : tstData - 25% labeled data from viewData randomly
    %         lbData - 12 lableled data contain 3 posi and 9 nega randomly
    %         ulbData - remianing labeled data rid of label
    % ---------------------------------------------------------------------
    
    % --- step 1 : constr tstData ---
    m = size(label, 1) ;
    seed = rand(m, 1) ;
    [~, IX] = sort(seed, 'descend') ;
    lbIX = IX(1:fix(m*0.25)) ;
    numView = size(viewData, 2) ;
    tstData = cell(1, numView+1) ;
    for i=1:numView
        tstData{i} = viewData{i}(lbIX,:) ;
    end
    tstData{numView+1} = label(lbIX) ;
    % rstData
    rstIX = IX(fix(m*0.25)+1:end) ;
    rstLabel = label(rstIX) ;
    rstData = cell(1,numView) ;
    for i=1:numView
        rstData{i} = viewData{i}(rstIX,:) ;
    end
    rstData{numView+1} = rstLabel ;
    
    % --- step 2 : constr lbData ---
    m = size(rstLabel, 1) ;
    seed = rand(m, 1) ;
    [~, IX] = sort(seed, 'descend') ;
    posiIX = IX(rstLabel(IX) == 1, :) ;
    posiIX = posiIX(1:9) ;
    negaIX = IX(rstLabel(IX) == 0, :) ;
    negaIX = negaIX(1:9) ;
    lbData = cell(1,numView+1) ;
    for i=1:numView
        lbData{i} = [rstData{i}(posiIX,:) ; rstData{i}(negaIX,:)] ;
    end
    lbData{numView+1} = [rstLabel(posiIX) ; rstLabel(negaIX)] ;
    
    % --- step 3 : constr ulbData ---
    IX(posiIX) = [] ;
    IX(negaIX) = [] ;
    rstIX = IX ;
    ulbData = cell(1,numView) ;
    for i=1:numView
        ulbData{i} = rstData{i}(rstIX,:) ;
    end
end