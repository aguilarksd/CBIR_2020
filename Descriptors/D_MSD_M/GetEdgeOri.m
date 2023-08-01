function [E_ori] = GetEdgeOri(imghsv,M,N,qO)

E_ori=zeros(M,N);
SH=[1 2 1;0 0 0;-1 -2 -1];
SV=[-1 0 1;-2 0 2;-1 0 1];

HSV_cart=Cylin2Cart(imghsv,M,N);

for i=2:M-1
    for j=2:N-1
        blockH=HSV_cart(i-1:i+1,j-1:j+1,1);
        blockS=HSV_cart(i-1:i+1,j-1:j+1,2);
        blockV=HSV_cart(i-1:i+1,j-1:j+1,3);
        Hx=sum(sum(SH.*blockH));Sx=sum(sum(SH.*blockS));Vx=sum(sum(SH.*blockV));
        Hy=sum(sum(SV.*blockH));Sy=sum(sum(SV.*blockS));Vy=sum(sum(SV.*blockV));
        gxx=sqrt(Hx * Hx + Sx * Sx + Vx * Vx);
        gyy=sqrt(Hy * Hy + Sy * Sy + Vy * Vy);
        gxy=Hx * Hy + Sx * Sy + Vx * Vy;
        theta=acosd(gxy / ((gxx * gyy)+ 0.0001));
        E_ori(i,j)= round(theta * qO / 180.0);
        if E_ori(i,j) >= qO-1
            E_ori(i,j)=qO-1;
        end
    end
end

end
