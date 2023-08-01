function [E] = GetE(SHM)

S_SHM=sum(SHM);
E=zeros(5,72);

for i=1:72
    for k=1:5        
        E(k,i)=SHM(k,i)/(S_SHM(i)+1);
    end
end
E=reshape(E,1,[]);
end

