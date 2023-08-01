function [Sobel] = Sobel_XY(img)

M=size(img,1);
N=size(img,2);
Sobel=zeros(M,N);
SH=[1 2 1;0 0 0;-1 -2 -1];
SV=[-1 0 1;-2 0 2;-1 0 1];
for i=2:M-1
    for j=2:N-1
        block=img(i-1:i+1,j-1:j+1);
        Edge=sum(sum(SH.*block))+sum(sum(SV.*block));
        Sobel(i,j)=Edge/2;
        %Sobel(i,j)=Edge;
    end
end

end

