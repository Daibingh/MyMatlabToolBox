function list = readTxtList(file)
%function list = readTxtList(file)
%输入：
%file：txt文件名
%输出：
%list：cell字符数组
fileID = fopen(file,'r');
i=1;
while(~feof(fileID))
    list{i,:} = fgetl(fileID);
    i=i+1;
end
fclose(fileID);
end