function list = readTxtList(file)
%function list = readTxtList(file)
%���룺
%file��txt�ļ���
%�����
%list��cell�ַ�����
fileID = fopen(file,'r');
i=1;
while(~feof(fileID))
    list{i,:} = fgetl(fileID);
    i=i+1;
end
fclose(fileID);
end