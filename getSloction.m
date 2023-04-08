function [SLocation,SCounts]=getSloction(Foldername)


currentFolder = pwd;
dwiFolder =Foldername;

% 构建dwi文件夹的完整路径
fullDwiFolder = fullfile(currentFolder, dwiFolder);


% for i=1:length(sortedNames)
%     info=dicominfo(fullfile(fullDwiFolder,sortedNames{i}));
%     fprintf('loction %f @ %s\r', info.SliceLocation, sortedNames{i});
% 
% end

%find the first loctionimages



SLocation = [];%位置信息

SCounts=ones(1, 50);

dcmFiles = dir(fullfile(fullDwiFolder, '*.dcm'));

fileNames = {dcmFiles.name};
[~, sortOrder] = natsort(fileNames);

dcmFiles=dcmFiles(sortOrder);



% 遍历所有文件
for i = 1:length(dcmFiles)
    % 读取DICOM文件
    info = dicominfo(fullfile(dcmFiles(1).folder,dcmFiles(i).name));
    
    % 获取b值元数据
    sl = info.SliceLocation;
    
    % 检查b值是否已经出现过
    [lia,loc]=ismember(sl, SLocation);
     if ~lia
         
        SLocation = [SLocation sl];
       fprintf('找到位置为%f的DICOM图像\n', sl);
        
       
     end
     if lia
     SCounts(loc)=SCounts(loc)+1;
     end

    

end
