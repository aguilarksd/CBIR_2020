function SEH = Get_CompleteSEH(img,rows,columns,te,ne)        

HiStructor=zeros(1,ne);
ct=0;
for i=2:rows-1               
    for j=2:columns-1            
    
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
SEH=HiStructor/ct;
end
