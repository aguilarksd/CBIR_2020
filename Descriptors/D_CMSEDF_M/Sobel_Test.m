close all
clear all
[filename1,pathname1]=uigetfile('*.*','Image');
filewithpath1=strcat(pathname1,filename1);
img=imread(filewithpath1);

[img1]=Get_Sobel(img,0);
%[img2]=Get_SobelFrac(img,0.5,0);

[RGBv,RGBh,RGBg,V,H] = Get_MD_TOD(img);  

figure(1)
subplot(3,3,[1 2]); imshow(img); title('Image');
subplot(3,3,3); imshow(img1); title('Sobel');
subplot(3,3,4); imshow(RGBv); title('Sobel Vertical color');
subplot(3,3,5); imshow(RGBh); title('Sobel Horizontal color');
subplot(3,3,6); imshow(RGBg); title('Sobel gradiente color');
subplot(3,3,7); imshow(V); title('Sobel Magnitud vertical');
subplot(3,3,8); imshow(H); title('Sobel Magnitud Horizontal');
