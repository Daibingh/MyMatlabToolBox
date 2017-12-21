function [numz,denz]=mys2z(nums,dens,Ts)
%[numz,denz]=mys2z(nums,dens,Ts)
%功能：将s域传递函数变换到z域
%输入：
%nums,dens 连续系统以s为变量分子，分母多项式
%输出：
%numz，denz 离散系统以z为变量分子，分母多项式
syms t n s z;
Gs_num=poly2sym(nums);
Gs_den=poly2sym(dens);
Gs=Gs_num/Gs_den;
ft=ilaplace(Gs); %对连续传函Laplace反变换
Gnt=subs(ft,t,n*Ts); %离散化
Gz=ztrans(Gnt); %z变换
[a,b]=numden(Gz); %numden函数将符号表达式的分子与分母分离
numz=sym2poly(a);
denz=sym2poly(b);
end