function [theta,wrong] =impStocGradAscent(myData,numGeneration)
[m,n] = size(myData);
k = m ; %i迭代次数
g = numGeneration ; %j迭代次数
myData = [zeros(m,1)+1 myData];
x = myData(:,1:end-1);
y = myData(:,end);
alpha = 0.01 ; 
sita = zeros(n,1)+1 ;
wrong = zeros(g*m,1) ;
for j=1:g
    index = 1:1:m ;
    for i=2:k+1
        alpha = 4/(1+j+i) + 0.01 ;
        temp = randi([1,numel(index)]) ;
        index(find(index == temp)) = [] ;
        sita = sita + alpha * x(temp,:)' * (y(temp)-sigmoid(x(temp,:)*sita)) ;
        wrong((j-1)*k+i-1,1) = 0.5*(sum(y-sigmoid(x*sita)))^2 ;
    end
end
theta = sita ;
end