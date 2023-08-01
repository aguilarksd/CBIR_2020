Ni=1000;%imagenes en el dataset
Nr=12;%imagenes recuperadas
Nq=100;%num de consultas
numi=1;%nombre de la imagen 1
nclas=10;%numero de clases
val=10;%num de imagenes de prueba por clase
%{
Dir=[1 10 12 13 17 20 21 22 33 34 
    41 46 100 101 102 103 104 108 109 113
    118 119 120 121 122 130 131 140 142 143 
    144 147 148 152 153 161 163 171 173 174
    182 183 187 189 201 231 276 296 335 384];
Dir=Dir*1000;
%}
%Valores para metricas 
K=Nr;%imagenes recuperadas
Q=Nq;%Num de consultas
Rq=100;%imagenes por clase
Kq=2*Rq;%Valor para ANMRR

%cargar los dataset ya entrenados
load('DbCMSD-1k.mat');

%Matriz para guardar los resultados de recuperación
DRCMSD=zeros(Nq,Nr);

class=1;timg=0;
%Inicio de consultas automaticas
for n=1:Nq
    if n > val
        numi=numi+90;
        val=val+10;
        class=class+1;
        timg=0;
    end
    %Nimg=Dir(class)+timg;
    %I=imread(strcat('C:\Users\aguil\source\repos\Matlab\CBIR_2_M\Query-5k\',sprintf('%d.jpeg',Nimg)));
    I=imread(strcat('C:\Users\aguil\source\repos\Matlab\CBIR_2_M\Query\',sprintf('%d.jpg',numi)));
    
    cmsd=Get_CMSD(I,72,6,10);Dcmsd=zeros(Ni,1);
    
    for i=1:Ni
        
        Dcmsd(i)=sum(abs(DbCMSD(i,:)-cmsd));

    end
    
    [difcmsd,indcmsd]=sort(Dcmsd);
    DRCMSD(n,:)=GetBinRet(Nr,indcmsd,Rq,numi);
    
    numi=numi+1;
    %timg=timg+1;
    %disp(strcat('Procentaje = ', num2str(n/5),'%'));
    disp(strcat('Procentaje = ', num2str(n),'%'));
end
ResC=zeros(4,nclas);

x=1;y=10;
for n=1:nclas
    ResC(:,n)=GetMetrics(DRCMSD(x:y,:),10,K,Rq,Kq);
    x=x+10; y=y+10;
end
Metrics=["P","R","MAP","ANMRR"];Encx="CMSD";
GetExcel(ResC,0,Metrics,'Res_Clase_CMSD_1k')


Res=zeros(4,1);

Res(:,1)=GetMetrics(DRCMSD,Q,K,Rq,Kq);
GetExcel(Res,Encx,Metrics,'Res_CMSD_1k')