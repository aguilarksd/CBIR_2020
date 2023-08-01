DB='Caltech-101';
Nr=12;%imagenes recuperadas
val=10;%num de imagenes de prueba por clase

%cargar los dataset ya entrenados
load(strcat('DbCMSD-',DB,'.mat'));load(strcat('DbCMSD-',DB,'-List.mat'));

Ti=readtable(strcat('C:\Users\aguil\OneDrive\Imágenes\DataSet_CBIR\',DB,'\Info_Data.xlsx'));
nclas=Ti.Classes;%numero de clases
Nq=val*nclas;
Ni=Class_List(nclas+1);

%Valores para metricas 
K=Nr;%imagenes recuperadas
Rq=Class_List(1:nclas);%imagenes por clase
Q=0;%cosutas incio en 0

%Matriz para guardar los resultados de recuperación
DRCMSD=zeros(Nq,Nr);
DRCMSDC=zeros(Nq,Nr);DRCMSDO=zeros(Nq,Nr);DRCMSDL=zeros(Nq,Nr);
Rand_List=zeros(Nq,val);Rclass_List=zeros(nclas,2);

ci=1;cf=0;count=0;
%Inicio de consultas automaticas
disp(strcat('Procesando: ',DB));
disp(strcat('Imagenes recuperadas: ',num2str(Nr)));
disp(strcat('Consultas por clase: ',num2str(val)));
for i=1:nclas
    cf=cf+Rq(i);
    if val>Rq(i)   
        warning(['La clase: ' num2str(i) '---No cuenta con imagenes suficientes: ' num2str(Class_List(i))...
            '/' num2str(val)])
    else
        count=count+1;
        Rclass_List(count,:)=[i, Rq(i)];
        r = randi([ci cf],1,val);
        Rand_List(i,:)=r;
        for j=1:val
            Q=Q+1;
            numi=r(j);
            cmsd=DbCMSD(numi,:);
            Dcmsd=zeros(Ni,1);
            DcmsdC=zeros(Ni,1);DcmsdO=zeros(Ni,1);DcmsdL=zeros(Ni,1);
            for k=1:Ni
                Dcmsd(k)=sum(abs(DbCMSD(k,:)-cmsd));
                DcmsdC(k)=sum(abs(DbCMSD(k,1:72)-cmsd(1:72)));
                DcmsdO(k)=sum(abs(DbCMSD(k,73:78)-cmsd(73:78)));
                DcmsdL(k)=sum(abs(DbCMSD(k,79:88)-cmsd(79:88)));
            end
            [dif,ind]=sort(Dcmsd);
            DRCMSD(Q,:)=GetBinRet(Nr,ind,ci,cf,1);
            [difc,indc]=sort(DcmsdC);
            DRCMSDC(Q,:)=GetBinRet(Nr,indc,ci,cf,1);
            [difo,indo]=sort(DcmsdO);
            DRCMSDO(Q,:)=GetBinRet(Nr,indo,ci,cf,1);
            [difl,indl]=sort(DcmsdL);
            DRCMSDL(Q,:)=GetBinRet(Nr,indl,ci,cf,1); 
        end
    end
    ci=cf;
    disp(strcat(num2str((i/nclas)*100),'%'));
end

Res=zeros(4,nclas);ResC=zeros(4,nclas);ResO=zeros(4,nclas);ResL=zeros(4,nclas);
x=1;y=val;z=1;
mxrq=max(Rclass_List(:,2));
for n=1:nclas
    if n == Rclass_List(z,1)
        Res(:,n)=GetMetrics(DRCMSD(x:y,:),val,K,Rq(n),mxrq);
        ResC(:,n)=GetMetrics(DRCMSDC(x:y,:),val,K,Rq(n),mxrq);
        ResO(:,n)=GetMetrics(DRCMSDO(x:y,:),val,K,Rq(n),mxrq);
        ResL(:,n)=GetMetrics(DRCMSDL(x:y,:),val,K,Rq(n),mxrq);
        x=x+val; y=y+val;z=z+1;
    end     
end
ResT=sum(Res,2)/z;ResTC=sum(ResC,2)/z;ResTO=sum(ResO,2)/z;ResTL=sum(ResL,2)/z;

disp('-----SAVING DATA------');
Metrics=["P","R","MAP","ANMRR"];Encx=Rclass_List(:,1);
GetExcel(Res,Encx,Metrics,strcat('Res_Clase_CMSD_',DB))
GetExcel(ResC,Encx,Metrics,strcat('Res_Clase_CMSD_HC_',DB))
GetExcel(ResO,Encx,Metrics,strcat('Res_Clase_CMSD_HO_',DB))
GetExcel(ResL,Encx,Metrics,strcat('Res_Clase_CMSD_HL_',DB))

GetExcel(ResT,"CMSD",Metrics,strcat('Res_CMSD_',DB))
GetExcel(ResTC,"CMSD",Metrics,strcat('Res_CMSD_HC_',DB))
GetExcel(ResTO,"CMSD",Metrics,strcat('Res_CMSD_HO_',DB))
GetExcel(ResTL,"CMSD",Metrics,strcat('Res_CMSD_HL_',DB))

save(strcat('DRCMSD-',DB,'.mat'),'DRCMSD');
save(strcat('DRCMSDC-',DB,'.mat'),'DRCMSDC');
save(strcat('DRCMSDO-',DB,'.mat'),'DRCMSDO');
save(strcat('DRCMSDL-',DB,'.mat'),'DRCMSDL');

save(strcat('DRCMSD-',DB,'-RL.mat'),'Rand_List');save(strcat('DRCMSD-',DB,'-RCL.mat'),'Rclass_List');
disp('¡ Done !');