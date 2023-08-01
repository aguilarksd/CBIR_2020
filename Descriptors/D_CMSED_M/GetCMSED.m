function CMSD = GetCMSED(image,qc1,qc2,qc3,qo,qi,Par)
%//qc1,qc2,qc3 quant value in H S V qo,qi in orientation intensity 
[rows, columns, ~]=size(image);
te=Par{1};%parameters
ne=Par{2};
pe=Par{3};
qc = qc1*qc2*qc3;  %//quantization  number of HSV color space                 
HSV=double(rgb2hsv(image));%//Get HSV

%// COLOR QUANTIZATION IN HSV COLOR SPACE
ImageC=GetColorMap(HSV,qc1,qc2,qc3,rows,columns);
%// MULTI-DIMENSIONAL TEXTURE ORIENTATION DETECTION IN RGB COLOR SPACE (MD-TOD)
ImageO=GetOriMap(HSV,qo,rows,columns);
% //INTENSITY MAP EXTRACTION            
ImageI=GetIntMap(HSV,qi,rows,columns);
if strcmp(pe,'DC')                  
    %// CORRELATED MICROSTRUCTURE IDENTIFICATION          
    mmC=Get_MicroMap(ImageO,ImageI,ImageC,rows,columns); %// MICRO-COLOR MAP FEATURES             
    mmO=Get_MicroMap(ImageI,ImageC,ImageO,rows,columns); %// MICRO-ORIENTATION MAP FEATURES        
    mmI=Get_MicroMap(ImageC,ImageO,ImageI,rows,columns); %// MICRO-INTENSITY MAP
    %// Structure Elements-------------------NEW---------------------------
    hEC=Get_SEH(ImageC,rows,columns,te,ne);
    hEO=Get_SEH(ImageO,rows,columns,te,ne);
    hEI=Get_SEH(ImageI,rows,columns,te,ne);
elseif strcmp(pe,'CC')
    [hEC,mmC]=Get_MicroMapStr(ImageO,ImageI,ImageC,rows,columns,te,ne); %// MICRO-COLOR MAP FEATURES             
    [hEO,mmO]=Get_MicroMapStr(ImageI,ImageC,ImageO,rows,columns,te,ne); %// MICRO-ORIENTATION MAP FEATURES        
    [hEI,mmI]=Get_MicroMapStr(ImageC,ImageO,ImageI,rows,columns,te,ne); %// MICRO-INTENSITY MAP
end
%//--------------------------------------------------------------------
hC= Get_MSR(mmC, qc, rows,columns); %// micro-structure representation Color            
hO= Get_MSR(mmO, qo, rows,columns); %// micro-structure representation Orientation          
hI= Get_MSR(mmI, qi, rows,columns); %// micro-structure representation Intensity
           
CMSD=[hEC,hEO,hEI,hC,hO,hI];

end
    
