function [ce,cu,dm,lm,cm] = Get_SCof(WA,WV)
%Get the coeficients to recognice the esructure element
if WV == 0
    WV=WA;
end
ce=0;cu=0;dm=0;lm=0;cm=0;
ta=0;vt=zeros(1,4);
m=1;n=1;c=0;
           
for p=1:8        
    
    %if WA(5) == WA(m,n) || WV(5) == WV(m,n) 
    if WA(5) == WA(m,n) && WV(5) == WV(m,n) 
        ce=ce+1;                
        tp=ta;                
        ta=1;       
    else               
        tp=ta;          
        ta=0;          
    end
            
    if p > 1 && tp ~= ta     
        
        if cu == 0                    
            ti=tp;      
            ci=c;        
        end

        cu=cu+1;

        if dm < c && tp == 0
            dm=c;
            c=1;                
        elseif lm < c && tp == 1
            lm=c;
            c=1;                
        end
            
    else               
        c=c+1;     
    end
            
    if p == 8
        if c < 8        
        
            if ti == ta           
                c=c+ci;                 
            else            
                cu=cu+1;                
            end

        end
                
        if dm < c && ta == 0
            dm=c;        
        elseif lm < c && ta == 1
            lm=c;         
        end
            
    end
            
    if p <= 4
        vt(p)=ta;           
    elseif vt(p-4) == ta
        cm=cm+1;      
    end
            
    %Get in circule 
    [n,m]=Get_circule(n,p,m);
        
end

end