function DKI_pro(foldername)

fig=waitbar(0,"DKI pro正在启动，请等待!");

foldername=string(foldername);
currentFolder = pwd;
dwiFolder =foldername;

% 构建dwi文件夹的完整路径
fullDwiFolder = fullfile(currentFolder, dwiFolder);

[sortedNames,bValues,bCounts]=bvaluecheck(dwiFolder);

[SLocation,SCounts]=getSloction(dwiFolder);

locnum=length(sortedNames)/length(bValues);

fileID = fopen('logmain.txt','w');

 for slicei=1:locnum
%  for slicei=12:12
loction1=SLocation(slicei);

fprintf(fileID,"正在计算第%d张\n",slicei);
msg=sprintf("正在处理第%d张/共%d张,不要关闭任何窗口",slicei,locnum);
    % Read mini-batch of data.
    waitbar(slicei/locnum,fig,msg);
%%%%%生成imagesql
imagenames={};
imagesql={};


for i=1:length(sortedNames)

   loction2=dicominfo(fullfile(fullDwiFolder,sortedNames{i})).SliceLocation;
   if loction2==loction1
   imagenames(end+1)=sortedNames(i);
   imagesql(end+1).name=sortedNames(i);
   imagesql(end).bvalus=dicominfo(fullfile(fullDwiFolder,sortedNames{i})).Private_0021_1105;
%    fprintf("findimage %s @ loc %f\n",sortedNames{i},loction2);
   end

end
% logfolder=sprintf("savelog_%d",slicei);
% mkdir(logfolder);
calculateDKI(imagesql,fullDwiFolder);
end

%%%%
fprintf(fileID,"处理完成\n");
msg=sprintf("处理完成，请关闭窗口");
waitbar(1,fig,msg);
fclose(fileID);
end
