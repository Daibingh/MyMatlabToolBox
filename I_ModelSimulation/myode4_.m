function [t,x,y]=myode4_(A,B,C,U,ts,x0,h)
%[t,x,y]=myode4_(A,B,C,U,ts,x0,h)
%���� A--ϵͳ����B--�������C--�������������U--���뺯��
%ts--tspan [tmin tmax]��x0--��ֵ��������h--���沽��
%���  x--״̬���� N*n��y--���������
t=(ts(1):h:ts(2))';
N=length(t);        %���沽��
n=length(x0);       %�������
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