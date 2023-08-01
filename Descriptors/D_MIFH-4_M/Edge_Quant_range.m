function [Eq] = Edge_Quant_range(Edge,Nv)

M=size(Edge,1);
N=size(Edge,2);
Eq=zeros(M-2,N-2);
Maxval=max(max(Edge));
for i=2:M-1
    for j=2:N-1
        v=(Edge(i,j)/Maxval);
        rang=0.05;
        for k=1:Nv      
            if v <= rang           
                v=k-1;       
            end
            if k<10
                rang=rang+0.05;
            elseif k>=10 && k<14
                rang=rang+0.075;
            else
                rang=rang+0.1;
            end        
        end
        Eq(i-1,j-1)=v;
    end
end

end

