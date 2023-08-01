function QHSV = GetColorMap(HSV,qnum1,qnum2,qnum3,rows,columns,ks)  
            
QHSV  = zeros(rows-ks, columns-ks);           
             
for i = 1+(ks/2):rows-(ks/2)             
    for j = 1+(ks/2):columns-(ks/2)

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
        QHSV(i-(ks/2), j-(ks/2)) = (qnum3 * qnum2) * HI + qnum3 * SI + VI; %// Q_CM
              
    end    
end
end