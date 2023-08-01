function [R] = GetMetrics(DR,Q,K,Rq,mx)

R=zeros(4,1);
AP=GetAP(DR,Q,K);
AR=GetAR(DR,Q,Rq);
MAP=GetMAP(DR,Q,Rq,K);
ANMRR=GetANMRR(DR,Q,Rq,K,mx);
R(1)=AP;R(2)=AR;R(3)=MAP;R(4)=ANMRR;

end

