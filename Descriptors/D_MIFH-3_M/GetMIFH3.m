function [MIFH] = GetMIFH3(img,bh,bs,bv,Nv,subS,dx,dy)

hsv = rgb2hsv(img);
M=size(img,1);
N=size(img,2);
Nc=bh*bs*bv;
%// Color Feature Extraction and the Initial Feature Integration
Q_image=GetQuantHSV(hsv,M,N,bh,bs,bv);
HSV_cart=Cylin2Cart(hsv,M,N);
C=Color_dif_map(HSV_cart,M,N);
S=Subsampling(C,subS);

%// First Integration of the Edge Features
G0=Sobel_XY(S);%4
G1=Sobel_XY(S+G0);%20
G2=Sobel_XY(S+G0+G1);%100
G3=Sobel_XY(S+G0+G1+G2);%500
Sum=G0.^2+G1.^2+G2.^2+G3.^2;%260416
E1=sqrt(Sum);%510.3097099
Gs0=Subsampling(G0,subS);Gs1=Subsampling(G1,subS);Gs2=Subsampling(G2,subS);Gs3=Subsampling(G3,subS);

%// Second Integration of the Edge Features
G00=Sobel_XY(Gs0);G01=Sobel_XY(Gs0+G00);G02=Sobel_XY(Gs0+G00+G01);G03=Sobel_XY(Gs0+G00+G01+G02);%16 80 400 2000
G10=Sobel_XY(Gs1);G11=Sobel_XY(Gs1+G10);G12=Sobel_XY(Gs1+G10+G11);G13=Sobel_XY(Gs1+G10+G11+G12);%80
G20=Sobel_XY(Gs2);G21=Sobel_XY(Gs2+G20);G22=Sobel_XY(Gs2+G20+G21);G23=Sobel_XY(Gs2+G20+G21+G22);
G30=Sobel_XY(Gs3);G31=Sobel_XY(Gs3+G30);G32=Sobel_XY(Gs3+G30+G31);G33=Sobel_XY(Gs3+G30+G31+G32);
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


M0=Q_image;
M1=Edge_Quant_range(E1,Nv);
M2=Edge_Quant_range(E2,Nv);
M3=Edge_Quant_range(E3,Nv);

%// Feature Representation
H0=Co_hist(M0,Nc,dx,dy);H1=Co_hist(M1,Nv,dx,dy);H2=Co_hist(M2,Nv,dx,dy);H3=Co_hist(M3,Nv,dx,dy);

h=[H0,H1,H2,H3];
MIFH=Log_his(h);

end

