function res = classifyVector(vector, theta)
res = sigmoid(vector * theta) ;
if res>=0.5
    res = 1.0 ;
else 
    res = 0.0 ;
end
end