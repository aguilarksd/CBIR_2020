function [G] = Get_Sobel(RGB,U)       

I = rgb2gray(RGB);
Sx=[-1 0 1;
    -2 0 2;
    -1 0 1];
Sy=[1 2 1;
    0 0 0;
   -1 -2 -1];
x = conv2(I,Sx,'valid');
y = conv2(I,Sy,'valid');
y=abs(y/4);x=abs(x/4);
g=zeros(length(x(:,1)),length(x(1,:))); 
% // Sobel horizontal and vertical directions
for i = 1:length(x(:,1))              
    for j = 1:length(x(1,:)) 
        g(i,j)=sqrt((x(i,j) * x(i,j))+(y(i,j) * y(i,j)));
        if x(i,j) > U && U > 0
            x(i,j)=255;
        elseif U > 0  
            x(i,j)=0;
        end
        if y(i,j) > U && U > 0
            y(i,j)=255;
        elseif U > 0  
            y(i,j)=0;
        end
        if g(i,j) > U && U > 0
            g(i,j)=255;
        elseif U > 0 
            g(i,j)=0;
        end
    end    
end
G=mat2gray(g);

end
         
            
    