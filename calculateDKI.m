function calculateDKI(imagesql,fullDwiFolder)
%%对imagesql进行排序
imagesql=struct2table(imagesql);
[bValues, sortOrder] = sort(imagesql.bvalus);

imagesql=table2struct(imagesql);
imagesql=imagesql(sortOrder);

bValues=bValues.';
%%

maskimg=dicomread(fullfile(fullDwiFolder,imagesql(1).name));

maskimg=Lpf_hanning(maskimg,32);
maskimg=abs(maskimg);
 maskimg=imbinarize(abs(maskimg),30);

for i=1:length(imagesql)

    imagetmp(:,:,i)=dicomread(fullfile(fullDwiFolder,imagesql(i).name)).*uint16(maskimg);

    %%i为第i个b值的图像

end



[len,wid]=size(imagetmp(:,:,1));


MD=zeros(len,wid);
MK=zeros(len,wid);

wid=wid-6;

parfor m=6:(len-6)
%      fprintf("正在计算第%d行\n",m);
    for n=6:wid

S=ones(1,length(imagesql));
S=double(S);
for i=1:length(imagesql)
    
      S(i)=imagetmp(m,n,i);

end


if (min(min(S))<1)
continue;
end

% figure(1);
% plot(bValues,S);
%% DKI模型拟合

% S = sort(S,'descend');%尝试排序解决跳变问题
% y=S./(S(1));
y=-log(S./S(1));

% y=y(1:end);
b=bValues;
% b=b(1:end);
%%
% y=y([1,9:end]);
% b=b([1,9:end]);%挑选计算的b值
%%
fun=@(x)b.*x(1)-b.^2.*x(1)^2.*x(2)./6-y;
x0=[0.005,0.3];


options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off');
x=lsqnonlin(fun,x0,[0,0],[1,3],options);

% 输出结果

MD(m,n)=x(1);
MK(m,n)=x(2);

%%
% log调试
% b=b(1:10);
% fi=figure(1);
% clf(fi);
% plot(b,y(1:10));
% hold on;
% s1=x(1)*exp(-b*(x(2)+x(3)))+(1-x(1))*exp(-b*x(2));
% plot(b,s1);
% savefigure(fullfile(logfolder,sprintf("%d_%d.jpg",m,n)));
%
%
    end
end

 writeDKI(imagesql,MD,MK,fullDwiFolder);%%写入dicom文件

end