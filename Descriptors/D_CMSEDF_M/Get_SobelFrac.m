function [G] = Get_SobelFrac(RGB,A,U)       

I = rgb2gray(RGB);
Sx=[((A*A)-A)/2 -A   0 A       (A-(A*A))/2;
2*(((A*A)-A)/2) -2*A 0 2*A 2*((A-(A*A))/2);
3*(((A*A)-A)/2) -3*A 0 3*A 3*((A-(A*A))/2);
2*(((A*A)-A)/2) -2*A 0 2*A 2*((A-(A*A))/2);
    ((A*A)-A)/2 -A   0 A       (A-(A*A))/2;];
Sy=[((A*A)-A)/2 2*(((A*A)-A)/2) 3*(((A*A)-A)/2) 2*(((A*A)-A)/2) ((A*A)-A)/2;
    -A               -2*A          -3*A              -2*A            -A;
     0                 0             0                 0              0;
     A                2*A           3*A               2*A             A;
    (A-(A*A))/2 2*((A-(A*A))/2) 3*((A-(A*A))/2) 2*((A-(A*A))/2) (A-(A*A))/2;];
x = conv2(I,Sx,'valid');
y = conv2(I,Sy,'valid');
Div=abs(9*A)+abs(9*((A-(A*A))/2));
y=abs(y/Div);x=abs(x/Div);
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
         
            