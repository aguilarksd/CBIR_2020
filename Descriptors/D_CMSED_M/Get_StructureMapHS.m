function [sMap,HiStructor] = Get_StructureMapHS(S1,S2,img,rows,columns,Dx,Dy,te,ne)        

HiStructor=zeros(1,ne);
sMap =   zeros(rows-2, columns-2);
it=floor((rows-2)/(3-Dx))*(3-Dx)-1;%//to delet de edge of image and delimit the convolution
jt=floor((columns-2)/(3-Dy))*(3-Dy)-1;
for i=2+Dx:3:it               
    for j=2+Dy:3:jt         
                    
        WA = S1(i-1:i+1,j-1:j+1);  
        WV = S2(i-1:i+1,j-1:j+1);       
        for m=1:3
            for n=1:3
                %if (WA(5) == WA(m,n) || WV(5) == WV(m,n)) 
                if (WA(5) == WA(m,n) && WV(5) == WV(m,n))
                    sMap(i+(m-2), j+(n-2)) = img(i+(m-2), j+(n-2));                                                          
                else                   
                    sMap(i+(m-2), j+(n-2)) = -1;            
                end          
            end
        end
        [ce,cu,dm,lm,cm] = Get_SCof(WA,WV);
        if te == 1 && ne == 7 && ce < 8 && ce > 0                
            HiStructor(ce)=HiStructor(ce)+1;         
        elseif te == 1 && ne == 9               
            HiStructor(ce+1)=HiStructor(ce+1)+1;            
        elseif te == 2           
            T=Get_StypeC(ce,cu,dm,lm,cm,ne);           
            if T > 0     
                HiStructor(T)=HiStructor(T)+1;       
            end
        end
    end  
end
end