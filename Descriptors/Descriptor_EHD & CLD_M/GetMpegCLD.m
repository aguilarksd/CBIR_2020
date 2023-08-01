function [cld] = GetMpegCLD(img)
[r,c]=size(img(:,:,1));
r=ceil(r/8);c=ceil(c/8);
r8=r*8;c8=c*8;
img=imresize(img,[r8 c8]);

avgO = @(block_struct) mean(mean(block_struct.data));
imgavg = uint8(blockproc(img,[r c],avgO));
YCbCr=double(rgb2ycbcr(imgavg));

Ydct= dct2(YCbCr(:,:,1));
Cbdct= dct2(YCbCr(:,:,2));
Crdct= dct2(YCbCr(:,:,3));
cld=zeros(1,192);

t=0;
for d=2:64
    c=rem(d,2);  
    for i=1:8
        for j=1:8
            if((i+j)==d)
                t=t+1;
                if(c==0)
                cld(t)=Ydct(j,d-j);
                cld(64+t)=Cbdct(j,d-j);
                cld(128+t)=Crdct(j,d-j);
                else          
                cld(t)=Ydct(d-j,j);
                cld(64+t)=Cbdct(d-j,j);
                cld(128+t)=Crdct(d-j,j);
                end
             end    
         end
    end
end
end

