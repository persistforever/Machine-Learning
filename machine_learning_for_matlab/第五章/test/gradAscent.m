function [theta,wrong] =gradAscent(myData,numGeneration)
plotData(myData); %»­Í¼
[m,n] = size(myData);
k = numGeneration ; %µü´ú´ÎÊý
myData = [zeros(m,1)+1 myData];
x = myData(:,1:end-1);
y = myData(:,end);
sita = zeros(n,k+1)+1 ;
alpha = 0.01 ; 
error = zeros(k,1);
for i=2:k+1
    sita(:,i) = sita(:,i-1) + alpha * x' * (y-sigmoid(x*sita(:,i-1))) ;
    error(i,1) = 0.5*(sum(y-sigmoid(x*sita(:,i))))^2 ;
end
%»­Í¼
rate = -sita(2,k+1)./sita(3,k+1) ;
dist = -sita(1,k+1)./sita(3,k+1) ;
xDm = -4:4 ;
plot(xDm,rate*xDm+dist,'g');
theta = sita(:,2:end) ;
wrong = error(2:end,1) ;
figure ;
plot(wrong);
figure ;
subplot(3,1,1); plot(theta(1,:));
subplot(3,1,2); plot(theta(2,:));
subplot(3,1,3); plot(theta(3,:));
end