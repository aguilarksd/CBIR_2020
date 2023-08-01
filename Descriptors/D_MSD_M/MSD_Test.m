[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);

MSD1=GetMSD(img1);

[filename2,pathname2]=uigetfile('*.*','Image 2');
filewithpath2=strcat(pathname2,filename2);
img2=imread(filewithpath2);

MSD2=GetMSD(img2);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(MSD1); title('MSD Image 1');
subplot(223); imshow(img2); title('Image 2');
subplot(224); bar(MSD2); title('MSD Image 2');

D1=sum(abs(MSD1-MSD2));
disp(strcat('D = ', num2str(D1)));
