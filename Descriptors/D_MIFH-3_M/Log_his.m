function [H] = Log_his(h)

N=size(h,2);
H=zeros(1,N);
for i=1:N
    v=h(i);
    if v > 0
        H(i)=log(v);
        if H(i) <= 0.0
            H(i)=0.0;
        end
    end
end

end

