DB='Corel-5k';
Ni=5000;

Dir=[1 10 12 13 17 20 21 22 33 34 
    41 46 100 101 102 103 104 108 109 113
    118 119 120 121 122 130 131 140 142 143 
    144 147 148 152 153 161 163 171 173 174
    182 183 187 189 201 231 276 296 335 384];
Dir=Dir*1000;

DbCMSD=zeros(Ni,88);

num=0;
clas=1;
Dirs=string(Dir(clas));
for i=1:Ni
    
    if num > 99
        clas=clas+1;
        Dirs=string(Dir(clas));
        num=0;
    end
    
    Nimg=Dir(clas)+num;
    img=imread(strcat('C:\Users\aguil\source\repos\Matlab\CBIR_2_M\',DB,'\',Dirs,'\',sprintf('%d.jpeg',Nimg)));
    
    %img=imread(strcat('C:\Users\aguil\source\repos\Matlab\CBIR_2_M\',DB,'\',sprintf('%d.jpg',i-1)));
    
    cmsd=Get_CMSD(img,72,6,10);
    DbCMSD(i,:)=cmsd;
    
    num=num+1;
    disp(strcat('Procentaje = ', num2str(i/50),'%'));
    %disp(strcat('Procentaje = ', num2str(i/10),'%'));
end

save('DbCMSD-5k.mat','DbCMSD');