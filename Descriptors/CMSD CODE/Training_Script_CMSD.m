
    function TrainingImage_Features=Training_Script_MSD(trainingSet,color,theta,intensity)

  Totaltrainingimages=numel(trainingSet.Files);
   TrainingImage_Features=zeros(Totaltrainingimages,color+theta+intensity);
  Feature_Index=0;

 for CurrentImage = 1 : Totaltrainingimages
%      im=716;
  queryimage= readimage(trainingSet,CurrentImage); 
  Feature_Index=Feature_Index+1;
  [rows, columns, ~]=size(queryimage);
  queryimage=double(queryimage);
   ImageV=zeros(rows,columns);
             CSA = color;  %// the total color quantization  number of HSV color space
             CSB = theta;   %//the quantization number of edge orientation
             CSC=intensity;
            %//--------------------------------------------
             Cn1 = 8;   %//the quantization number of H 
             Cn2 = 3;   %//the quantization number of S 
             Cn3 = 3;   %//the quantization number of V 
%              D = 1;
%             hist = zeros(CSA); %// the features vector of MSD          
            HSV=RGBtoHSV(queryimage,rows,columns);
%             V=pwm_(queryimage);
            V=HSV(:,:,3);
            [r,c]=size(V);
            Mul=(CSC / max(V(:)));

            for x = 1:r-1
            for y=1:c-1       
         
                      VI =uint32( V(x, y) * Mul);
% 
                    if (VI >= CSC )                   
                        VI = CSC-1 ;
                    end  
                   ImageV(x,y)=VI;     
            end
            end
           
            ori=orientation_detection_2(HSV,CSB,rows,columns);
            ImageX=Color_Index(HSV,Cn1, Cn2, Cn3,rows,columns);             
                  
            microA=microstructuredetection_A(ori,ImageX,ImageV,rows,columns);
            microB=microstructuredetection_B(ori,ImageX,ImageV,rows,columns);
            microC=microstructuredetection_C(ori,ImageX,ImageV,rows,columns);
           histA= MSD(microA, CSA, rows,columns);  
           histB= MSD(microB, CSB, rows,columns); 
           histC= MSD(microC, CSC, rows,columns); %//micro-structure representation
           hist=horzcat(histA,histB,histC);
%  hist=histB;
           TrainingImage_Features(Feature_Index,1:end)=hist;
   end
end
    
