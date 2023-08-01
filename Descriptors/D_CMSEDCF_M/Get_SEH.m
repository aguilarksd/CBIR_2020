function SEH = Get_SEH(img,rows,columns,te,ne)        
             
H1=Get_HiStructures(img,rows,columns,0,0,te,ne);
H2=Get_HiStructures(img,rows,columns,0,1,te,ne);
H3=Get_HiStructures(img,rows,columns,1,0,te,ne);
H4=Get_HiStructures(img,rows,columns,1,1,te,ne);
SEH=(H1+H2+H3+H4)/4;

end
