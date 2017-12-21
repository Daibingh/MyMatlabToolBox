function [samples, samplesMean, rawNum, rolNum]=arrDataMat(path, imageNameList, scale)        
%[samples, samplesMean]=arrDataMat(path, imageNameList, scale)
%���ܣ�����ͼ�������б���ȡͼ�����ݣ����ҶȻ���ת���� ������*[scale(1)*scale(2)]������
%���룺
%path��ͼ��·��
%imageNameList��ͼ�������б�����ΪԪ������
%scale��ͼ��߶�
%�����
%samples��������������*[scale(1)*scale(2)]
%samplesMean��������ֵ
%rawNum����������¼����
%rolNum���������ֶΣ���
rawNum = size(imageNameList,1); %rawNum:������
rolNum=scale(1)*scale(2); %ԭʼά��
samples = zeros(rawNum, rolNum);

%׼����������
 for k=1:rawNum
     imageTemp_ = imread([path,imageNameList{k}]);
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %�ҶȻ�
     end
    imageTemp2 = imresize(imageTemp, scale);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
end
samplesMean = mean(samples); %������ֵ
end