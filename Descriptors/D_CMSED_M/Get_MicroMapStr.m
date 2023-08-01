function  [SEH,Map] = Get_MicroMapStr(S1,S2,Img,rows,columns,te,ne)

[A,H1]=Get_StructureMapHS(S1,S2,Img,rows,columns,0,0,te,ne);
[B,H2]=Get_StructureMapHS(S1,S2,Img,rows,columns,0,1,te,ne);
[C,H3]=Get_StructureMapHS(S1,S2,Img,rows,columns,1,0,te,ne);
[D,H4]=Get_StructureMapHS(S1,S2,Img,rows,columns,1,1,te,ne);            

Map = zeros(rows-2, columns-2);
         
for i = 1:rows-2              
    for j = 1:columns-2
                    
        Map(i, j) = max(A(i, j), max(B(i, j), max(C(i, j), D(i, j))));
        
    end   
end
SEH=(H1+H2+H3+H4)/4;
end