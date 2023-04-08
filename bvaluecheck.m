function [sortedNames,bValues,bCounts]=bvaluescheck(filename)

fileID = fopen('logbvaluescheck.txt','w');
% 获取当前工作目录（即MATLAB运行时所在的文件夹）
currentFolder = pwd;
dwiFolder = filename;

% 构建dwi文件夹的完整路径
fullDwiFolder = fullfile(currentFolder, dwiFolder);

% 获取dwi文件夹中所有后缀为.dcm的文件名
dcmFiles = dir(fullfile(fullDwiFolder, '*.dcm'));

% % 获取文件夹中所有DICOM图像的文件名
% dcmFiles = dir('*.dcm');
numFiles = length(dcmFiles);

fileNames = {dcmFiles.name};
[sortedNames, sortOrder] = natsort(fileNames);

% 遍历所有文件，读取b值元数据并统计

% 创建一个空的b值列表和计数器
bValues = [];

bCounts=ones(1, 20);
% 遍历所有文件
for i = 1:length(dcmFiles)
    % 读取DICOM文件
    info = dicominfo(fullfile(dcmFiles(1).folder,sortedNames{i}));
    
    % 获取b值元数据
    bValue = info.Private_0021_1105;
    
    % 检查b值是否已经出现过
    [lia,loc]=ismember(bValue, bValues);
     if ~lia
         
        bValues = [bValues bValue];
       fprintf(fileID,'找到b值为%d的DICOM图像\n', bValue);
        
       
     end
     if lia
     bCounts(loc)=bCounts(loc)+1;
     end

    

end

% 打印每个b值出现的次数
for i = 1:length(bValues)
    fprintf(fileID,'b value %d appears in %d images\n', bValues(i), bCounts(i));
end
fclose(fileID);
end
