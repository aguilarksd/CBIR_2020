function PCMSED = GetPCMSEDp(image,qc1,qc2,qc3,qo,qi,pv,Pa)
%obtencion por separado o cambiando combinación pa indica cuales considera

%//qc1,qc2,qc3 quant value in H S V qo,qi in orientation intensity 
qc = qc1*qc2*qc3;  %//quantization  number of HSV color space
hC= zeros(1,qc+(qc-9)+(qc-18)+(qc-27)); %// micro-structure representation Color            
hO= zeros(1,qo*pv); %// micro-structure representation Orientation          
hI= zeros(1,qi*pv); %// micro-structure representation Intensity
hEC=zeros(1,9);hEO=zeros(1,9);hEI=zeros(1,9);

np=length(Pa);

[rows, columns, ~]=size(image);                                
HSV=double(rgb2hsv(image));%//Get HSV
fc2=0;fo2=0;fi2=0;
for i=1:pv
    
    %// COLOR QUANTIZATION IN HSV COLOR SPACE
    ImageC=Color_quant(HSV,qc1,qc2,qc3,rows,columns);
    %// MULTI-DIMENSIONAL TEXTURE ORIENTATION DETECTION IN RGB COLOR SPACE (MD-TOD)
    ImageO=GetMD_TOD(HSV,qo,rows,columns);
    % //INTENSITY MAP EXTRACTION            
    ImageI=GetIntMap(HSV,qi,rows,columns);
                  
    %// CORRELATED MICROSTRUCTURE IDENTIFICATION          
    mmC=Get_MicroMap(ImageO,ImageI,ImageC,rows,columns); %// MICRO-COLOR MAP FEATURES             
    mmO=Get_MicroMap(ImageI,ImageC,ImageO,rows,columns); %// MICRO-ORIENTATION MAP FEATURES        
    mmI=Get_MicroMap(ImageC,ImageO,ImageI,rows,columns); %// MICRO-INTENSITY MAP

    fc1=fc2+1;
    fc2=fc2+qc;
    fo1=fo2+1;
    fo2=fo2+qo;
    fi1=fi2+1;
    fi2=fi2+qi;
    hC(fc1:fc2)= Get_MSR(mmC, qc, rows,columns); %// micro-structure representation Color            
    hO(fo1:fo2)= Get_MSR(mmO, qo, rows,columns); %// micro-structure representation Orientation          
    hI(fi1:fi2)= Get_MSR(mmI, qi, rows,columns); %// micro-structure representation Intensity
    for j=1:np
        if i==Pa(j)
            %// Structure Elements-------------------NEW---------------------------
            hEC=hEC+Get_SEH(ImageC,rows,columns);
            hEO=hEO+Get_SEH(ImageO,rows,columns);
            hEI=hEI+Get_SEH(ImageI,rows,columns);
        end
    end
    

    
    %Re-escalado
    %"MODIFICACIÓN"--------------------------------------------------------------------------
    image=imresize(image,0.5);
    [rows, columns, ~]=size(image);                                
    HSV=double(rgb2hsv(image));%//Get HSV
    qc1=qc1-1;
    qc = qc1*qc2*qc3;
    
end

PCMSED=[hEC/np,hEO/np,hEI/np,hC,hO,hI];%length 9+9+9+PCMSD1

end
    
