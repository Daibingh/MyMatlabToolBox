function [t,x]=yeuler(fun,x0,ts,h)
%������ʽŷ�������һ�׷�����
%[t,x]=yeuler(fun,x0,ts,h)
t=(ts(1):h:ts(2))';
n=length(t);
N=length(x0);
x=[x0';zeros(n-1,N)];
for k=1:n-1
    tk=t(k);
    tk1=t(k+1);
    xk=(x(k,:))';
    xk1_p=xk+h*fun(tk,xk);  %������ʽŷ��Ԥ����tk+1ʱ�̵�ֵ
    x(k+1,:)=(iter(fun,tk1,xk,xk1_p,h))';  %Ȼ������Ԥ��ֵ��Ϊ��ֵ����tk+1����������
end
end
function xx=iter(fun,tk1,xk,xk1_p,h)    %���ڵ������Ӻ���
e=0.0001;
xk1=xk+h*fun(tk1,xk1_p); 
while(abs(xk1-xk1_p)>e)
    xk1_p=xk1;
    xk1=xk+h*fun(tk1,xk1_p);
end
xx=xk1;
end