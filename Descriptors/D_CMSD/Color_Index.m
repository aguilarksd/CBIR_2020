function img=Color_Index(HSV,colnum1, colnum2, colnum3,rows,columns)
   
            img  = zeros(rows, columns);

           VI = 0; SI = 0; HI = 0;

             for i = 1:rows
              for j = 1:columns

                 VI = uint32(HSV(i, j,1) * (colnum1 / 360.0));


                    if (VI >= colnum1 - 1)
                    
                        VI = colnum1 - 1;
                    end
%                     //-------------------------------------

                    SI = uint32(HSV(i, j,2) * (colnum2 / 1.0));

                    if (SI >= colnum2 - 1)
                    
                        SI = colnum2 - 1;
                    end
%                     // -------------------------------------------

                    HI = uint32(HSV(i, j,3) * (colnum3 / 1.0));

                    if (HI >= colnum3 - 1)
                    
                        HI = colnum3 - 1;
                    end
               
                   
%                     //-------------------------------------------
                    img(i, j) = (colnum3 * colnum2) * VI + colnum3 * SI + HI;
              end
             end
end