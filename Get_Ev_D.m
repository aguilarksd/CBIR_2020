function [] = Get_Ev_D(DB,DesN,npar,Dm,Mv,vrl)%Dataset,Descriptor,Distance mesure,Values of mesure,0 if dont have queri list or 1 otherwise

Nr=12;%imagenes recuperadas
val=10;%num de imagenes de prueba por clase
Cv=Mv(1);
Ov=Mv(2);
if length(Mv)== 3
    Lv=Mv(3);
end

Dir1='Metrics/';
addpath(Dir1,'-end');


%cargar los dataset ya entrenados
load(strcat('Experiments/DataBase/',DB,'/Db_',DesN,npar,'.mat'));
load(strcat('Experiments/DataBase/',DB,'/Db_',DesN,npar,'_Class.mat'));

Class=unique(Db_C(:,1));
nclas=length(Class);%numero de clases
Nq=val*nclas;
Ni=length(Db_D);

%Valores para metricas 
K=Nr;%imagenes recuperadas
Rq=zeros(nclas,1);
for i=1:length(Class)
    Rq(i)=length( find(Db_C==Class(i)));%imagenes por clase
end
Q=0;%cosutas incio en 0

%Matriz para guardar los resultados de recuperación
DR=zeros(Nq,Nr);
Rclass_List=zeros(nclas,2);

ci=1;cf=0;count=0;

if vrl == 1
    %----En caso de tener lista de consultas-----%
    load(strcat('Experiments/DataBase/',DB,'/Results/',DB,'-RL.mat'));
else
    Rand_List=zeros(Nq,val);
end

%Inicio de consultas automaticas
disp(strcat('-Processing: ',DB));
disp(strcat('-Whit:',' ',DesN));
disp(strcat('-Retrieved images: ',num2str(Nr)));
disp(strcat('-Queries: ',num2str(val)));

for i=1:nclas
    cf=cf+Rq(i);
    if val>Rq(i)   
        warning(['La clase: ' num2str(i) '---No cuenta con imagenes suficientes: ' num2str(Class_List(i))...
            '/' num2str(val)])
    else
        count=count+1;
        Rclass_List(count,:)=[i, Rq(i)];
        if vrl == 0
            r = randi([ci cf],1,val);% En caso de ser aleatorio
            Rand_List(i,:)=r;
        end
        for j=1:val
            Q=Q+1;
            numi=Rand_List(i,j);
            des=Db_D(numi,:);
            Dif=zeros(Ni,1);
            for k=1:Ni
                if strcmp(Dm,'M')
                    Dif(k)=sum(abs(Db_D(k,:)-des));
                end 
                if strcmp(Dm,'E')
                    Dif(k)=sqrt(sum((Db_D(k,:)-des).^2));
                end
                if strcmp(Dm,'S')
                    Dif(k)=sum(abs(Db_D(k,:)-des)/(1+(Db_D(k,:)+des)));                  
                end 
                if strcmp(Dm,'M2')
                    Dc=sum(abs(Db_D(k,1:Cv)-des(1:Cv)));
                    Do=sum(abs(Db_D(k,Cv+1:Cv+Ov)-des(Cv+1:Cv+Ov)));
                    Dif(k)=sum((Dc/Cv)+(Do/Ov));                  
                end 
                if strcmp(Dm,'M3')
                    Dc=sum(abs(Db_D(k,1:Cv)-des(1:Cv)));
                    Do=sum(abs(Db_D(k,Cv+1:Cv+Ov)-des(Cv+1:Cv+Ov)));
                    Dl=sum(abs(Db_D(k,Cv+Ov+1:Cv+Ov+Lv)-des(Cv+Ov+1:Cv+Ov+Lv)));
                    Dif(k)=sum((Dc/Cv)+(Do/Ov)+(Dl/Lv));                  
                end
            end
            [dif,ind]=sort(Dif);
            DR(Q,:)=GetBinRet(Nr,ind,ci,cf,1);
        end
    end
    ci=cf;
    %disp(strcat(num2str((i/nclas)*100),'%'));
end

Res=zeros(4,nclas);
x=1;y=val;z=1;
mxrq=max(Rclass_List(:,2));
for n=1:nclas
    if n == Rclass_List(z,1)
        Res(:,n)=GetMetrics(DR(x:y,:),val,K,Rq(n),mxrq);
        x=x+val; y=y+val;z=z+1;
    end     
end
z=z-1;
ResT=sum(Res,2)/z;

disp('----------SAVING DATA-----------');
vdir= exist(strcat('Experiments/Results/',DB),'dir');
if vdir == 0
    mkdir(strcat('Experiments/Results/',DB));
end
Metrics=["P","R","MAP","ANMRR"];Encx=Rclass_List(:,1);

GetExcel(Res,Encx,Metrics,strcat('Experiments/Results/',DB,'/Res_',DesN,npar,'_',Dm,'_Class_',DB))
GetExcel(ResT,string(DesN),Metrics,strcat('Experiments/Results/',DB,'/Res_',DesN,npar,'_',Dm,'_',DB))


vdir= exist(strcat('Experiments/DataBase/',DB,'/Results'),'dir');
if vdir == 0
    mkdir(strcat('Experiments/DataBase/',DB,'/Results'));
end

save(strcat('Experiments/DataBase/',DB,'/Results','/DR_',DesN,npar,'_',Dm,'-',DB,'.mat'),'DR');
if vrl == 0
    save(strcat('Experiments/DataBase/',DB,'/Results/',DB,'-RL.mat'),'Rand_List');
end

disp('------------¡ DONE !------------');

rmpath(Dir1);

end

