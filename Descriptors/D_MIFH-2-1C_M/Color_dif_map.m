function [C] = Color_dif_map(HSV_cart,M,N)

C=zeros(M,N);
for i=2:M-1
    for j=2:N-1
        CH=HSV_cart(i,j,1);
        CS=HSV_cart(i,j,2);
        CV=HSV_cart(i,j,3);
        X=0.0;
        for x=1:3
            for y=1:3
                nph=HSV_cart(i-2+x,j-2+y,1);
                DH=((nph-CH)*(nph-CH));
                nps=HSV_cart(i-2+x,j-2+y,2);
                DS=((nps-CS)*(nps-CS));
                npv=HSV_cart(i-2+x,j-2+y,3);
                DV=((npv-CV)*(npv-CV));
                X=X+sqrt(DH+DS+DV);
            end
        end
        C(i,j)=GetSigmoid(X,1);
    end
end
end

