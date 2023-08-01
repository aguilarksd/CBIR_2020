function [bins] = GetBins(imgb,T)

[M,N]=size(imgb);
M = 2*floor(M/2);N = 2*floor(N/2);
imgb=imresize(imgb,[M,N]);
bins=zeros(1,5);

V=[1 -1;1 -1];H=[1 1;-1 -1];D45=[1.414 0;0 -1.414];D135=[0 1.414;-1.414 0];ISOT=[2 -2;-2 2];

nobr=M/2;nobc=N/2;
L=0;
for i=1:nobc
    K=0;
    for j=1:nobr
        block=imgb(K+1:K+2,L+1:L+2);
        pv=abs(sum(sum(block.*V)));
        ph=abs(sum(sum(block.*H)));
        pd45=abs(sum(sum(block.*D45)));
        pd135=abs(sum(sum(block.*D135)));
        pisot=abs(sum(sum(block.*ISOT)));
        [value,index]=max([pv, ph, pd45, pd135, pisot]);
        if value>=T
            bins(index)=bins(index)+1;
        end
        K=K+2;
    end
    L=L+2;
end
end

