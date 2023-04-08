function writeDKI(imagesql,MD,MK,fullDwiFolder)
% 构建dwi文件夹的完整路径


currentFolder = pwd;

% dwiFolder ="dwi";
% fullDwiFolder = fullfile(currentFolder, dwiFolder);

%%
mkdir("MD")
Folder ="MD";
outfolder = fullfile(currentFolder, Folder);

outputname= imagesql(1).name;
     outputinfo=dicominfo(fullfile(fullDwiFolder,imagesql(1).name));
     outputinfo.SeriesInstanceUID=[outputinfo.SeriesInstanceUID,'001'];
     outputinfo.SeriesNumber=outputinfo.SeriesNumber+1000;
    outputinfo.SeriesDescription=[outputinfo.SeriesDescription,'_MD'];

dicomwrite(MD/0.665,fullfile(outfolder,outputname),outputinfo);


%%
mkdir("MK")
Folder ="MK";
outfolder = fullfile(currentFolder, Folder);

outputname= imagesql(1).name;
     outputinfo=dicominfo(fullfile(fullDwiFolder,imagesql(1).name));
     outputinfo.SeriesInstanceUID=[outputinfo.SeriesInstanceUID,'002'];
     outputinfo.SeriesNumber=outputinfo.SeriesNumber+1001;
    outputinfo.SeriesDescription=[outputinfo.SeriesDescription,'_MK'];

dicomwrite(MK/665,fullfile(outfolder,outputname),outputinfo);


end