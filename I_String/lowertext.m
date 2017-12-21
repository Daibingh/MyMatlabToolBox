function lowertext(inputFile,outputFile)
% 该函数实现将inputFile文本中的大写字母转换成小写字母
% 并输出到outputFile文本中
% inputFile: 输入文件名，例如，xxx.txt
% outputFile: 输出文件名
    p = fopen(inputFile,'r');
    if p == -1
        disp('can not find file!');
    end;
    i=1;
    while ~feof(p)
        line=fgets(p);
        line2=lower(line);
        text{i}=line2;
        i=i+1;
    end
    if fclose(p)==-1
        disp('can not close file successfully!');
    end

    pp = fopen(outputFile,'w');
    if pp == -1
        disp('can not find file!');
    end
    for j=1:length(text)
        fprintf(pp,'%s',text{j});
    end
    if fclose(pp)==-1
        disp('can not close file successfully!');
    end
end