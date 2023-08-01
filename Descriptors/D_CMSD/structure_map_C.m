function Color=structure_map_C(ori,img,imgv,rows,columns,Dx,Dy)
        
             Color =   zeros(rows, columns);

             for i=1:(rows/3)-1
                 for j=1:(columns/3)-1
            
                    WA = zeros(9,1);
                    WV= zeros(9,1);
%                     //===========================
                     m = 3 * i + Dx;
                     n = 3 * j + Dy;

                    WA(1) = ori(m - 1, n - 1);
                    WA(2) = ori(m - 1, n);
                    WA(3) = ori(m - 1, n + 1);

                    WA(4) = ori(m + 1, n - 1);
                    WA(5) = ori(m + 1, n);
                    WA(6) = ori(m + 1, n + 1);

                    WA(7) = ori(m, n - 1);
                    WA(8) = ori(m, n + 1);
                    WA(9) = ori(m, n);
                    
                    WV(1) = img(m - 1, n - 1);
                    WV(2) = img(m - 1, n);
                    WV(3) = img(m - 1, n + 1);

                    WV(4) = img(m + 1, n - 1);
                    WV(5) = img(m + 1, n);
                    WV(6) = img(m + 1, n + 1);

                    WV(7) = img(m, n - 1);
                    WV(8) = img(m, n + 1);
                    WV(9) = img(m, n);

%                     //-------------------------
                    if (WA(9) == WA(1) && WV(9) == WV(1))
                    
                        Color(m - 1, n - 1) = imgv(m - 1, n - 1);
                    
                    else
                    
                        Color(m - 1, n - 1) = -1;
                    end
%                     //--------------------
                    if (WA(9) == WA(2)&& WV(9) == WV(2))
                    
                        Color(m - 1, n) = imgv(m - 1, n);
                    
                    else
                    
                        Color(m - 1, n) = -1;
                    end
%                     //----------------------
                    if (WA(9) == WA(3)&& WV(9) == WV(3))
                    
                        Color(m - 1, n + 1) = imgv(m - 1, n + 1);
                    
                    else
                    
                        Color(m - 1, n + 1) = -1;
                    end
%                     //----------------------
                    if (WA(9) == WA(4)&& WV(9) == WV(4))
                    
                        Color(m + 1, n - 1) = imgv(m + 1, n - 1);
                    
                    else
                    
                        Color(m + 1, n - 1) = -1;

                    end
%                     //-------------------------
                    if (WA(9) == WA(5)&& WV(9) == WV(5))
                    
                        Color(m + 1, n) = imgv(m + 1, n);
                    
                    else
                    
                        Color(m + 1, n) = -1;
                    end
%                     //--------------------------
                    if (WA(9) == WA(6)&& WV(9) == WV(6))
                    
                        Color(m + 1, n + 1) = imgv(m + 1, n + 1);
                    
                    else
                    
                        Color(m + 1, n + 1) = -1;
                    end
%                     //-----------------------------------------
                    if (WA(9) == WA(7)&& WV(9) == WV(7))
                    

                        Color(m, n - 1) = imgv(m, n - 1);
                    
                    else
                    
                        Color(m, n - 1) = -1;
                    end
%                     //----------------------------------------
                    if (WA(9) == WA(8)&& WV(9) == WV(8))
                    
                        Color(m, n + 1) = imgv(m, n + 1);
                    
                    else
                    
                        Color(m, n + 1) = -1;
                    end
%                     //------------------------------------------
                    if (WA(9) == WA(9)&& WV(9) == WV(9)) 
                        Color(m, n) = imgv(m, n);
                    end
                 end
             end
end