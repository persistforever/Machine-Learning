% --- constr. experiment data as tstData, lbData, ulbData
[ctView, lkView, label] = Data_Preprocessing() ;
viewData = {ctView, lkView} ;
[tstData, lbData, ulbData] = Constr_Experiment_Data(viewData, label) ;