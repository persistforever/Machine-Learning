[m,n] = size(data) ;
% 绘制散点图
figure ;
hold on ;
for i=1:m
    if data(i,4) == 1
        plot(data(i,1),data(i,2),'r.') ;
    elseif data(i,4) == 2
        plot(data(i,1),data(i,2),'g.') ;
    else
        plot(data(i,1),data(i,2),'b.') ;
    end
end
xlabel('获得飞行常客数量');
ylabel('玩游戏消耗的时间') ;
hold off ;
%绘制散点图
figure ;
[m,n] = size(data) ;
hold on ;
for i=1:m
    if data(i,4) == 1
        plot(data(i,2),data(i,3),'r.') ;
    elseif data(i,4) == 2
        plot(data(i,2),data(i,3),'g.') ;
    else
        plot(data(i,2),data(i,3),'b.') ;
    end
end
xlabel('玩游戏消耗的时间');
ylabel('消费冰激凌的公升') ;
hold off ;
%绘制散点图
figure ;
[m,n] = size(data) ;
hold on ;
for i=1:m
    if data(i,4) == 1
        plot(data(i,1),data(i,3),'r.') ;
    elseif data(i,4) == 2
        plot(data(i,1),data(i,3),'g.') ;
    else
        plot(data(i,1),data(i,3),'b.') ;
    end
end
xlabel('每年获得飞行常客数量');
ylabel('消费冰激凌的公升') ;
hold off ;

%计算距离
dist = zeros(m,m) ;
for i=1:m
    i
    for j=1:m
        temp = data(i,1:3)-data(j,1:3) ;
        dist(i,j) = sqrt(temp*temp') ;
    end
end
%排序得到下标
chose_type = zeros(m,1) ;
for i=1:m
    i
    y = zeros(1,m) ;
    [y,id] = sort(dist(i,:)) ;
    type = zeros(3,1) ;
    for j=1:3
        x = data(id(j),4) ;
        type(x,1) = data(x,4) + 1 ;
    end
    [y,chose_type(i,1)] = max(type) ;
end

wrong_num = 0 ;
wrong_type = 0 ;
for i=1:m
    if chose_type(i,1)~=data(i,4) 
        wrong_num = wrong_num + 1 ;
    end
end
wrong_type = wrong_num/m 
    
    
    
    
    
    
    
    
    
    
    





