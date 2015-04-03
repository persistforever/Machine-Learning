function [bestStump, bestClass] = BuildStump(data, D)
[m,n] = size(data) ;
step = 10 ; % 步数为10
minWrong = 1 ; % 最小错误率
recordNum = 0 ; % 记录个数
for i=1:n-1 % 每一个纬度
    minAsix = min(data(:,i)) ; %最小坐标
    maxAsix = max(data(:,i)) ; %最大坐标
    stepLen = fix(maxAsix-minAsix)/step ; %步长
    for j=1:step+1
        thead = minAsix + (j-2)*stepLen ;
        for k=1:2
            recordNum = recordNum + 1 ;
            [wrong, errorVec] = StumClassify(data, i, thead, k, D) ; % 获得分类器的错误率
            if wrong < minWrong
                minWrong = wrong ;
                bestClass = errorVec ;
                bestStump = [i k thead minWrong] ;
            end
        end
    end
end
if 1 == bestStump(1,2)
fprintf('The Stump is in dimention %d when value is <= %.2f, the rate of wrong is %.2f\n', ...
    bestStump(1,1), bestStump(1,3), bestStump(1,4)) ;
else
fprintf('The Stump is in dimention %d when value is > %.2f, the rate of wrong is %.2f\n', ...
    bestStump(1,1), bestStump(1,3), bestStump(1,4)) ;
end
end