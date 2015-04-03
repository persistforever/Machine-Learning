function [theta,wrong] =impStocGradAscent(myData,numGeneration)
plotData(myData); %画图
[m,n] = size(myData);
k = m ; %i迭代次数
g = numGeneration ; %j迭代次数
myData = [zeros(m,1)+1 myData];
x = myData(:,1:end-1);
y = myData(:,end);
alpha = 0.01 ; 
sita = zeros(n,k+1)+1 ;
theta = zeros(n,g*k)+1 ;
error = zeros(k,1);
wrong = zeros(g*k,1);
for j=1:g
    index = 1:1:m ;
    for i=2:k+1
        alpha = 4/(1+j+i) + 0.01 ;
        temp = randi([1,numel(index)]) ;
        index(find(index == temp)) = [] ;
        sita(:,i) = sita(:,i-1) + alpha * x(temp,:)' * (y(temp)-sigmoid(x(temp,:)*sita(:,i-1))) ;
        error(i-1,1) = 0.5*(sum(y-sigmoid(x*sita(:,i))))^2 ;
    end
    theta(:,(j-1)*k+1:j*k) = sita(:,2:k+1);
    wrong((j-1)*k+1:j*k,1) = error(:,1);
    sita(:,1) = sita(:,k+1);
end
%画图
rate = -sita(2,k+1)./sita(3,k+1) ;
dist = -sita(1,k+1)./sita(3,k+1) ;
xDm = -4:4 ;
plot(xDm,rate*xDm+dist,'g');
figure ;
plot(wrong);
figure ;
subplot(3,1,1) ; plot(theta(1,:));
subplot(3,1,2) ; plot(theta(2,:));
subplot(3,1,3) ; plot(theta(3,:));
end