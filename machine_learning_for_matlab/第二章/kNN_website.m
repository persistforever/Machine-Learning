[m,n] = size(data) ;
% ����ɢ��ͼ
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
xlabel('��÷��г�������');
ylabel('����Ϸ���ĵ�ʱ��') ;
hold off ;
%����ɢ��ͼ
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
xlabel('����Ϸ���ĵ�ʱ��');
ylabel('���ѱ�����Ĺ���') ;
hold off ;
%����ɢ��ͼ
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
xlabel('ÿ���÷��г�������');
ylabel('���ѱ�����Ĺ���') ;
hold off ;

%�������
dist = zeros(m,m) ;
for i=1:m
    i
    for j=1:m
        temp = data(i,1:3)-data(j,1:3) ;
        dist(i,j) = sqrt(temp*temp') ;
    end
end
%����õ��±�
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
    
    
    
    
    
    
    
    
    
    
    





