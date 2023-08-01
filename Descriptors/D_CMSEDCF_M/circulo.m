
X=[0 0 0 4 5;
   0 1 0 6 6;
   0 0 0 1 1];
WA=X(1:3,1:3);
ne=30;te=2;
HiStructor=zeros(1,ne);
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