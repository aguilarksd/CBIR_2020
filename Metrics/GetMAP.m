function [MAP] = GetMAP(DRQ,Q,Rq,K)

AP=zeros(1,Q);
for q=1:Q
    sumAP=0;
    for k=1:K
        if DRQ(q,k)>0
            sumAP=sumAP+(sum(DRQ(q,1:k))/k);
        end
    end
    AP(q)=sumAP/Rq;
end
MAP=sum(AP)/Q;

end

