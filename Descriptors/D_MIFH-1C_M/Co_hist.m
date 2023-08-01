function [Hk] = Co_hist(Mk,bV,dx,dy)

M=size(Mk,1);
N=size(Mk,2);
Hk=zeros(1,bV);
for i=2:M-1
    for j=2:N-1
        v=int8(Mk(i,j));v2=int8(Mk(i+dx,j+dy));
        if v == v2
            Hk(v+1)=Hk(v+1)+1;
        end
    end
end

end

