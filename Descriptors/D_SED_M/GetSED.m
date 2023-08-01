function [SED] = GetSED(img)

hsv = rgb2hsv(img);
M=size(img,1);
N=size(img,2);
Q_image=GetQntRngHSV(hsv,M,N);
SHM=GetSHM(Q_image,M,N);
SED=GetE(SHM);
%SED=reshape(SHM,1,[]);

end

