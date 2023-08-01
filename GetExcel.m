function [] = GetExcel(Res,Encx,Ency,name)

[y,x] = size(Res);
if double(Encx) == 0.0
    Encx=(1:x);
end
if double(Ency) == 0.0
    Ency=(1:y);
end
RT=cell(y+1,x+1);
for n=1:y+1
    for m=1:x+1
        if n==1 && m==1
            RT(n,m)={' '};
        elseif n==1
            RT(n,m)={num2str(Encx(m-1))};
        elseif m==1
            RT(n,m)={num2str(Ency(n-1))};
        else
            RT(n,m)={num2str(Res(n-1,m-1))};
        end
    end
end
%filename=strcat(name,'.CSV');
%xlswrite(filename,RT)
filename=strcat(name,'.xlsx');
writecell(RT,filename)

end

