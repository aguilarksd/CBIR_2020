[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);

MIFH1=GetMIFH(img1,6,3,3,16,'Avg',0,1);

%[filename1,pathname1]=uigetfile('*.*','Image 2');
%filewithpath1=strcat(pathname1,filename1);
%img2=imread(filewithpath1);

MIFH2=GetMIFH2(img1,6,3,3,16,'Avg',0,1);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(MIFH1); title('MIFH Image 1');
subplot(223); imshow(img1); title('Image 2');
subplot(224); bar(MIFH2); title('MIFH Image 2');

D1=sum(abs(MIFH1-MIFH2));
disp(strcat('D = ', num2str(D1)));