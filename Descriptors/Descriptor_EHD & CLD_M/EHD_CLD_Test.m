[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img1=imread(filewithpath1);

%EHD1=GetMpegEHD(img1);
CLD1=GetMpegCLD(img1);

[filename2,pathname2]=uigetfile('*.*','Image 2');
filewithpath2=strcat(pathname2,filename2);
img2=imread(filewithpath2);

%EHD2=GetMpegEHD(img2);
CLD2=GetMpegCLD(img2);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(CLD1); title('Histogram Image 1');
subplot(223); imshow(img2); title('Image 2');
subplot(224); bar(CLD2); title('Histogram Image 2');

%D2=sqrt(sum((EHD1-EHD2).^2));
%disp(strcat('L2 = ', num2str(D2)));
%D1=sum(abs(EHD1-EHD2));
%disp(strcat('L1 = ', num2str(D1)));

D2=sqrt(sum((CLD1-CLD2).^2));
disp(strcat('L2 = ', num2str(D2)));
D1=sum(abs(CLD1-CLD2));
disp(strcat('L1 = ', num2str(D1)));

