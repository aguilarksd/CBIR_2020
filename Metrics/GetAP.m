function [AP] = GetAP(DRQ,Q,K)

P=zeros(1,Q);
for q=1:Q
    P(q)=sum(DRQ(q,:))/K;
end
AP=sum(P)/Q;

end

