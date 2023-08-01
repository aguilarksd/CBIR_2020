function ori=orientation_detection_2(HSV,num,rows,columns)

       
            thetaxy = zeros(rows, columns);
            thetapn = zeros(rows, columns);
             gxx = 0.0; gyy = 0.0; gxy = 0.0;
             rh = 0.0; gh = 0.0; bh = 0.0;
             rv = 0.0; gv = 0.0; bv = 0.0;
             theta = 0.0;
             hsv = zeros(rows, columns,3);


             for i = 1:rows-1
              for j = 1:columns-1
                
                    hsv(i, j,1) = HSV(i, j,1) * cos(HSV(i, j,1));
                    hsv(i, j,2) = HSV(i, j,2) * sin(HSV(i, j,1));
                    hsv(i, j,3) = HSV(i, j,3);
                
              end
              end


            
             for i = 2:rows-2
              for j = 2:columns-2

%                     //--------------------------------------
                    rh = (hsv( i - 1, j + 1,1) + 2 * hsv(i, j + 1,1) + hsv(i + 1, j + 1,1)) - (hsv(i - 1, j - 1,1) + 2 * hsv(i, j - 1,1) + hsv(i + 1, j - 1,1));
                    gh = (hsv( i - 1, j + 1,2) + 2 * hsv( i, j + 1,2) + hsv(i + 1, j + 1,2)) - (hsv(i - 1, j - 1,2) + 2 * hsv(i, j - 1,2) + hsv(i + 1, j - 1,2));
                    bh = (hsv(i - 1, j + 1,3) + 2 * hsv( i, j + 1,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3) + 2 * hsv( i, j - 1,3) + hsv(i + 1, j - 1,3));

%                     //-----------------------------------------
                    rv = (hsv(i + 1, j - 1,1) + 2 * hsv(i + 1, j,1) + hsv( i + 1, j + 1,1)) - (hsv( i - 1, j - 1,1) + 2 * hsv( i - 1, j,1) + hsv( i - 1, j + 1,1));
                    gv = (hsv( i + 1, j - 1,2) + 2 * hsv( i + 1, j,2) + hsv( i + 1, j + 1,2)) - (hsv( i - 1, j - 1,2) + 2 * hsv( i - 1, j,2) + hsv( i - 1, j + 1,2));
                    bv = (hsv( i + 1, j - 1,3) + 2 * hsv( i + 1, j,3) + hsv( i + 1, j + 1,3)) - (hsv( i - 1, j - 1,3)+ 2 * hsv( i - 1, j,3) + hsv( i - 1, j + 1,3));

%                     //---------------------------------------
                    gxx = sqrt(rh * rh + gh * gh + bh * bh);
                    gyy = sqrt(rv * rv + gv * gv + bv * bv);
                    gxy = rh * rv + gh * gv + bh * bv;

                    anglexy = (acos(gxy / (gxx * gyy + 0.0001)) * 180.0 / pi);
%  thetaxy1(i, j) =anglexy;
                    thetaxy(i, j) = (round(anglexy * num / 180.0));

                    if (thetaxy(i, j) >= num ) 
                       thetaxy(i, j) = num - 1;

                    end
              end
             end
             
             % diagnol directions
             
   for x = 2:rows-2
       for y=2:columns-2
        
% %      Apply +45 degree edge filter

         rpd = (hsv(x-1,y,1) + (2 * hsv(x-1,y+1,1)) + hsv(x,y+1,1)) - (hsv(x,y-1,1) + (2 * hsv(x+1,y-1,1)) + hsv(x+1,y,1));
         gpd = (hsv(x-1,y,2) + (2 * hsv(x-1,y+1,2)) + hsv(x,y+1,2)) - (hsv(x,y-1,2) + (2 * hsv(x+1,y-1,2)) + hsv(x+1,y,2));
         bpd =(hsv(x-1,y,3) + (2 * hsv(x-1,y+1,3)) + hsv(x,y+1,3)) - (hsv(x,y-1,3) + (2 * hsv(x+1,y-1,3)) + hsv(x+1,y,3));

         % Apply -45 degree edge filter
         rnd = (hsv(x+1, y,1) + (2 * hsv(x+1,y+1,1)) + hsv(x, y+1,1)) - (hsv(x , y - 1,1) + (2 * hsv( x - 1, y-1,1)) + hsv( x - 1, y ,1));
         gnd =  (hsv(x+1, y,2) + (2 * hsv(x+1,y+1,2)) + hsv(x, y+1,2)) - (hsv(x , y - 1,2) + (2 * hsv( x - 1, y-1,2)) + hsv( x - 1, y ,2));
         bnd =  (hsv(x+1, y,3) + (2 * hsv(x+1,y+1,3)) + hsv(x, y+1,3)) - (hsv(x , y - 1,3) + (2 * hsv( x - 1, y-1,3)) + hsv( x - 1, y ,3));
         
         gpp = sqrt(rpd * rpd + gpd * gpd + bpd * bpd);
         gnn =sqrt(rnd * rnd + gnd * gnd + bnd * bnd);
         gpn =rpd * rnd + gpd * gnd + bpd * bnd ;
                        
  anglepn=(acos(gpn / (gpp * gnn + 0.0001)) * 180 /pi);
%   thetapn1(x, y) =anglepn;
  thetapn(x,y)=(round(anglepn * num / 180.0));

  if (thetapn(i, j) >= num ) 
                       thetapn(i, j) = num - 1;

  end
                         
       end
   end
  
 ori=round((thetaxy+thetapn)./2);  
%  ori1=round((thetaxy1+thetapn1)./2);  
% ori=thetaxy;
end
         
            
    