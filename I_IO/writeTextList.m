function writeTextList(data,file)
%writeTextList(data,file)
%输入：
%data：cell字符数组
%file：txt文件
fileID = fopen(file,'w');
fprintf(fileID,'%s',data{1});
for i=2:size(data,1)
    fprintf(fileID,'\r\n%s',data{i});
end
fclose(fileID);
end