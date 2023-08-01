function [MSD] = GetMSD(img)

hsv = rgb2hsv(img);
M=size(img,1);
N=size(img,2);
Q_image=GetQuantHSV(hsv,M,N,8,3,3);
edge_ori=GetEdgeOri(hsv,M,N,6);
M1=GetMSMap(edge_ori,Q_image,M,N,0,0);
M2=GetMSMap(edge_ori,Q_image,M,N,0,1);
M3=GetMSMap(edge_ori,Q_image,M,N,1,0);
M4=GetMSMap(edge_ori,Q_image,M,N,1,1);

MsImage=zeros(M,N);

for i=1:M
    for j=1:N
        MT=[M1(i,j) M2(i,j) M3(i,j) M4(i,j)];
        MsImage(i,j)=max(MT);
    end
end

CSA = 72;
MSD = zeros(1,CSA);
MS = zeros(1,CSA);
HA = zeros(1,CSA);

for i=2:M-1
    for j=2:N-1
        Val=MsImage(i,j)+1;
        if Val > 0
            HA(Val)= HA(Val)+1;
        end
    end
end
            
for K=2:3:M-1
    for L=2:3:N-1
         block=MsImage(K-1:K+1,L-1:L+1);
         c = 0;
         Cb=block(2,2);
         for m=1:3
            for n=1:3
                if m~=n || n~=2
                    if Cb==block(m,n) && Cb>=0
                        c=c+1;
                    end
                end
            end
            Cbval=Cb+1;
            if Cbval > 0
                MS(Cbval) = MS(Cbval)+c;
            end
         end
    end
end
            
for i=1:CSA
    MSD(i) = MS(i)/((8.0 * HA(i))+0.0001);
end
end

