function tokentext(inputFile,outputFile,tok)
%���ڴ���ǰ���ŵ�ȥ��
% �������outputFile�ı���
% inputFile: �����ļ��������磬xxx.txt
% outputFile: ����ļ���
% tok: �ָ���
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