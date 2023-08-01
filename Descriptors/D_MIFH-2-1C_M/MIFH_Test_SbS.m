[filename1,pathname1]=uigetfile('*.*','Image 1');
filewithpath1=strcat(pathname1,filename1);
img=imread(filewithpath1);

subS='Avg';bh=6;bs=3;bv=3;Nv=16;dx=0;dy=1;

figure(1)
imshow(img);title('RGB');
M=size(img,1);
N=size(img,2);
Nc=bh*bs*bv;


hsv = rgb2hsv(img);
%// Color Feature Extraction and the Initial Feature Integration
Q_image=GetQuantHSV(hsv,M,N,bh,bs,bv);
figure(2)
imshow(hsv);title('HSV');

HSV_cart=Cylin2Cart(hsv,M,N);
figure(3)
imshow(HSV_cart);title('HSV_Cart');

C=Color_dif_map(HSV_cart,M,N);
figure(4)
imshow(C);title('Diferencia de Color');

S=Subsampling(C,subS);
figure(5)
imshow(S);title('Avg_Pooling');

G0=Sobel_XY(S);%4
G1=Sobel_XY(S+G0);%20
G2=Sobel_XY(S+G0+G1);%100
G3=Sobel_XY(S+G0+G1+G2);%500
figure(6)
subplot(221); imshow(G0);title('Sobel G_0');
subplot(222); imshow(G1);title('Sobel G_1');
subplot(223); imshow(G2);title('Sobel G_2');
subplot(224); imshow(G3);title('Sobel G_3');

G0=edge(S,'sobel');%4
G1=edge(S+G0,'sobel');%20
G2=edge(S+G0+G1,'sobel');%100
G3=edge(S+G0+G1+G2,'sobel');%500
figure(7)
subplot(221); imshow(G0);title('Sobelf G_0');
subplot(222); imshow(G1);title('Sobelf G_1');
subplot(223); imshow(G2);title('Sobelf G_2');
subplot(224); imshow(G3);title('Sobelf G_3');
%{
figure(7)
surf(S);title('S');
figure(8)
surf(G0);title('G0');
figure(9)
surf(G1);title('G1');
figure(10)
surf(G2);title('G2');
figure(11)
surf(G3);title('G3');

Sum=G0.^2+G1.^2+G2.^2+G3.^2;%260416
E1=sqrt(Sum);%510.3097099
Gs0=Subsampling(G0,subS);Gs1=Subsampling(G1,subS);Gs2=Subsampling(G2,subS);Gs3=Subsampling(G3,subS);

figure(12)
surf(E1);title('E1');

G00=Sobel_XY(Gs0);G01=Sobel_XY(Gs0+G00);G02=Sobel_XY(Gs0+G00+G01);G03=Sobel_XY(Gs0+G00+G01+G02);%16 80 400 2000
figure(13)
subplot(221); imshow(G00);title('Sobel_G0-0');
subplot(222); imshow(G01);title('Sobel_G0-1');
subplot(223); imshow(G02);title('Sobel_G0-2');
subplot(224); imshow(G03);title('Sobel_G0-3');

G10=Sobel_XY(Gs1);G11=Sobel_XY(Gs1+G10);G12=Sobel_XY(Gs1+G10+G11);G13=Sobel_XY(Gs1+G10+G11+G12);
figure(14)
subplot(221); imshow(G10);title('Sobel_G1-0');
subplot(222); imshow(G11);title('Sobel_G1-1');
subplot(223); imshow(G12);title('Sobel_G1-2');
subplot(224); imshow(G13);title('Sobel_G1-3');

G20=Sobel_XY(Gs2);G21=Sobel_XY(Gs2+G20);G22=Sobel_XY(Gs2+G20+G21);G23=Sobel_XY(Gs2+G20+G21+G22);
figure(15)
subplot(221); imshow(G20);title('Sobel_G2-0');
subplot(222); imshow(G21);title('Sobel_G2-1');
subplot(223); imshow(G22);title('Sobel_G2-2');
subplot(224); imshow(G23);title('Sobel_G2-3');

G30=Sobel_XY(Gs3);G31=Sobel_XY(Gs3+G30);G32=Sobel_XY(Gs3+G30+G31);G33=Sobel_XY(Gs3+G30+G31+G32);
figure(16)
subplot(221); imshow(G30);title('Sobel_G3-0');
subplot(222); imshow(G31);title('Sobel_G3-1');
subplot(223); imshow(G32);title('Sobel_G3-2');
subplot(224); imshow(G33);title('Sobel_G3-3');

Sum=G00.^2+G01.^2+G02.^2+G03.^2;
F0=sqrt(Sum);
Sum=G10.^2+G11.^2+G12.^2+G13.^2;
F1=sqrt(Sum);
Sum=G20.^2+G21.^2+G22.^2+G23.^2;
F2=sqrt(Sum);
Sum=G30.^2+G31.^2+G32.^2+G33.^2;
F3=sqrt(Sum);
E2=F0+F1+F2+F3;
Fs0=Subsampling(F0,subS);Fs1=Subsampling(F1,subS);Fs2=Subsampling(F2,subS);Fs3=Subsampling(F3,subS);
%// Third Integration of the Edge Features
E3=Fs0+Fs1+Fs2+Fs3;

figure(17)
subplot(221); imshow(Q_image);title('M0');
subplot(222); imshow(E1);title('E1');
subplot(223); imshow(E2);title('E2');
subplot(224); imshow(E3);title('E3');

M0=Q_image;
M1=Edge_Quant(E1,Nv);
M2=Edge_Quant(E2,Nv);
M3=Edge_Quant(E3,Nv);

M0i=M0*255/8;
M1i=M1*255/16;
M2i=M2*255/16;
M3i=M3*255/16;
figure(18)
subplot(221); imshow(M0i);title('M0');
subplot(222); imshow(M1i);title('M1');
subplot(223); imshow(M2i);title('M2');
subplot(224); imshow(M3i);title('M3');

%// Feature Representation
H0=Co_hist(M0,Nc,dx,dy);H1=Co_hist(M1,Nv,dx,dy);H2=Co_hist(M2,Nv,dx,dy);H3=Co_hist(M3,Nv,dx,dy);

h=[H0,H1,H2,H3];
MIFH=Log_his(h);
%}


