function HSV=RGBtoHSV(RGB,rows, columns)
%         RGB=double(RGB);
           
           HSV = zeros(rows, columns,3);

           for i = 1:rows-1
              for j = 1:columns-1
                  
                    cMax = 255.0;
                   
                    maximum = max(RGB( i, j,1), max(RGB( i, j,2), RGB( i, j,3)));
                    minimum = min(RGB( i, j,1), min(RGB( i, j,2), RGB( i, j,3)));

                    temp = maximum - minimum;

%                     // V component

                    HSV( i, j,3) = maximum * 1.0 / cMax;

%                     //S component
                    if (maximum > 0)
                    
                        HSV( i, j,2) = temp * 1.0 / maximum;
                    
                    else
                    
                        HSV( i, j,2) = 0.0;
                    end
%                     //H component
                    if (temp > 0)
                    
                         rr = (maximum - RGB( i, j,1)) * 1.0 / temp * 1.0;
                         gg = (maximum - RGB( i, j,2)) * 1.0 / temp * 1.0;
                         bb = (maximum - RGB( i, j,3)) * 1.0 / temp * 1.0;
                         hh = 0.0;

                        if (RGB( i, j,1) == maximum)
                        
                            hh = bb - gg;
                        
                        elseif (RGB( i, j,2) == maximum)
                       
                            hh = rr - bb + 2.0;
                        
                        else
                        
                            hh = gg - rr + 4.0;
                        end
                        if (hh < 0)
                        
                            hh = hh + 6;
                        end
                        HSV( i, j,1) = hh / 6;

                    end

                    HSV( i, j,1) = HSV( i, j,1)* 360.0;

              end
           end
end