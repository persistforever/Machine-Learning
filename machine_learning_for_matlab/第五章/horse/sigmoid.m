function y = sigmoid(x)
[m,n] = size(x) ;
y = zeros(m,n) ;
for i=1:m
    for j=1:n
        y(i,j) = 1/(1+exp(-x(i,j))) ;
    end
end
end