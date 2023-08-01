function ori = GetOriMap(HSV,num,rows,columns,ks)       

% we use MD_TOD  

thetaxy = zeros(rows-ks, columns-ks);            
thetapn = zeros(rows-ks, columns-ks);             
             
hsv = zeros(rows, columns,3);

% // Cylindrical to Cartesian
for i = 1:rows              
    for j = 1:columns               
                    
        %hsv(i, j,1) = HSV(i, j,2) * cos(HSV(i, j,1));                    
        %hsv(i, j,2) = HSV(i, j,2) * sin(HSV(i, j,1));
        D=HSV(i,j,1)*360;
        hsv(i, j,1) = HSV(i, j,2) * cosd(D); %%HSV Function                   
        hsv(i, j,2) = HSV(i, j,2) * sind(D); %%HSV Function   
        hsv(i, j,3) = HSV(i, j,3);               
              
    end    
end

% // Sobel horizontal and vertical directions
for i = 1+(ks/2):rows-(ks/2)              
    for j = 1+(ks/2):columns-(ks/2)
        
        %// Horizontal
        rh = (hsv( i - 1, j + 1,1) + 2 * hsv(i, j + 1,1) + hsv(i + 1, j + 1,1)) - (hsv(i - 1, j - 1,1) + 2 * hsv(i, j - 1,1) + hsv(i + 1, j - 1,1));                    
        gh = (hsv( i - 1, j + 1,2) + 2 * hsv( i, j + 1,2) + hsv(i + 1, j + 1,2)) - (hsv(i - 1, j - 1,2) + 2 * hsv(i, j - 1,2) + hsv(i + 1, j - 1,2));                    
        bh = (hsv(i - 1, j + 1,3) + 2 * hsv( i, j + 1,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3) + 2 * hsv( i, j - 1,3) + hsv(i + 1, j - 1,3));
        %// Vertical            
        rv = (hsv(i + 1, j - 1,1) + 2 * hsv(i + 1, j,1) + hsv( i + 1, j + 1,1)) - (hsv( i - 1, j - 1,1) + 2 * hsv( i - 1, j,1) + hsv( i - 1, j + 1,1));                    
        gv = (hsv( i + 1, j - 1,2) + 2 * hsv( i + 1, j,2) + hsv( i + 1, j + 1,2)) - (hsv( i - 1, j - 1,2) + 2 * hsv( i - 1, j,2) + hsv( i - 1, j + 1,2));                    
        bv = (hsv( i + 1, j - 1,3) + 2 * hsv( i + 1, j,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3)+ 2 * hsv( i - 1, j,3) + hsv( i - 1, j + 1,3));
        %// Obtain angle by the product of the vectors  H*V= |H|*|V|*cos(angle) ∴ angle = arcos (H*V/|H|*|V|)              
        gxx = sqrt(rh * rh + gh * gh + bh * bh); %// |H|                   
        gyy = sqrt(rv * rv + gv * gv + bv * bv); %// |V|                   
        gxy = rh * rv + gh * gv + bh * bv; %// H*V                           
        %anglexy = (acos(gxy / (gxx * gyy + 0.0001)) * 180.0 / pi);%// arcos (H*V/|H|*|V|) radians to degrees (+0.0001):avoid division by 0                    
        anglexy = acosd(gxy / (gxx * gyy + 0.0001));
        thetaxy(i-(ks/2), j-(ks/2)) = round((anglexy * num / 180.0)); %// quantization                   
        if (thetaxy(i-(ks/2), j-(ks/2)) >= num )                       
            thetaxy(i-(ks/2), j-(ks/2)) = num - 1;                   
        end
        
    end    
end
             
% // Sobel diagonal directions                
for x = 1+(ks/2):rows-(ks/2)       
    for y=1+(ks/2):columns-(ks/2)             
        
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
        thetapn(x-(ks/2), y-(ks/2)) = round((anglepn * num / 180.0)); %// quantization  
        if (thetapn(x-(ks/2), y-(ks/2)) >= num ) 
            thetapn(x-(ks/2), y-(ks/2)) = num - 1;
        end
        
    end    
end

ori=round((thetaxy+thetapn)/2); %// Qorimap = average of two angles

end
         
            
    