function [Q_image] = GetQntRngHSV(imghsv,M,N)

Q_image=zeros(M,N);
for i=1:M
    for j=1:N
        H=floor(imghsv(i,j,1)*360);
        Hq=0;
        switch true
            case H>=25 && H<=49
                Hq=1;
            case H>=50 && H<=79
                Hq=2;    
            case H>=80 && H<=159
                Hq=3;    
            case H>=160 && H<=194        
                Hq=4;   
            case H>=195 && H<=264        
                Hq=5;   
            case H>=265 && H<=284       
                Hq=6;    
            case H>=285 && H<=344        
                Hq=7;
        end
        S=imghsv(i,j,2);
        Sq=0;
        switch true
            case S>=0.15 && S<0.80
                Sq=1;
            case S>=0.80
                Sq=2;
        end
        V=imghsv(i,j,3);
        Vq=0;
        switch true
            case ((V>=0.15)&&(V<0.80))
                Vq=1;
            case (V>=0.80)
                Vq=2;
        end
        Q_image(i,j)=(9*Hq)+(3*Sq)+Vq;
    end
end
end
