function ori = GetOriMap2(HSV,num,rows,columns,ks,A)       

% we use MD_TOD  Fraccional

thetaxy = zeros(rows-ks, columns-ks);            
thetapn = zeros(rows-ks, columns-ks);             
             
hsv = zeros(rows, columns,3);

% // Cylindrical to Cartesian
for i = 1:rows              
    for j = 1:columns               
                    
        D=HSV(i,j,1)*360;
        hsv(i, j,1) = HSV(i, j,2) * cosd(D); %%HSV Function                   
        hsv(i, j,2) = HSV(i, j,2) * sind(D); %%HSV Function   
        hsv(i, j,3) = HSV(i, j,3);               
              
    end    
end
% // Valores del kernel
v1=1-A+(3*A/2);
v2=1-A+(A/2);
% // Kernels
Sx=[v2 v1  0 -v1 -v2;
    v2 v1  0 -v1 -v2;
    v2 v1  0 -v1 -v2;
    v2 v1  0 -v1 -v2;
    v2 v1  0 -v1 -v2;];
Sy=rot90(-Sx);
S45=[v2 v2  v2  v1   0;    
     v2  v1  v1   0 -v1;
     v2  v1   0 -v1 -v2;
     v1   0 -v1 -v1 -v2;
      0 -v1 -v2 -v2 -v2];
S135=rot90(S45);
% // Sobel 
for i = 1+(ks/2):rows-(ks/2)               
    for j = 1+(ks/2):columns-(ks/2)      
        %// sobel X
        rx = conv2(Sx,hsv(i-2:i+2,j-2:j+2,1),'valid');                    
        gx = conv2(Sx,hsv(i-2:i+2,j-2:j+2,2),'valid');                  
        bx = conv2(Sx,hsv(i-2:i+2,j-2:j+2,3),'valid');
        %// sobel Y            
        ry = conv2(Sy,hsv(i-2:i+2,j-2:j+2,2),'valid');                    
        gy = conv2(Sy,hsv(i-2:i+2,j-2:j+2,2),'valid');                   
        by = conv2(Sy,hsv(i-2:i+2,j-2:j+2,3),'valid');
        %// Obtain angle by the product of the vectors  H*V= |H|*|V|*cos(angle) ∴ angle = arcos (H*V/|H|*|V|)              
        gxx = sqrt(rx * rx + gx * gx + bx * bx); %// |H|                   
        gyy = sqrt(ry * ry + gy * gy + by * by); %// |V|                   
        gxy = rx * ry + gx * gy + bx * by; %// H*V                                               
        anglexy = acosd(gxy / (gxx * gyy + 0.0001));
        thetaxy(i-(ks/2) , j-(ks/2) ) = round((anglexy * num / 180.0)); %// quantization                   
        if (thetaxy(i-(ks/2), j-(ks/2)) >= num )                       
            thetaxy(i-(ks/2), j-(ks/2)) = num - 1;                   
        end
        %// Apply +45 degree edge filter
        rpd = conv2(S45,hsv(i-2:i+2,j-2:j+2,1),'valid');         
        gpd = conv2(S45,hsv(i-2:i+2,j-2:j+2,2),'valid');         
        bpd = conv2(S45,hsv(i-2:i+2,j-2:j+2,3),'valid');         
        %// Apply 135 degree edge filter        
        rnd = conv2(S135,hsv(i-2:i+2,j-2:j+2,1),'valid');         
        gnd = conv2(S135,hsv(i-2:i+2,j-2:j+2,2),'valid');        
        bnd = conv2(S135,hsv(i-2:i+2,j-2:j+2,3),'valid');
        %// Obtain angle by the product of the vectors  d45*d135= |d45|*|d135|*cos(angle) ∴ angle = arcos (d45*d135/|d45|*|d135|)         
        gpp = sqrt(rpd * rpd + gpd * gpd + bpd * bpd); %// |d45|
        gnn =sqrt(rnd * rnd + gnd * gnd + bnd * bnd);  %// |d135|       
        gpn =rpd * rnd + gpd * gnd + bpd * bnd ; %// d45*d135                          
        anglepn = acosd(gpn / (gpp * gnn + 0.0001));
        thetapn(i-(ks/2), j-(ks/2)) = round((anglepn * num / 180.0)); %// quantization  
        if (thetapn(i-(ks/2), j-(ks/2)) >= num ) 
            thetapn(i-(ks/2), j-(ks/2)) = num - 1;
        end
    end    
end

ori=round((thetaxy+thetapn)/2); %// Qorimap = average of two angles

end