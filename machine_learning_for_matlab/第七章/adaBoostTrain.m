function weakClass = adaBoostTrain(data, grt)
m = size(data,1) ; % 测试集数量
D = (zeros(m,1)+1)/m ; % 样本的权重
g = inline('0.5*log((1-x)/max([1e-6 x]))') ; % 定义alpha计算函数
ClassifyArr = zeros(1,4) ; % 初始化分类器
aggClass = zeros(m,1) ;
for i=1:grt
    [bestStump, bestClass] = BuildStump(data, D) ;
    alpha = g(bestStump(1,4)) ; % 计算分类器权重系数
    ClassifyArr = [ClassifyArr ; [bestStump(1,1:3) alpha]] ; % 增加分类器
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