function  micro=microstructuredetection_A(ori,ImageX,ImageV,rows,columns)
        
%             ColorA = zeros(rows, columns);
%             ColorB  = zeros(rows, columns);
%             ColorC =  zeros(rows, columns);
%             ColorD  = zeros(rows, columns);
ColorA=structure_map(ori,ImageX,ImageV,rows,columns,0,0);
ColorB=structure_map(ori,ImageX,ImageV,rows,columns,0,1);
ColorC=structure_map(ori,ImageX,ImageV,rows,columns,1,0);
ColorD=structure_map(ori,ImageX,ImageV,rows,columns,1,1);
            

%             //=========the final micro-structure map===============
            micro = zeros(rows, columns);

          for i = 1:rows
              for j = 1:columns

                    micro(i, j) = max(ColorA(i, j), max(ColorB(i, j), max(ColorC(i, j), ColorD(i, j))));
              end
          end
end