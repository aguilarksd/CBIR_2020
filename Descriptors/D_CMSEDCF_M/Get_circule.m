function [n,m] = Get_circule(n,p,m)
%get in circule te cordinated
if n < 3 && p < 3
                
    n=n+1;
            
elseif m < 3 
                
    m=m+1;
            
elseif p < 7
                
    n=n-1;
            
else
                            
    m=m-1;
            
end
end