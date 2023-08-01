function [ImageI] = GetIntMap(HSV,qi,rows,columns,ks)

V=HSV(:,:,3);        
ImageI=zeros(rows-ks, columns-ks); 
Mul=double(qi / max(V(:)));%//to quant Intensity

for x = 1+(ks/2):rows-(ks/2)            
    for y= 1+(ks/2):columns-(ks/2)       
                               
        VI =round( V(x, y) * Mul);
        if (VI >= qi )                                         
            VI = qi-1 ;                   
        end        
        ImageI(x-(ks/2),y-(ks/2))=VI;
            
    end   
end

end

