function [t,x]=euler(fun,x0,tspan,h)
%用欧拉法求解微分方程，适用于微分方程组，即fun可为向量函数
%[t,x]=euler(fun,x0,tspan,h)
t=(tspan(1):h:tspan(2))';
n=length(t); 
N=length(x0);
x=[x0';zeros(n-1,N)];
for k=1:n-1
    tk=t(k);
    xk=(x(k,:))';
    x(k+1,:)=(xk+h*fun(tk,xk))';
end
end