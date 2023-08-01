function [ImageI] = GetIntMap(HSV,qi,rows,columns)

V=HSV(:,:,3);        
[r,c]=size(V);
ImageI=zeros(rows-2,columns-2); 
Mul=double(qi / max(V(:)));%//to quant Intensity

for x = 2:r-1            
    for y=2:c-1       
                               
        VI =round( V(x, y) * Mul);
        if (VI >= qi )                                         
            VI = qi-1 ;                   
        end        
        ImageI(x-1,y-1)=VI;
            
    end   
end

end

