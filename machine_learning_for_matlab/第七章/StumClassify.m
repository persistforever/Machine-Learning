function [wrong, class] = StumClassify(data, dim, thead, ineq, D)
m = size(data,1) ;
preditcVec = zeros(m,1) ; % Ԥ��
errorVec = zeros(m,1) ; % ����
if 1 == ineq % С�ں�
    for i=1:m
        if data(i,dim) <= thead
            predictVec(i,1) = -1 ;
        else
            predictVec(i,1) = 1 ;
        end
    end
else % ���ڵ��ں�
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
wrong = 1-D'*errorVec ; % ���������
end