function [cldhsv] = GetHsvCLD(img)
[r,c]=size(img(:,:,1));
r=ceil(r/8);c=ceil(c/8);
r8=r*8;c8=c*8;
img=imresize(img,[r8 c8]);

img=rgb2hsv(img);

avgO = @(block_struct) mean(mean(block_struct.data));
imgavg = blockproc(img,[r c],avgO);

Ydct= dct2(imgavg(:,:,1));
Cbdct= dct2(imgavg(:,:,2));
Crdct= dct2(imgavg(:,:,3));
cldhsv=zeros(1,192);

t=0;
for d=2:64
    c=rem(d,2);  
    for i=1:8
        for j=1:8
            if((i+j)==d)
                t=t+1;
                if(c==0)
                cldhsv(t)=Ydct(j,d-j);
                cldhsv(64+t)=Cbdct(j,d-j);
                cldhsv(128+t)=Crdct(j,d-j);
                else          
                cldhsv(t)=Ydct(d-j,j);
                cldhsv(64+t)=Cbdct(d-j,j);
                cldhsv(128+t)=Crdct(d-j,j);
                end
             end    
         end
    end
end
end

