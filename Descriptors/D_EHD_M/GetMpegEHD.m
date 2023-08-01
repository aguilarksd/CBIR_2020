function [ehd] = GetMpegEHD(img)

[r,c,m]=size(img);
if m==3
    img=rgb2gray(img);
end

M=4*ceil(r/4);N=4*ceil(c/4);
img=imresize(img,[M,N]);
ALLBins=zeros(17,5);
x=sqrt((M*N)/1100);
block_size=2*floor(x/2);
p=1;L=0;

for i=1:4
    K=0;
    for j=1:4
        block=img(K+1:K+(M/4),L+1:L+(N/4));
        image_block=GetImageblocks(block,block_size);
        ALLBins(p,:)=GetBins(double(image_block),11);
        K=K+(M/4); p=p+1;
    end
    L=L+(N/4);
end
GlobalBin=mean(ALLBins);
ALLBins(17,:)=round(GlobalBin);
ehd=reshape(ALLBins,[1,85]);
end

