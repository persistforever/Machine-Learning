function [wrong, class] = StumClassify(data, dim, thead, ineq, D)
m = size(data,1) ;
preditcVec = zeros(m,1) ; % 预测
errorVec = zeros(m,1) ; % 错误
if 1 == ineq % 小于号
    for i=1:m
        if data(i,dim) <= thead
            predictVec(i,1) = -1 ;
        else
            predictVec(i,1) = 1 ;
        end
    end
else % 大于等于号
   for i=1:m
        if data(i,dim) > thead
            predictVec(i,1) = -1 ;
        else
            predictVec(i,1) = 1 ;
        end
    end
end
class = predictVec ; 
errorVec(:,1) = ( predictVec(:,1) == data(:,end) ) ;
wrong = 1-D'*errorVec ; % 计算错误率
end