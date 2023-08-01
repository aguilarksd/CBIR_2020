function [Dir] = Get_Directory(Ti,Tc,i,j)

if isa(Ti.Name,'cell')           
    nimg='';           
    jc=num2str(j);           
    for n=1:Ti.Digits-length(jc)               
        nimg=strcat(nimg,'0');          
    end    
    nimg=strcat(Ti.Name{1},nimg,jc);           
    if Ti.Subdiv == 1               
        Dir=strcat(Tc.Name{i},'\',nimg,Ti.Type{1});            
    else       
        Dir=strcat(nimg,Ti.Type{1});           
    end            
else
    nimg=Tc.Name(1);
    for n=1:Ti.Digits
        nimg=nimg*10;
    end 
    if Ti.Subdiv == 1               
        Dir=strcat(string(Tc.Name(i)),'\',nimg,Ti.Type{1});            
    else       
        Dir=strcat(string(nimg),Ti.Type{1});           
    end         
end

end

