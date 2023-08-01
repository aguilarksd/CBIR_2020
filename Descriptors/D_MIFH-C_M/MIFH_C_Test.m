[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);


MIFH1=GetMIFH_C(img1,6,3,3,16,'Avg',0,1);

figure(1)
subplot(211); imshow(img1); title('Image 1');
subplot(212); bar(MIFH1); title('MIFH Image 1');


