function symtf = symtf(num,den)
%symtf = symtf(num,den)
%输入：
%num,den：分子分母多项式向量
%输出：
%symtf：传递函数符号表达式
nums=poly2sym(num,'s');
dens=poly2sym(den,'s');
symtf=nums/dens;
end