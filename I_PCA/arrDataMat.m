function [samples, samplesMean, rawNum, rolNum]=arrDataMat(path, imageNameList, scale)        
%[samples, samplesMean]=arrDataMat(path, imageNameList, scale)
%功能：根据图像名称列表，读取图像数据，并灰度化，转化成 样本数*[scale(1)*scale(2)]数据阵
%输入：
%path：图像路径
%imageNameList：图像名称列表，类型为元胞数组
%scale：图像尺度
%输出：
%samples：数据阵，样本数*[scale(1)*scale(2)]
%samplesMean：样本均值
%rawNum：样本（记录）数
%rolNum：变量（字段）数
rawNum = size(imageNameList,1); %rawNum:样本数
rolNum=scale(1)*scale(2); %原始维度
samples = zeros(rawNum, rolNum);

%准备样本矩阵
 for k=1:rawNum
     imageTemp_ = imread([path,imageNameList{k}]);
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %灰度化
     end
    imageTemp2 = imresize(imageTemp, scale);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
end
samplesMean = mean(samples); %样本均值
end