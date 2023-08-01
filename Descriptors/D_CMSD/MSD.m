function hist=MSD(ColorX, CSA, rows,columns)
        
        
% 
            MS = zeros(1,CSA);
            HA = zeros(1,CSA);

%             //----------------------------------------
           for i = 2:rows-2
              for j = 2:columns-2
                  
%                   if (ColorX(i, j) == 0)
%                     
%                         HA() = HA(ColorX(i, j))+ 1;
%                     
%                 
%                     end
                  
                  if (ColorX(i, j) >0  )
%                         val=(ColorX(i, j)) ;
%                         val1=val+1;
                        HA((ColorX(i, j))) = HA((ColorX(i, j)))+ 1;  
%                         HA(ColorX(i, j)) =  HA(ColorX(i, j)) + 1;
                
                  elseif (ColorX(i, j) ==0  )
                      HA((ColorX(i, j)+1)) = HA((ColorX(i, j)+1))+ 1; 
                  else
                  end
                 
%                   if (ColorX(i, j) == 0 )
% %                         val=(ColorX(i, j)) ;
% %                         val1=val+1;
% %                         HA((ColorX(i, j))+1) = HA((ColorX(i, j))+1)+ 1;  
%                         HA(ColorX(i, j)+1) =  HA(ColorX(i, j)+1) + 1;
%                 
%                   end
              end
           end
%             //----------------------------------------
           
for i=3:3*(rows / 3) - 1
    for j=3:3*(columns / 3) - 1


                     wa = zeros(1,9);


                    wa(1) = ColorX(i - 1, j - 1);
                    wa(2) = ColorX(i - 1, j);
                    wa(3) = ColorX(i - 1, j + 1);

                    wa(4) = ColorX(i + 1, j - 1);
                    wa(5) = ColorX(i + 1, j);
                    wa(6) = ColorX(i + 1, j + 1);

                    wa(7) = ColorX(i, j - 1);
                    wa(8) = ColorX(i, j + 1);
                    wa(9) = ColorX(i, j);
%                     //-------------------------
                    TE1 = 0;

                    for m=1:8
                                            
                        if ((wa(9) == wa(m)) && (wa(9) >= 0))
                        
                            TE1 = TE1 + 1;
                        

                        end
                    end
                    
                    if (wa(9) > 0)
%                     val2=wa(9)+1;
                        MS(wa(9)) = MS(wa(9))+ TE1;
%                     MS(wa(9)) = MS(wa(9))+ TE1;
                    end
%                     if (wa(9) == 0)
% %                     val2=wa(9)+1;
% %                         MS(wa(9)+1) = MS(wa(9)+1)+ TE1;
%                     MS(wa(9)+1) = MS(wa(9)+1)+ TE1;
%                     end

    end
end

%             // the features vector of MSD 

for i=1:CSA


                hist(i) = (MS(i) * 1.0) / (8.0 * HA(i) + 0.0001);
end
end
