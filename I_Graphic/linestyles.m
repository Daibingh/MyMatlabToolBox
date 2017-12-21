function str = linestyles(x)
%该函数构建线条的样式库
%输入：x 为样式库中的序号
%输出：str 为相应的字符串，用于在plot命令中作为参数
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

