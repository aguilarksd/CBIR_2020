function [Q_image] = GetQuantHSV(imghsv,M,N,bH,bS,bV)

Q_image=zeros(M,N);

for i=1:M
    for j=1:N
        H=floor(imghsv(i,j,1)*bH);
        if H >= (bH-1)
            H=bH-1;
        end
        S=floor(imghsv(i,j,2)*bS);
        if S >= (bS-1)
            S=bS-1;
        end
        V=floor(imghsv(i,j,3)*bV);
        if V >= (bV-1)
            V=bV-1;
        end
        Q_image(i,j)=(bS*bV*H)+(bV*S)+V;
    end
end
end

