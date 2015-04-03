function weakClass = adaBoostTrain(data, grt)
m = size(data,1) ; % ���Լ�����
D = (zeros(m,1)+1)/m ; % ������Ȩ��
g = inline('0.5*log((1-x)/max([1e-6 x]))') ; % ����alpha���㺯��
ClassifyArr = zeros(1,4) ; % ��ʼ��������
aggClass = zeros(m,1) ;
for i=1:grt
    [bestStump, bestClass] = BuildStump(data, D) ;
    alpha = g(bestStump(1,4)) ; % ���������Ȩ��ϵ��
    ClassifyArr = [ClassifyArr ; [bestStump(1,1:3) alpha]] ; % ���ӷ�����
    D = D .* exp(-1*alpha*(bestClass.*data(:,end))) ;
    D = D/sum(D) ;
    aggClass = aggClass + alpha*bestClass ;
    wrong = 1 - sum(sign(aggClass) == data(:,end))/m ;
    if 0 == wrong
        break ;
    end
end
weakClass = ClassifyArr(2:end,:) ;
end