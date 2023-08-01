[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);

SED1=GetSED(img1);

[filename2,pathname2]=uigetfile('*.*','Image 2');
filewithpath2=strcat(pathname2,filename2);
img2=imread(filewithpath2);

SED2=GetSED(img2);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(SED1); title('SED Image 1');
subplot(223); imshow(img2); title('Image 2');
subplot(224); bar(SED2); title('SED Image 2');

D1=sum(abs(SED1-SED2)/(1+(SED1+SED2)));
disp(strcat('D = ', num2str(D1)));