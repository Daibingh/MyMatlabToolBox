function vv = simitzj(v, d)
%[vv, d] = simitzj(v, d)
%���ܣ��������ʵ�ԳƵ�����ֵ����������ʩ��������������λ��
%���룺
%v����������
%d������ֵ
%�����
%vv����������λ�������������
i=1;
k=0;
n=length(d);
vv=zeros(size(v));
while i<=n
    j=i-k;
    b=0;
    while j<i
        b=b+dot(vv(:,j),v(:,i))/dot(vv(:,j),vv(:,j))*vv(:,j);
        j=j+1;
    end
    vv(:,i)=v(:,i)-b;
    i=i+1;
    if i<=n && d(i)==d(i-1)
        k=k+1;
    else
        k=0;
    end
end
for i=1:n
    vv(:,i)=vv(:,i)/sqrt(dot(vv(:,i),vv(:,i)));
end
end