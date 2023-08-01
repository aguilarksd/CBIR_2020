function [S] = Subsampling(C,tipe)

M=size(C,1);
N=size(C,2);
r=ceil(M/2);c=ceil(N/2);
S=zeros(r,c);
x=1;y=1;
for i=1:2:M-1
    for j=1:2:N-1
        PX=[C(i,j) C(i,j+1) C(i+1,j) C(i+1,j+1)];
        if strcmp(tipe,'Avg')
            S(x,y)=sum(PX)/4;
        end 
        if strcmp(tipe,'Max')
            S(x,y)=max(PX);
        end
        if strcmp(tipe,'Min')
            S(x,y)=min(PX);
        end
        y=y+1;
    end
    y=1;
    x=x+1;
end

end

