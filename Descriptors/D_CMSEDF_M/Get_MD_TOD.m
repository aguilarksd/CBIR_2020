function [RGBv,RGBh,RGBg,V,H] = Get_MD_TOD(RGB)       

% we use MD_TOD  

%thetaxy = zeros(rows-2, columns-2);            
%thetapn = zeros(rows-2, columns-2);             
             
hsv = RGB;
[rows, columns, ~]=size(RGB);
RGBv = zeros(rows-2, columns-2,3);  
RGBh = zeros(rows-2, columns-2,3);  
RGBg = zeros(rows-2, columns-2,3); 
V = zeros(rows-2, columns-2);
H = zeros(rows-2, columns-2);

% // Sobel horizontal and vertical directions
for i = 2:rows-1              
    for j = 2:columns-1
        
        %// Horizontal
        RGBh(i-1,j-1,1) = (hsv( i - 1, j + 1,1) + 2 * hsv(i, j + 1,1) + hsv(i + 1, j + 1,1)) - (hsv(i - 1, j - 1,1) + 2 * hsv(i, j - 1,1) + hsv(i + 1, j - 1,1));                    
        RGBh(i-1,j-1,2) = (hsv( i - 1, j + 1,2) + 2 * hsv( i, j + 1,2) + hsv(i + 1, j + 1,2)) - (hsv(i - 1, j - 1,2) + 2 * hsv(i, j - 1,2) + hsv(i + 1, j - 1,2));                    
        RGBh(i-1,j-1,3) = (hsv(i - 1, j + 1,3) + 2 * hsv( i, j + 1,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3) + 2 * hsv( i, j - 1,3) + hsv(i + 1, j - 1,3));
        %// Vertical            
        RGBv(i-1,j-1,1) = (hsv(i + 1, j - 1,1) + 2 * hsv(i + 1, j,1) + hsv( i + 1, j + 1,1)) - (hsv( i - 1, j - 1,1) + 2 * hsv( i - 1, j,1) + hsv( i - 1, j + 1,1));                    
        RGBv(i-1,j-1,2) = (hsv( i + 1, j - 1,2) + 2 * hsv( i + 1, j,2) + hsv( i + 1, j + 1,2)) - (hsv( i - 1, j - 1,2) + 2 * hsv( i - 1, j,2) + hsv( i - 1, j + 1,2));                    
        RGBv(i-1,j-1,3) = (hsv( i + 1, j - 1,3) + 2 * hsv( i + 1, j,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3)+ 2 * hsv( i - 1, j,3) + hsv( i - 1, j + 1,3));
        %gradiente
        RGBg(i-1,j-1,1)=sqrt(RGBh(i-1,j-1,1)*RGBh(i-1,j-1,1) +  RGBv(i-1,j-1,1)* RGBv(i-1,j-1,1));
        RGBg(i-1,j-1,2)=sqrt(RGBh(i-1,j-1,2)*RGBh(i-1,j-1,2) +  RGBv(i-1,j-1,2)* RGBv(i-1,j-1,2));
        RGBg(i-1,j-1,3)=sqrt(RGBh(i-1,j-1,3)*RGBh(i-1,j-1,3) +  RGBv(i-1,j-1,3)* RGBv(i-1,j-1,3));
        %// Obtain angle by the product of the vectors  H*V= |H|*|V|*cos(angle) ∴ angle = arcos (H*V/|H|*|V|) 
        H(i-1,j-1)=sqrt(RGBh(i-1,j-1,1)*RGBh(i-1,j-1,1) +  RGBh(i-1,j-1,2)* RGBh(i-1,j-1,2)+RGBh(i-1,j-1,3)*RGBh(i-1,j-1,3));
        V(i-1,j-1)=sqrt(RGBv(i-1,j-1,1)*RGBv(i-1,j-1,1) +  RGBv(i-1,j-1,2)* RGBv(i-1,j-1,2)+RGBv(i-1,j-1,3)*RGBv(i-1,j-1,3));
        %gxx = sqrt(rh * rh + gh * gh + bh * bh); %// |H|     Magnitud de vectro H   (gradiente)           
        %gyy = sqrt(rv * rv + gv * gv + bv * bv); %// |V|     Magnitud de vector V   (gradiente)           
        %gxy = rh * rv + gh * gv + bh * bv; %// H*V  Producto punto                         
        %%anglexy = (acos(gxy / (gxx * gyy + 0.0001)) * 180.0 / pi);%// arcos (H*V/|H|*|V|) radians to degrees (+0.0001):avoid division by 0                    
        %anglexy = acosd(gxy / (gxx * gyy + 0.0001));
        %thetaxy(i-1, j-1) = round((anglexy * num / 180.0)); %// quantization                   
        %if (thetaxy(i-1, j-1) >= num )                       
            %thetaxy(i-1, j-1) = num - 1;                   
        %end
        
    end    
