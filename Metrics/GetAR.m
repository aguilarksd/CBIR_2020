function [AR] = GetAR(DRQ,Q,Rq)

R=zeros(1,Q);
for q=1:Q
    R(q)=sum(DRQ(q,:))/Rq;
end
AR=sum(R)/Q;

end

