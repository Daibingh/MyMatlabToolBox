function [t,x]=yeuler(fun,x0,ts,h)
%运用隐式欧拉法求解一阶方程组
%[t,x]=yeuler(fun,x0,ts,h)
t=(ts(1):h:ts(2))';
n=length(t);
N=length(x0);
x=[x0';zeros(n-1,N)];
for k=1:n-1
    tk=t(k);
    tk1=t(k+1);
    xk=(x(k,:))';
    xk1_p=xk+h*fun(tk,xk);  %先用显式欧拉预报在tk+1时刻的值
    x(k+1,:)=(iter(fun,tk1,xk,xk1_p,h))';  %然后利用预报值作为初值，在tk+1处反复迭代
end
end
function xx=iter(fun,tk1,xk,xk1_p,h)    %用于迭代的子函数
e=0.0001;
xk1=xk+h*fun(tk1,xk1_p); 
while(abs(xk1-xk1_p)>e)
    xk1_p=xk1;
    xk1=xk+h*fun(tk1,xk1_p);
end
xx=xk1;
end