function H = GetCMTH(img)
%%calculate orientation and gradient
%Manipulate these variables to get beeter results
Obins = 9;
TCbins = 9;
TGbins = 9;
img = imresize(img, [128 128]);

Sobelx = [1 0 -1;2 0 -2; 1 0 -1];
Sobely = [1 2 1;0 0 0; -1 -2 -1];
if(ndims(img) >2)
    Ix(:,:,1)=conv2(img(:,:,1), Sobelx,'same');
    Ix(:,:,2)=conv2(img(:,:,2), Sobelx,'same');
    Ix(:,:,3)=conv2(img(:,:,3), Sobelx,'same');
    
    Iy(:,:,1)=conv2(img(:,:,1), Sobely,'same');
    Iy(:,:,2)=conv2(img(:,:,2), Sobely,'same');
    Iy(:,:,3)=conv2(img(:,:,3), Sobely,'same');
    
    O = acos(sum((Ix.*Iy),3)./(1+sqrt(...
                            Ix(:,:,1).^2+Ix(:,:,2).^2+Ix(:,:,3).^2).*...
                        sqrt(...
                            Iy(:,:,1).^2+Iy(:,:,2).^2+Iy(:,:,3).^2)));
else
    Ix = conv2(img, Sobelx,'same');
    Iy = conv2(img, Sobely,'same');
    O = atan(Iy./Ix)+pi/2;
    O(isnan(O)) = 0;
end

O = uint8(imquantize(O,[pi/Obins:pi/Obins:pi]));
%%texton image
if(ndims(img) >2)
        im = uint8(imquantize(img,[256/3:256/3:256]))-1;
        CFinale = uint8(9*im(:,:,1)+ 3*im(:,:,2) + im(:,:,3));
    else
        CFinale = uint8(imquantize(img,[256/TGbins:256/TGbins:256]));
    end
    Textons = GenerateTextons('MTH');
    Textons2 = GenerateTextons('CMTH');
    CM = 0;
    [CM1,N1]= ImagePassTexton(CFinale,Textons(:,:,1));
    for i=2:length(Textons)
        [m, ~ ] = ImagePassTexton(CFinale,Textons(:,:,i));
        CM1(CM1==0) = m(CM1==0);

    end
    for i=2:length(Textons2)
        [~, n ] = ImagePassTexton(CFinale,Textons2(:,:,i));

        N1(N1==0) = n(N1==0)*i;
    end
    %CM = CM1;
    if(CM == 0) 
        CM = CM1;
    else
        CM(CM==0) = CM1(CM==0);
    end
    H = zeros(1,Obins+TCbins);
    glcm1 = 0;
    for i=1:Obins 
        P1 = CM .* uint8((O==i));
        glcm1 = glcm1+sum(graycomatrix(P1,'NumLevels',TCbins+1,'GrayLimits',[0 TCbins],'Offset',[0 1;-1 1;1 1;1 0]),3);
    end
    glcm1(1,:) = []; glcm1(:,1) = [];
    H(Obins+1:end) = diag(glcm1);
    glcm2 = 0;
    %find same orientation
   for i=1:TCbins
        P1 = O .* uint8((CM==i));
        glcm2 = glcm2+sum(graycomatrix(P1,'NumLevels',Obins+1,'GrayLimits',[0 Obins],'Offset',[0 1;-1 1;1 1;1 0]),3);
   end
   glcm2(1,:) = []; glcm2(:,1) = [];
   H(1:Obins) = diag(glcm2); 
   glcm3 = sum(graycomatrix(N1,'NumLevels',length(Textons2)+1,'GrayLimits',[0 length(Textons2)],'Offset',[0 1;-1 1;1 1;1 0]),3);
   glcm3(1,:) = []; glcm3(:,1) = []; 
   H = glcm1(:);
   H(TCbins*TCbins+1:TCbins*TCbins+Obins*Obins) = glcm2(:);
   H(TCbins*TCbins+Obins*Obins+1:TCbins*TCbins+Obins*Obins+length(Textons2)*length(Textons2)) = glcm3(:);
   H=reshape(H,[1,283]);
end

