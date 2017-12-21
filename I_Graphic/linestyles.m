function str = linestyles(x)
%�ú���������������ʽ��
%���룺x Ϊ��ʽ���е����
%�����str Ϊ��Ӧ���ַ�����������plot��������Ϊ����
LineStyles = {'-','--',':','-.'};
MarkerSpecs = {'+','o','*','.','x','s','d','^','v','>','<','p','h'};
ColorSpecs = {'r','g','b','k','y','m','c'};
cnt = 1;
for i = 1:length(LineStyles)
    for j = 1:length(MarkerSpecs)
        for k = 1:length(ColorSpecs)
            LineSpecs{cnt} = [LineStyles{i} MarkerSpecs{j} ...
                ColorSpecs{k}];
            cnt = cnt+1;
        end
    end
end
str=LineSpecs{x};
end

