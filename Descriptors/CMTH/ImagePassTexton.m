function [PassedImage, Neighborhood,NeighborhoodColors] = ImagePassTexton(img, texton)
%IMAGEPASSTEXTON Summary of this function goes here
%   Detailed explanation goes here

%img =  uint8(imquantize(img,255/quantization:255/quantization:255));
%B = logical(repmat(texton,length(img)/2));
%CompB = ~B;

%outImageB = img .* uint8(B);
%outImageCompB = img .* uint8(CompB);

L = uint8(repmat([1 0;0 0],length(img)/2));
Indices = L==1;
k = 1;

    [r1 c1]  = find(texton);
    [r0 c0] = find(~logical(texton));
    
    %find texton elements
    xShift = r1(1);
    yShift = c1(1);
    Y1 = circshift(img,[(xShift-1)*-1 (yShift-1)*-1]);
    %colors
     NeighborhoodColors = Y1 .* L;
     NeighborhoodColors = NeighborhoodColors(Indices);
     NeighborhoodColors= reshape(NeighborhoodColors,[sqrt(length(NeighborhoodColors)) sqrt(length(NeighborhoodColors))]);
    %
    Neighborhood = uint8(zeros(size(img,1)/2, size(img,2)/2, length(r1))); 
    for i=2:length(r1)
            xShift = r1(i);
            yShift = c1(i);
            Y2 = circshift(img,[(xShift-1)*-1 (yShift-1)*-1]);
            Y2 = imabsdiff(Y1 , Y2);
            Y2 = Y2 .* L;
            
            Y2 = Y2(Indices);
            N= reshape(Y2,[sqrt(length(Y2)) sqrt(length(Y2))]);
            Neighborhood(:,:,k) = N;
            k = k+1;
    end;
    %find no texton elements
    for i=1:length(r0)
            xShift = r0(i);
            yShift = c0(i);
            Y2 = circshift(img,[(xShift-1)*-1 (yShift-1)*-1]);
            Y2 = imabsdiff(Y1 , Y2);
            Y2 = Y2 .* L;
            Indices = L==1;
            Y2 = Y2(Indices);
            N= reshape(Y2,[sqrt(length(Y2)) sqrt(length(Y2))]);

            ind = N == 0;
            N(ind) = 4;
            N(~ind) = 0;
            Neighborhood(:,:,k) = N;
            k = k+1;
    end;
    %%
  %decide if texton matchs
    Result = Neighborhood(:,:,1);
    for i=2:size(Neighborhood, 3)
        Result = Result + Neighborhood(:,:,i);
    end;
    Neighborhood = Result;
    ind = Neighborhood == 0;
    Neighborhood(ind) = 1;
    Neighborhood(~ind) = 0;
    %regenrate the texton image
    PassedImage = repelem(Neighborhood,2,2).* img;
    %t = MyRepElem(Neighborhood,2,2).* img;
    t = repelem(Neighborhood,2,2) .* img;
end

