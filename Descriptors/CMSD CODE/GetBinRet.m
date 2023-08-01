function [Val] = GetBinRet(Nr,index,ci,cf,s)

Val=zeros(1,Nr);
for i=1:Nr    
        num=index(i+s);        
        if  num>=ci && num<=cf
            Val(i)=1;
        else
            Val(i)=0;
        end
end
    
end

