function hist= Get_MSR(Map,CSA,rows,columns)
            
MS = zeros(1,CSA);           
HA = zeros(1,CSA);
hist = zeros(1,CSA);           
for i = 1:rows-2              
    for j = 1:columns-2

        Val=Map(i,j)+1;
        if Val > 0
            HA(Val)= HA(Val)+1;
        end
                      
    end   
end
          
for i=2:rows-3
    for j=2:columns-3                        
        wa = Map(i-1:i+1,j-1:j+1);
        TE1 = 0;                   
        for m=1:9                                                                
            if ((wa(5) == wa(m)) && (wa(5) >= 0))                                         
                if m ~= 5
                    TE1 = TE1 + 1;  
                end                                    
            end
        end
        Val=wa(5)+1;
        if Val > 0
            MS(Val) = MS(Val)+TE1;
        end       
    end
end

for i=1:CSA
    
    if HA(i) > 0.0
        hist(i) = (MS(i) * 1.0) / (8.0 * HA(i));
    end
    
end
end
