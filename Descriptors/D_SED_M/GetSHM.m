function [SHM] = GetSHM(QuantHSV,M,N)

SHM=zeros(5,72);

for K=1:2:M-1
    for L=1:2:N-1
        P1=QuantHSV(K,L);P2=QuantHSV(K+1,L);P3=QuantHSV(K,L+1);P4=QuantHSV(K+1,L+1);
        c=0;
        if P1==P2
            X=P1+1;
            SHM(1,X)=SHM(1,X)+1;           
            c=c+1;
        end 
        if P1==P3
            X=P1+1;
            SHM(2,X)=SHM(2,X)+1;           
            c=c+1;
        end
        if P1==P4
            X=P1+1;
            SHM(3,X)=SHM(3,X)+1;           
            c=c+1;
        end 
        if P2==P3
            X=P1+1;
            SHM(4,X)=SHM(4,X)+1;           
            c=c+1;
        end
        if c == 4
            X=P1+1;
            SHM(5,X)=SHM(5,X)+1;
        end
    end
end

end

