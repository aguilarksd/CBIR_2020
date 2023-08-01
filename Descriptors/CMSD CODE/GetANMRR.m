function [ANMRR] = GetANMRR(DRQ,Q,Rq,K,mx)

NMRR=zeros(1,Q);
Kq=min(4*Rq,2*mx);
for q=1:Q
    c=0;k=1;AVR=0.0;
    while c < Rq
        if k <= Kq
            if k <= K
                if DRQ(q,k)>0
                    AVR=AVR+(k/Rq);                
                    c=c+1; 
                end              
            else
                AVR=AVR+(k/Rq);
                c=c+1; 
            end
        else
            AVR=AVR+((1.25*Kq)/Rq);
            c=c+1;
        end
        k=k+1;
    end
    MRR=AVR-(0.5*(1+Rq));
    NMRR(q)=MRR/((1.25*Kq)-(0.5*(1+Rq)));
end
ANMRR=sum(NMRR)/Q;

end
