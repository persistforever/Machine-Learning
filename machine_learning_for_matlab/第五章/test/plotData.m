function y=plotData(myData)
[m,n] = size(myData);
figure ;
hold on ;
for i=1:m
    if myData(i,end) == 0
        plot(myData(i,1),myData(i,2),'ro');
    else
        plot(myData(i,1),myData(i,2),'b.');
    end
end
end