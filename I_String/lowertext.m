function lowertext(inputFile,outputFile)
% �ú���ʵ�ֽ�inputFile�ı��еĴ�д��ĸת����Сд��ĸ
% �������outputFile�ı���
% inputFile: �����ļ��������磬xxx.txt
% outputFile: ����ļ���
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