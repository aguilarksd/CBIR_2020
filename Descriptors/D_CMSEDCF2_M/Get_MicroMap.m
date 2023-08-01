function  Map = Get_MicroMap(S1,S2,Img,rows,columns)

A=Get_StructureMap(S1,S2,Img,rows,columns,0,0);
B=Get_StructureMap(S1,S2,Img,rows,columns,0,1);
C=Get_StructureMap(S1,S2,Img,rows,columns,1,0);
D=Get_StructureMap(S1,S2,Img,rows,columns,1,1);            

Map = zeros(rows, columns);
         
for i = 1:rows              
    for j = 1:columns
                    
        Map(i, j) = max(A(i, j), max(B(i, j), max(C(i, j), D(i, j))));
        
    end   
end
end