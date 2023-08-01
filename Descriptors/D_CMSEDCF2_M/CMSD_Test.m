close all
clear all
[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);

CMSD1=GetCMSD(img1,8,3,3,6,10);

[filename2,pathname2]=uigetfile('*.*','Image 2');
filewithpath2=strcat(pathname2,filename2);
img2=imread(filewithpath2);

CMSD2=GetCMSD(img2,8,3,3,6,10);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(CMSD1); title('CMSD Image 1');
subplot(223); imshow(img2); title('Image 2');
subplot(224); bar(CMSD2); title('CMSD Image 2');


D1=sum(abs(CMSD1-CMSD2));
disp(strcat('D = ', num2str(D1)));
