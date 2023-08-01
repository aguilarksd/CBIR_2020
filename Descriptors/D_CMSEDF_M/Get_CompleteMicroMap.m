function [Map] = Get_CompleteMicroMap(S1,S2,img,rows,columns)        

Map = ones(rows, columns);
Map = Map*-1;
for i=2:rows-1               
    for j=2:columns-1         
                    
        WA = S1(i-1:i+1,j-1:j+1);  
        WV = S2(i-1:i+1,j-1:j+1);       
        for m=1:3
            for n=1:3
                if (WA(5) == WA(m,n) || WV(5) == WV(m,n)) 
                %if (WA(5) == WA(m,n) && WV(5) == WV(m,n))  
                    Map(i+(m-2), j+(n-2)) = img(i+(m-2), j+(n-2));                                                                     
                end          
            end
        end
    end  
end
end