end
%ICV=zeros(size(RGBv),'uint8');
%ICH=zeros(size(RGBh),'uint8');
%ICG=zeros(size(RGBg),'uint8');
RGBv = uint8(255 * mat2gray(RGBv));  
RGBh = uint8(255 * mat2gray(RGBh));
RGBg = uint8(255 * mat2gray(RGBg)); 
V=mat2gray(V);
H=mat2gray(H);
%{            
% // Sobel diagonal directions                
for x = 2:rows-1       
    for y=2:columns-1             
        
        %// Apply +45 degree edge filter
        rpd = (hsv(x-1,y,1) + (2 * hsv(x-1,y+1,1)) + hsv(x,y+1,1)) - (hsv(x,y-1,1) + (2 * hsv(x+1,y-1,1)) + hsv(x+1,y,1));         
        gpd = (hsv(x-1,y,2) + (2 * hsv(x-1,y+1,2)) + hsv(x,y+1,2)) - (hsv(x,y-1,2) + (2 * hsv(x+1,y-1,2)) + hsv(x+1,y,2));         
        bpd =(hsv(x-1,y,3) + (2 * hsv(x-1,y+1,3)) + hsv(x,y+1,3)) - (hsv(x,y-1,3) + (2 * hsv(x+1,y-1,3)) + hsv(x+1,y,3));         
        %// Apply -45 degree edge filter        
        rnd = (hsv(x+1, y,1) + (2 * hsv(x+1,y+1,1)) + hsv(x, y+1,1)) - (hsv(x , y - 1,1) + (2 * hsv( x - 1, y-1,1)) + hsv( x - 1, y ,1));         
        gnd =  (hsv(x+1, y,2) + (2 * hsv(x+1,y+1,2)) + hsv(x, y+1,2)) - (hsv(x , y - 1,2) + (2 * hsv( x - 1, y-1,2)) + hsv( x - 1, y ,2));         
        bnd =  (hsv(x+1, y,3) + (2 * hsv(x+1,y+1,3)) + hsv(x, y+1,3)) - (hsv(x , y - 1,3) + (2 * hsv( x - 1, y-1,3)) + hsv( x - 1, y ,3));
        %// Obtain angle by the product of the vectors  d45*d135= |d45|*|d135|*cos(angle) ∴ angle = arcos (d45*d135/|d45|*|d135|)         
        gpp = sqrt(rpd * rpd + gpd * gpd + bpd * bpd); %// |d45|
        gnn =sqrt(rnd * rnd + gnd * gnd + bnd * bnd);  %// |d135|       
        gpn =rpd * rnd + gpd * gnd + bpd * bnd ; %// d45*d135                          
        %anglepn=(acos(gpn / (gpp * gnn + 0.0001)) * 180 /pi); %// angle = arcos (d45*d135/|d45|*|d135|)  
        %thetapn(x-1,y-1)=(round(anglepn * num / 180.0)); %// quantization
        anglepn = acosd(gpn / (gpp * gnn + 0.0001));
        thetapn(x-1, y-1) = round((anglepn * num / 180.0)); %// quantization  
        if (thetapn(x-1, y-1) >= num ) 
            thetapn(x-1, y-1) = num - 1;
        end
        
    end    
end

ori=round((thetaxy+thetapn)/2); %// Qorimap = average of two angles
%}
end