function [numz,denz]=mys2z(nums,dens,Ts)
%[numz,denz]=mys2z(nums,dens,Ts)
%���ܣ���s�򴫵ݺ����任��z��
%���룺
%nums,dens ����ϵͳ��sΪ�������ӣ���ĸ����ʽ
%�����
%numz��denz ��ɢϵͳ��zΪ�������ӣ���ĸ����ʽ
syms t n s z;
Gs_num=poly2sym(nums);
Gs_den=poly2sym(dens);
Gs=Gs_num/Gs_den;
ft=ilaplace(Gs); %����������Laplace���任
Gnt=subs(ft,t,n*Ts); %��ɢ��
Gz=ztrans(Gnt); %z�任
[a,b]=numden(Gz); %numden���������ű��ʽ�ķ������ĸ����
numz=sym2poly(a);
denz=sym2poly(b);
end