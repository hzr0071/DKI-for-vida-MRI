the exe must use matlab runtime 2022a

use exe in cmd like
DKI_pro dwisfoldername

the dcm files must at dwisfoldername root
it will take 20mins at 20images @ intel i3 10010
the program will create MD&MK dicom-images in each folders

this version support Siemens vida MRI,the dcm SliceLocation at SliceLocation & b-values at Private_0021_1105
the other type you can change that in DKI_pro.m by yourself
DKI生成程序，使用vida至少3个b值的图像，其中一个b值必须在1500以上。
可以修改DKI_pro中的SliceLocation和b-values标签来兼容其他机型。
本程序自动调用多线程，推荐至少4核心@4GHz。
如果使用exe程序需要matlab runtime 2022a，下面是下载地址
https://ssd.mathworks.cn/supportfiles/downloads/R2022a/Release/0/deployment_files/installer/complete/win64/MATLAB_Runtime_R2022a_win64.zip
