function [ehd] = GetHsvEHD(img)

hsv = rgb2hsv(img);
M=size(img,1);
N=size(img,2);
img=Cylin2Cart(hsv,M,N);
ALLBins=zeros(17,5);
x=sqrt((M*N)/1100);
block_size=2*floor(x/2);
p=1;L=0;

for i=1:4
    K=0;
    for j=1:4
        block=img(K+1:K+(M/4),L+1:L+(N/4),:);
        image_block=GetHSVblocks(block,block_size,M,N);
        ALLBins(p,:)=GetBinsHSV(image_block,M,N);
        K=K+(M/4); p=p+1;
    end
    L=L+(N/4);
end
GlobalBin=mean(ALLBins);
ALLBins(17,:)=round(GlobalBin);
ehd=reshape(ALLBins',[1,85]);
end
