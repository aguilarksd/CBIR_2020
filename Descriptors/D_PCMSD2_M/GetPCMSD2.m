function PCMSD = GetPCMSD2(image,qc1,qc2,qc3,qo,qi,pv)

%//qc1,qc2,qc3 quant value in H S V qo,qi in orientation intensity 
qc = qc1*qc2*qc3;  %//quantization  number of HSV color space
hC= zeros(1,qc); %// micro-structure representation Color            
hO= zeros(1,qo); %// micro-structure representation Orientation          
hI= zeros(1,qi); %// micro-structure representation Intensity

[rows, columns, ~]=size(image);                                
HSV=double(rgb2hsv(image));%//Get HSV
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
    
    hC= hC+Get_MSR(mmC, qc, rows,columns); %// micro-structure representation Color            
    hO= hO+Get_MSR(mmO, qo, rows,columns); %// micro-structure representation Orientation          
    hI= hI+Get_MSR(mmI, qi, rows,columns); %// micro-structure representation Intensity
    
    %Re-escalado
    %"MODIFICACIÓN"--------------------------------------------------------------------------
    image=imresize(image,0.5);
    [rows, columns, ~]=size(image);                                
    HSV=double(rgb2hsv(image));%//Get HSV
    
end

PCMSD=[hC/pv,hO/pv,hI/pv];

end
    
