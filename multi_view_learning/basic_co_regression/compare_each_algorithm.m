%% construct_dataset
[lData, uData, tData] = construct_dataset(-2*pi, 2*pi, 5000) ;

%% COREG_algorithm
[error_coreg, L_coreg] = COREG_algorithm(lData, uData, tData, 3, 100, [2 5]) ;
for i=1:size(error_coreg,1)
    if error_coreg(i) == 0
        break ;
    end
end
error_coreg(i:end) = error_coreg(i-1) ;

%% basic_kNN_algorithm
[error_knn1, L_knn1] = basic_kNN_algorithm(lData, uData, tData, 3, 100, 2);
[error_knn2, L_knn2] = basic_kNN_algorithm(lData, uData, tData, 3, 100, 5);
for i=1:size(error_knn1,1)
    if error_knn1(i) == 0
        break ;
    end
end
error_knn1(i:end) = error_knn1(i-1) ;
for i=1:size(error_knn2,1)
    if error_knn2(i) == 0
        break ;
    end
end
error_knn2(i:end) = error_knn2(i-1) ;

%% LABELED
[error_labeled] = LABELED_algorithm(lData, tData, 3, 100, 2) ;

%% ploting
figure ;
title('2-d Mexican Hat') ;
xlabel('iterations') ;
ylabel('MSE') ;
hold on ;
plot(error_coreg, 'r') ;
plot(error_knn1, 'g') ;
plot(error_knn2, 'b') ;
plot(error_labeled, 'y') ;
legend('COREG', 'KNN1', 'KNN2', 'LABELED') ;
hold off ;