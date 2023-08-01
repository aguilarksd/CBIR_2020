function [sMap] = Get_StructureMap(S1,S2,img,rows,columns,Dx,Dy)        

sMap =   zeros(rows, columns);
it=floor((rows)/(3-Dx))*(3-Dx)-1;%//to delet de edge of image and delimit the convolution
jt=floor((columns)/(3-Dy))*(3-Dy)-1;
for i=2+Dx:3:it               
    for j=2+Dy:3:jt         
                    
        WA = S1(i-1:i+1,j-1:j+1);  
        WV = S2(i-1:i+1,j-1:j+1);       
        for m=1:3
            for n=1:3
                if (WA(5) == WA(m,n) || WV(5) == WV(m,n)) 
                %if (WA(5) == WA(m,n) && WV(5) == WV(m,n))  
                    sMap(i+(m-2), j+(n-2)) = img(i+(m-2), j+(n-2));                                                          
                else                   
                    sMap(i+(m-2), j+(n-2)) = -1;            
                end          
            end
        end
    end  
end
end