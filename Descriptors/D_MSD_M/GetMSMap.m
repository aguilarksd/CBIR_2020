function [Msm] = GetMSMap(EdgeOri,QuantHSV,M,N,x,y)

Msm=ones(M,N);
Msm=Msm*-1;

for K=2+x:3:M-1
    for L=2+y:3:N-1
        Cb=EdgeOri(K,L);
        c=0;
        if Cb==EdgeOri(K-1,L-1)
           Msm(K-1,L-1)=QuantHSV(K-1,L-1);
           c=c+1;
        else
           Msm(K-1,L-1)=-1;
        end
        if Cb==EdgeOri(K-1,L)
           Msm(K-1,L)=QuantHSV(K-1,L);
           c=c+1;
        else
           Msm(K-1,L)=-1;
        end 
        if Cb==EdgeOri(K-1,L+1)
           Msm(K-1,L+1)=QuantHSV(K-1,L+1);
           c=c+1;
        else
           Msm(K-1,L+1)=-1;
        end 
        if Cb==EdgeOri(K,L-1)
           Msm(K,L-1)=QuantHSV(K,L-1);
           c=c+1;
        else
           Msm(K,L-1)=-1;
        end
        if Cb==EdgeOri(K,L+1)
           Msm(K,L+1)=QuantHSV(K,L+1);
           c=c+1;
        else
           Msm(K,L+1)=-1;
        end
        if Cb==EdgeOri(K+1,L-1)
           Msm(K+1,L-1)=QuantHSV(K+1,L-1);
           c=c+1;
        else
           Msm(K+1,L-1)=-1;
        end
        if Cb==EdgeOri(K+1,L)
           Msm(K+1,L)=QuantHSV(K+1,L);
           c=c+1;
        else
           Msm(K+1,L)=-1;
        end 
        if Cb==EdgeOri(K+1,L+1)
           Msm(K+1,L+1)=QuantHSV(K+1,L+1);
           c=c+1;
        else
           Msm(K+1,L+1)=-1;
        end        
        if c > 0
            Msm(K,L)=QuantHSV(K,L);
        end
    end
end

end

