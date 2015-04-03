function [theta,wrong] =gradAscent(myData,numGeneration)
[m,n] = size(myData);
k = m ; %i迭代次数
g = numGeneration ; %j迭代次数
myData = [zeros(m,1)+1 myData];
x = myData(:,1:end-1);
y = myData(:,end);
alpha = 0.01 ; 
sita = zeros(n,1)+1 ;
for j=1:g
    sita = sita + alpha * x' * (y-sigmoid(x*sita)) ;
end
theta = sita ;
end