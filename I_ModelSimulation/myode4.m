function [t,x]=myode4(fun,ts,x0,h)
%[t,x]=myode4(fun,ts,x0,h)
t=(ts(1):h:ts(2))';
N=length(t);
n=length(x0);
x=[x0';zeros(N-1,n)];
for k=1:N-1
    tk=t(k);
    xk=x(k,:)';
    k1=fun(tk,xk);
    k2=fun(tk+h/2,xk+h/2*k1);
    k3=fun(tk+h/2,xk+h/2*k2);
    k4=fun(tk+h,xk+h*k3);
    x(k+1,:)=(xk+h*(k1+2*k2+2*k3+k4)/6)';
end
end