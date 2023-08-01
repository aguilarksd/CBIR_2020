function [] = Do_Traning(DB,N_Des)

for i=1:length(DB)
    for j=1:length(N_Des(:,1))
        sep='_';npar='';
        %nombre de los ajustes
        Par=N_Des{j,2};
        for k=1:length(Par)
            npar=strcat(npar,sep,num2str(Par{k}));
            sep='-';
        end
        Get_DB_D(DB{i},N_Des{j,1},N_Des{j,2},npar,N_Des{j,3})
    end
end

end

