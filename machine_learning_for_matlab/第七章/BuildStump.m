function [bestStump, bestClass] = BuildStump(data, D)
[m,n] = size(data) ;
step = 10 ; % ����Ϊ10
minWrong = 1 ; % ��С������
recordNum = 0 ; % ��¼����
for i=1:n-1 % ÿһ��γ��
    minAsix = min(data(:,i)) ; %��С����
    maxAsix = max(data(:,i)) ; %�������
    stepLen = fix(maxAsix-minAsix)/step ; %����
    for j=1:step+1
        thead = minAsix + (j-2)*stepLen ;
        for k=1:2
            recordNum = recordNum + 1 ;
            [wrong, errorVec] = StumClassify(data, i, thead, k, D) ; % ��÷������Ĵ�����
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