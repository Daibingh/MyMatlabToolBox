function symtf = symtf(num,den)
%symtf = symtf(num,den)
%���룺
%num,den�����ӷ�ĸ����ʽ����
%�����
%symtf�����ݺ������ű��ʽ
nums=poly2sym(num,'s');
dens=poly2sym(den,'s');
symtf=nums/dens;
end