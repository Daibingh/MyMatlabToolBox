function writeTextList(data,file)
%writeTextList(data,file)
%���룺
%data��cell�ַ�����
%file��txt�ļ�
fileID = fopen(file,'w');
fprintf(fileID,'%s',data{1});
for i=2:size(data,1)
    fprintf(fileID,'\r\n%s',data{i});
end
fclose(fileID);
end