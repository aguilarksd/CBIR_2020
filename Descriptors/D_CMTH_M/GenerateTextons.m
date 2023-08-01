function textons = GenerateTextons(featureName)
%GENERATETEXTONS Summary of this function goes here
%   Detailed explanation goes here
textons = zeros(2,2, 4);
if strcmp( featureName, 'TCM')
    textons (:,:,1) = [1 1;1 1];
    textons (:,:,2) = [1 1;1 0];
    textons (:,:,3) = [1 1;0 1];
    textons (:,:,4) = [1 0;1 1];
    textons (:,:,5) = [0 1;1 1];
elseif strcmp( featureName, 'MTH')
    %textons (:,:,6) = [0 0;1 1];
    textons (:,:,1) = [1 1;0 0];
    %textons (:,:,8) = [0 1;0 1];
    textons (:,:,2) = [1 0;1 0];
    textons (:,:,3) = [1 0;0 1];
    textons (:,:,4) = [0 1;1 0];
elseif(strcmp( featureName, 'CMTH') || strcmp( featureName, 'CTM'))
    textons (:,:,1) = [1 1;1 1];
    textons (:,:,2) = [1 1;1 0];
    textons (:,:,3) = [1 1;0 1];
    textons (:,:,4) = [1 0;1 1];
    textons (:,:,5) = [0 1;1 1]; 
    textons (:,:,6) = [0 0;1 1];
    textons (:,:,7) = [1 1;0 0];
    textons (:,:,8) = [0 1;0 1];
    textons (:,:,9) = [1 0;1 0];
    textons (:,:,10) = [1 0;0 1];
    textons (:,:,11) =[0 1;1 0];
    %
end
    
end


