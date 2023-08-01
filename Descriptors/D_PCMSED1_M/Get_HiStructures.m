function HiStructor = Get_HiStructures(img,rows,columns,Dx,Dy)        

HiStructor=zeros(1,9);
%sMap = zeros(rows-2, columns-2);
it=floor((rows-2)/(3-Dx))*(3-Dx)-1;%//to delet de edge of image and delimit the convolution
jt=floor((columns-2)/(3-Dy))*(3-Dy)-1;
ct=0;
for i=2+Dx:3:it               
    for j=2+Dy:3:jt         
        
        c=0;
        WA = img(i-1:i+1,j-1:j+1);     
        for m=1:3
            for n=1:3
                if WA(5) == WA(m,n)                                                                     
                    %sMap(i+(m-2), j+(n-2)) = 1;
                    c=c+1;
                else                   
                    %sMap(i+(m-2), j+(n-2)) = 0;            
                end          
            end
        end
        HiStructor(c)=HiStructor(c)+1;
        ct=ct+1;
    end  
end
HiStructor=HiStructor/ct;
end
