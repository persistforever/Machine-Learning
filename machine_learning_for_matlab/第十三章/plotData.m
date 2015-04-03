function plotData(dataSet, reconData)
m = size(dataSet, 1) ;
figure ;
hold on ;
for i=1:m
    plot(dataSet(i,1), dataSet(i,2), 'bo') ;
    plot(reconData(i,1), reconData(i,2), 'r.') ;
end
hold off ;
end
