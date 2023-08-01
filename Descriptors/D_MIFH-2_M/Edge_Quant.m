function [Eq] = Edge_Quant(Edge,bV)

M=size(Edge,1);
N=size(Edge,2);
Eq=zeros(M,N);
Maxval=max(max(Edge));
for i=1:M
    for j=1:N
        v=floor((Edge(i,j)/Maxval)*bV);
        if v >= (bV-1)
            v=bV-1;
        end
        Eq(i,j)=v;
    end
end

end

