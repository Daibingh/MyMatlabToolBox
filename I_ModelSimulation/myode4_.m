function [t,x,y]=myode4_(A,B,C,U,ts,x0,h)
%[t,x,y]=myode4_(A,B,C,U,ts,x0,h)
%输入 A--系统矩阵；B--输入矩阵；C--输出列行向量；U--输入函数
%ts--tspan [tmin tmax]；x0--初值列向量；h--仿真步长
%输出  x--状态变量 N*n；y--输出列向量
t=(ts(1):h:ts(2))';
N=length(t);        %仿真步数
n=length(x0);       %仿真阶数
x=[x0';zeros(N-1,n)];
for k=1:N-1
    tk=t(k);
    xk=x(k,:)';
    k1=A*xk+B*U(tk);
    k2=A*(xk+h/2*k1)+B*U(tk+h/2);
    k3=A*(xk+h/2*k2)+B*U(tk+h/2);
    k4=A*(xk+h*k3)+B*U(tk+h);
    x(k+1,:)=(xk+h*(k1+2*k2+2*k3+k4)/6)';
end
y=x*C';
end