function [hsv_Cart] = Cylin2Cart(imghsv,M,N)

hsv_Cart=zeros(M,N);
for i=1:M
    for j=1:N
        D=round(imghsv(i,j,1)*360);
        hsv_Cart(i,j,1)= imghsv(i,j,2)*cosd(D);
        hsv_Cart(i,j,2)= imghsv(i,j,2)*sind(D);
        hsv_Cart(i,j,3)= imghsv(i,j,3);
    end
end

end

