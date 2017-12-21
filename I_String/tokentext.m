function tokentext(inputFile,outputFile,tok)
%用于代码前面标号的去除
% 并输出到outputFile文本中
% inputFile: 输入文件名，例如，xxx.txt
% outputFile: 输出文件名
% tok: 分隔符
    p = fopen(inputFile,'r');
    if p == -1
        disp('can not find file!');
    end
    i = 1;
    while ~feof(p)
        line = fgets(p);
        [~, remain] = strtok(line,tok);
        text{i} = remain(2:end);
        i = i + 1;
    end
    if fclose(p)==-1
        disp('can not close file successfully!');
    end

    file2 = 'abc_2.txt';  % save file
    pp = fopen(outputFile,'w');
    if pp == -1
        disp('can not find file!');
    end
    for j = 1:length(text);
        fprintf(pp,'%s',text{j});
    end
    if fclose(pp)==-1
        disp('can not close file successfully!');
    end
end