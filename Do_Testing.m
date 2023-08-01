function [] = Do_Testing(DB,N_Des,Met,qi)

for i=1:length(DB)
    if qi==0
        ql=0;
    else 
        ql=1;
    end
    for j=1:length(N_Des(:,1))
        for k=1:length(Met)
            sep='_';npar='';
            %nombre de los ajustes
            Par=N_Des{j,2};
            for l=1:length(Par)
                npar=strcat(npar,sep,num2str(Par{l}));
                sep='-';
            end
            Get_Ev_D(DB{i},N_Des{j,1},npar,Met{k},N_Des{j,4},ql)
            if ql==0
                ql=1;
            end
        end        
    end
end

end

