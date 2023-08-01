function [MIFH] = GetMIFH21(img,bh,bs,bv,Nv,subS,dx,dy)

hsv = rgb2hsv(img);
M=size(img,1);
N=size(img,2);
Nc=bh*bs*bv;
%// new valus of quant
Nv2=floor(Nv/2);
Nv1=floor(Nv2/4);
%// Color Feature Extraction and the Initial Feature Integration
M0=GetQuantHSV(hsv,M,N,bh,bs,bv);
HSV_cart=Cylin2Cart(hsv,M,N);
C=Color_dif_map(HSV_cart,M,N);
S=Subsampling(C,subS);

%// First Integration of the Edge Features
G0=Sobel_XY(S);%4
G1=Sobel_XY(S+G0);%20
G2=Sobel_XY(S+G0+G1);%100
G3=Sobel_XY(S+G0+G1+G2);%500
G0q=Edge_Quant(sqrt(G0.^2),Nv1);
G1q=Edge_Quant(sqrt(G1.^2),Nv1);
G2q=Edge_Quant(sqrt(G2.^2),Nv1);
G3q=Edge_Quant(sqrt(G3.^2),Nv1);
M1=G0q*8+G1q*4+G2q*2+G3q;
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
%E2=F0+F1+F2+F3;
Fs0=Subsampling(F0,subS);Fs1=Subsampling(F1,subS);Fs2=Subsampling(F2,subS);Fs3=Subsampling(F3,subS);
Fs0q=Edge_Quant(Fs0,Nv2);Fs1q=Edge_Quant(Fs1,Nv2);Fs2q=Edge_Quant(Fs2,Nv2);Fs3q=Edge_Quant(Fs3,Nv2);
%// Third Integration of the Edge Features
%M2=Fs0q*8+Fs1q*4+Fs2q*2+Fs3q;


%// Feature Representation
H0=Co_hist(M0,Nc,dx,dy);H1=Co_hist(M1,Nv,dx,dy);
H2=Co_hist(Fs0q,Nv2,dx,dy);H3=Co_hist(Fs1q,Nv2,dx,dy);
H4=Co_hist(Fs2q,Nv2,dx,dy);H5=Co_hist(Fs3q,Nv2,dx,dy);

h=[H0,H1,H2(1:Nv2-2),H3(1:Nv2-2),H4(1:Nv2-2),H5(1:Nv2-2)];
MIFH=Log_his(h);

end

