function plotData(dataSet, centroid)
figure ;
hold on ;
plot(dataSet(:,1), dataSet(:,2), 'ob') ;
plot(centroid(:,1), centroid(:,2), '+r') ;
end