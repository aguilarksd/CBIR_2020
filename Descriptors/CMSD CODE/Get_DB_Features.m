DB='Caltech-101';

Ti=readtable(strcat('C:\Users\aguil\OneDrive\Imágenes\DataSet_CBIR\',DB,'\Info_Data.xlsx'));
Nc=Ti.Classes;Total=Ti.Images;
Tc=readtable(strcat('C:\Users\aguil\OneDrive\Imágenes\DataSet_CBIR\',DB,'\Class_list.xlsx'));

DbCMSD=zeros(Total,88);
DbCMSD_Dir=string(zeros(Total,1));
Class_List=zeros(Nc+1,1);
cont=0;
n=0;
for i=1:Nc
    Ni=Tc.Number(i);
    for j=1:Ni
        Dir=Get_Directory(Ti,Tc,i,j);
        img=imread(strcat('C:\Users\aguil\OneDrive\Imágenes\DataSet_CBIR\',DB,'\',Dir));
        [X,Y,Z]=size(img);
        if Z ==3
            cmsd=Get_CMSD(img,72,6,10);
            n=n+1;
            DbCMSD(n,:)=cmsd;
            DbCMSD_Dir(n)=Dir;
            Class_List(i)=Class_List(i)+1;
        end
        cont=cont+1;
        disp(strcat(num2str((cont/Total)*100),'%'));
    end
end
Class_List(Nc+1)=n;
disp(strcat('Procesadas:',num2str(n),'/',num2str(Total)));
save(strcat('DbCMSD-',DB,'.mat'),'DbCMSD');
save(strcat('DbCMSD-',DB,'-Dir.mat'),'DbCMSD_Dir');
save(strcat('DbCMSD-',DB,'-List.mat'),'Class_List');
