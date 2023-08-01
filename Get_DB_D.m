function [] = Get_DB_D(DB,DesN,Par,npar,Lng)

Dir1=strcat('Descriptors/D_',DesN,'_M');
addpath(Dir1,'-end');

Dir2=strcat('DataSets/',DB);
DataSet = imageDatastore(Dir2,'IncludeSubfolders',true,'LabelSource','foldernames');

disp(strcat('***Geting: ',DB));
disp(strcat('***whit: ',DesN));


[T,~]=size(DataSet.Files);
Db_Des=zeros(T,Lng);
Db_Class=string(zeros(T,2));
n=0;
for i=1:T
    img=imread(DataSet.Files{i});
    [~,~,Z]=size(img);
    if Z ==3
        if strcmp(DesN,'CMSD')
            Des=GetCMSD(img,8,3,3,6,10);
        end
        if strcmp(DesN,'PCMSED')
            Des=GetPCMSED(img,8,3,3,6,10,Par);
        end
        if strcmp(DesN,'PCMSED1')
            Des=GetPCMSED1(img,8,3,3,6,10,4);
        end
        if strcmp(DesN,'PCMSED2')
            Des=GetPCMSED2(img,8,3,3,6,10,Par);
        end
        if strcmp(DesN,'PCMSEDp')
            Des=GetPCMSEDp(img,8,3,3,6,10,4,Par);
        end
        if strcmp(DesN,'CMSED')
            Des=GetCMSED(img,8,3,3,6,10,Par);
        end
        if strcmp(DesN,'PCMSD')
            Des=GetPCMSD(img,8,3,3,6,10,4);
        end
        if strcmp(DesN,'PCMSD1')
            Des=GetPCMSD1(img,8,3,3,6,10,Par);
        end
        if strcmp(DesN,'PCMSD2')
            Des=GetPCMSD2(img,8,3,3,6,10,4);
        end
        if strcmp(DesN,'MIFH')
            Des=GetMIFH(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'SED')
            Des=GetSED(img);
        end
        if strcmp(DesN,'MSD')
            Des=GetMSD(img); 
        end 
        if strcmp(DesN,'CMTH')
            Des=GetCMTH(img); 
        end
        if strcmp(DesN,'CLD')
            Des=GetMpegCLD(img); 
        end
        if strcmp(DesN,'EHD')
            Des=GetMpegEHD(img); 
        end
        %MIFH Variants
        if strcmp(DesN,'MIFH-1')
            Des=GetMIFH1(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-2')
            Des=GetMIFH2(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-3')
            Des=GetMIFH3(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-4')
            Des=GetMIFH4(img,6,3,3,16,'Avg',0,1); 
        end
        %mix two best 
        if strcmp(DesN,'MIFH-2-1')
            Des=GetMIFH21(img,6,3,3,16,'Avg',0,1); 
        end
        %news
        if strcmp(DesN,'MIFH-C')
            Des=GetMIFH_C(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-1C')
            Des=GetMIFH_1C(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-2C')
            Des=GetMIFH2C(img,6,3,3,16,'Avg',0,1); 
        end
        if strcmp(DesN,'MIFH-2-1C')
            Des=GetMIFH21C(img,6,3,3,16,'Avg',0,1); 
        end       
        
        n=n+1;          
        Db_Des(n,:)=Des;
        Db_Class(n,1)=DataSet.Labels(i);
        Db_Class(n,2)=DataSet.Files{i}; 
    %else
        %warning(['Impossible to process Image:' DataSet.Files{i}])
    end
    %disp(strcat(num2str(uint8((i/T)*100)),'%'));
end
Db_D=Db_Des(1:n,:);
Db_C=Db_Class(1:n,:);
disp(strcat('Procesadas:',num2str(n),'/',num2str(T)));

disp('----------SAVING DATA-----------');
vdir= exist(strcat('Experiments/DataBase/',DB),'dir');
if vdir == 0
    mkdir(strcat('Experiments/DataBase/',DB));
end
save(strcat('Experiments/DataBase/',DB,'/Db_',DesN,npar,'.mat'),'Db_D');
save(strcat('Experiments/DataBase/',DB,'/Db_',DesN,npar,'_Class.mat'),'Db_C');
disp('------------¡ DONE !------------');
rmpath(Dir1);
end

