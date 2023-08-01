function [bins] = GetBinsHSV(imgb,M,N)

M = 2*floor(M/2);N = 2*floor(N/2);
imgb=imresize(imgb,[M N]);
bins=zeros(1,5);

V=[1 -1;1 -1];H=[1 1;-1 -1];D45=[1.414 0;0 -1.414];D135=[0 1.414;-1.414 0];ISOT=[2 -2;-2 2];

nobr=M/2;nobc=N/2;
L=0;
for i=1:nobc
    K=0;
    for j=1:nobr
        block=imgb(K+1:K+2,L+1:L+2,1);
        pv=abs(sum(sum(block.*V)));
        ph=abs(sum(sum(block.*H)));
        pd45=abs(sum(sum(block.*D45)));
        pd135=abs(sum(sum(block.*D135)));
        pisot=abs(sum(sum(block.*ISOT)));
        [value1,index1]=max([pv, ph, pd45, pd135, pisot]);
        
        block2=imgb(K+1:K+2,L+1:L+2,2);
        pv2=abs(sum(sum(block2.*V)));
        ph2=abs(sum(sum(block2.*H)));
        pd452=abs(sum(sum(block2.*D45)));
        pd1352=abs(sum(sum(block2.*D135)));
        pisot2=abs(sum(sum(block2.*ISOT)));
        [value2,index2]=max([pv2, ph2, pd452, pd1352, pisot2]);
        
        block3=imgb(K+1:K+2,L+1:L+2,3);
        pv3=abs(sum(sum(block3.*V)));
        ph3=abs(sum(sum(block3.*H)));
        pd453=abs(sum(sum(block3.*D45)));
        pd1353=abs(sum(sum(block3.*D135)));
        pisot3=abs(sum(sum(block3.*ISOT)));
        [value3,index3]=max([pv3, ph3, pd453, pd1353, pisot3]);
        
        if index1 == index2 || index2 == index3 
            index=index2;
        elseif index1 == index3 
            index=index1;
        else
            if value1>value2 && value1>value3
                index=index1;
            elseif value2>value3
                index=index2;
            else
                index=index3;
            end
        end
        bins(index)=bins(index)+1;
        K=K+2;
    end
    L=L+2;
end
end

