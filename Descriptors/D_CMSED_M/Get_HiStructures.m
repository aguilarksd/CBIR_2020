function HiStructor = Get_HiStructures(img,rows,columns,Dx,Dy,te,ne)       

HiStructor=zeros(1,ne);

it=floor((rows-2)/(3-Dx))*(3-Dx)-1;%//to delet de edge of image and delimit the convolution
jt=floor((columns-2)/(3-Dy))*(3-Dy)-1;
ct=0;
for i=2+Dx:3:it               
    for j=2+Dy:3:jt             
    
        WA = img(i-1:i+1,j-1:j+1);
        [ce,cu,dm,lm,cm] = Get_SCof(WA,0);
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
        ct=ct+1;
    end  
end
HiStructor=HiStructor/ct;
end
