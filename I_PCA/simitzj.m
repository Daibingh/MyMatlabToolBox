function vv = simitzj(v, d)
%[vv, d] = simitzj(v, d)
%功能：对输入的实对称的特征值，特征向量施密特正交化，单位化
%输入：
%v：特征向量
%d：特征值
%输出：
%vv：正交化单位化后的特征向量
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