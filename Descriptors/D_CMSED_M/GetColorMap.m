function QHSV = GetColorMap(HSV,qnum1,qnum2,qnum3,rows,columns)  
            
QHSV  = zeros(rows-2, columns-2);           
             
for i = 2:rows-1              
    for j = 2:columns-1

        %// quantization H
        %HI = floor(HSV(i, j,1) * (qnum1 / 360.0));
        HI = round(HSV(i, j,1) * qnum1);%%HSV function
        if (HI >= qnum1)
                        
            HI = qnum1 - 1;
                    
        end
        %// quantization S        
        %SI = uint32(HSV(i, j,2) * qnum2);
        SI = floor(HSV(i, j,2) * qnum2); 
        if (SI >= qnum2)
                                            
            SI = qnum2 - 1;
                    
        end
        %// quantization V
        %VI = uint32(HSV(i, j,3) * qnum3);
        VI = floor(HSV(i, j,3) * qnum3);
        if (VI >= qnum3)
                                            
            VI = qnum3 - 1;
                    
        end       
        QHSV(i-1, j-1) = (qnum3 * qnum2) * HI + qnum3 * SI + VI; %// Q_CM
              
    end    
end
end