function SimilarityMeasure=Manhathan_Distance(TrainingImage_Features,QueryImage_Feature)
[rows,~]=size(TrainingImage_Features);
distancematrix=zeros(rows,1);
% first remov target column from both matrix
% coralfeatures=coralfeatures(1:end,1:end-1);
% queryfeatures=queryfeatures(1:end,1:end-1);
Query_Img__Feature_val=QueryImage_Feature;
%distance formula sum(abs(Query-Coral)/1+Query+Coral)
for i=1:rows
   
Coral_Img__Feature_val=TrainingImage_Features(i,1:end);

    su=sum(abs(Query_Img__Feature_val-Coral_Img__Feature_val));

    distancematrix(i)=su;
end

SimilarityMeasure=distancematrix;
end