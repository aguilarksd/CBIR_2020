function SEH = Get_SEH(img,rows,columns)        
             
H1=Get_HiStructures(img,rows,columns,0,0);
H2=Get_HiStructures(img,rows,columns,0,1);
H3=Get_HiStructures(img,rows,columns,1,0);
H4=Get_HiStructures(img,rows,columns,1,1);
SEH=(H1+H2+H3+H4)/4;

end
