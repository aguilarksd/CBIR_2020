close all
clear all
[filename1,pathname1]=uigetfile('*.*','Image');
filewithpath1=strcat(pathname1,filename1);
img=imread(filewithpath1);

[img1]=Get_Sobel(img,0);
[img2]=Get_SobelFrac(img,0.5,0);
[img3]=Get_SobelFrac(img,0.9,0);
[img4]=Get_SobelFrac(img,1.5,0);
[img5]=Get_SobelFrac(img,2,0);
[img6]=Get_SobelFrac(img,2.5,0);

%[RGBv,RGBh,RGBg,V,H] = Get_MD_TOD(img);  

figure(1)
subplot(3,3,[1 2]); imshow(img); title('Image');
subplot(3,3,3); imshow(img1); title('Sobel');
subplot(3,3,4); imshow(img2); title('Sobel 0.5');
subplot(3,3,5); imshow(img3); title('Sobel 0.9');
subplot(3,3,6); imshow(img4); title('Sobel 1.5');
subplot(3,3,7); imshow(img5); title('Sobel 2');
subplot(3,3,8); imshow(img6); title('Sobel 2.5');
