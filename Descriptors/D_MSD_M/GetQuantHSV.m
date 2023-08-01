function [Q_image] = GetQuantHSV(imghsv,M,N,qH,qS,qV)

Q_image=zeros(M,N);

for i=1:M
    for j=1:N
        H=floor(imghsv(i,j,1)*qH);
        if H >= (qH-1)
            H=qH-1;
        end
        S=floor(imghsv(i,j,2)*qS);
        if S >= (qS-1)
            S=qS-1;
        end
        V=floor(imghsv(i,j,3)*qV);
        if V >= (qV-1)
            V=qV-1;
        end
        Q_image(i,j)=(qS*qV*H)+(qV*S)+V;
    end
end
end

