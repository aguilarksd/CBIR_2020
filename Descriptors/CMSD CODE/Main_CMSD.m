  clear all;
%   corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\coraldataset\','IncludeSubfolders',1,'LabelSource','foldernames');
%   corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\Corel5k\','IncludeSubfolders',1,'LabelSource','foldernames');
  corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\Newcorel5k\','IncludeSubfolders',1,'LabelSource','foldernames');
%   corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\256_ObjectCategories\256_ObjectCategories\','IncludeSubfolders',1,'LabelSource','foldernames');
%   corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\GHIM10k_Resized\','IncludeSubfolders',1,'LabelSource','foldernames');
%     corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\corel1k\','IncludeSubfolders',1,'LabelSource','foldernames'); 
%   corelImageSet = imageDatastore('C:\Users\Ahmad\Documents\MATLAB\TextonTheory\Olivia_Dataset\','IncludeSubfolders',1,'LabelSource','foldernames');
  
Totalimageretrive=12;
percatagoryimage=100;
numel(corelImageSet.Files);
Numberofiterations=1;


%  
ts=load('corel5k_testingset_(12,20)_64.125.mat');
testingSet=ts.testingSet;

% ts=load('corel10k_testingset_1220_52.3583 .mat');
% testingSet=ts.testingSet;

% ts=load('corel1K_testingset__81.5000.mat'); % 80.54
% testingSet=ts.testingSet;

%  ts=load('corel1k_testingset_(12,20)_81.5417.mat');
%  testingSet=ts.testingSet;

% [testingSet,~] = splitEachLabel(corelImageSet, 0.02, 'randomized');
% testingSet=corelImageSet;
CSA=72;
% CSB=[6,12,18,24,30,36];
CSB=6;
CSC=10;
 
%  TrainingImage_Features=Training_Script_CMSD(corelImageSet,CSA,CSB,CSC);
% TrainingImage_Features=importdata('corel5k_training_features.mat');
TrainingImage_Features=importdata('cmsd_corek5k_training.mat');

%   TrainingImage_Features=Training_Script_CMSD(corelImageSet,CSA,CSB,CSC);
% TrainingImage_Features=importdata('corek10k_training.mat');
for or=1:Numberofiterations
    
    fprintf('...............Iteration# %d...............\n',or)
%          [testingSet,~] = splitEachLabel(corelImageSet, 0.2, 'randomized');
%     TrainingImage_Features=Training_Script_CMSD(corelImageSet);
%     TrainingImage_Features=Training_Script_CMSD(corelImageSet,CSA,CSB(or),CSC);
    
Totaltestingimages=numel(testingSet.Files);
for CurrentImage=1:Totaltestingimages
queryimage=readimage(testingSet,CurrentImage);

   QueryImage_Feature=Testing_Script_CMSD(queryimage,CSA,CSB,CSC);

% SimilarityMeasureMatrix=MTHSimilarityMeasure(TrainingImage_Features,QueryImage_Feature);
% SimilarityMeasureMatrix=Eucledian_Distance(TrainingImage_Features,QueryImage_Feature);
% SimilarityMeasureMatrix=Extented_Canbera_Distance_CDH(TrainingImage_Features,QueryImage_Feature);
% SimilarityMeasureMatrix=DISTFUN_SquareChord(TrainingImage_Features,QueryImage_Feature);
% SimilarityMeasureMatrix=histogram_intersection(TrainingImage_Features,QueryImage_Feature);

  SimilarityMeasureMatrix=Manhathan_Distance(TrainingImage_Features,QueryImage_Feature);
% for distance base 
[value,index] = sort(SimilarityMeasureMatrix,'ascend');
% for similarity base
%  [value,index] = sort(SimilarityMeasureMatrix,'descend');
querylabel=testingSet.Labels(CurrentImage);
relevantimage=0;
relevantimage_rank=zeros(1,Totalimageretrive(or));
f=0;
for c=1:Totalimageretrive(or)
traininglabel=corelImageSet.Labels(index(c));
if(querylabel==traininglabel)
relevantimage=relevantimage+1;
f=f+1;
relevantimage_rank(f)=c;
end
    
end
% K=min(4*relevantimage,12*2);
% final_rank=zeros(1,length(relevantimage_rank));
% for u=1:length(relevantimage_rank);
% if (relevantimage_rank(u)>K)
%     final_rank(u)=1.25*K;
% % final_rank(u)=K+1;
% else
%      final_rank(u)=relevantimage_rank(u);
% end
% end
%     AVR=sum(final_rank)/relevantimage;
% %     MRR=AVR - .5*(1+relevantimage);
% MRR=AVR - .5-(relevantimage/2);
% %     NMRR(CurrentImage)=MRR/(1.25*K-.5*(1+relevantimage));
%  NMRR(CurrentImage)=MRR/(K+0.5-0.5*(relevantimage));

% 
% loc_sorted=find(relevantimage_id>0);
% cur_prec(CurrentImage,1:relevantimage)=(1:relevantimage)./loc_sorted;
% cur_recall(CurrentImage,1:relevantimage)=(1:relevantimage)./relevantimage;
% 
% relevant_image_count(CurrentImage)=relevantimage;

precision(CurrentImage)=relevantimage/Totalimageretrive(or);
recall(CurrentImage)=relevantimage/percatagoryimage;

end
% pre_AP=sum(cur_prec,2)./relevant_image_count';
% mp=mean(pre_AP);
% fprintf('mean Precision is: %d\n',mp);
% 
avgprecision=sum(precision)/numel(precision);
fprintf('Average Precision is: %d\n',avgprecision);
avgrecall=sum(recall)/numel(recall);
fprintf('Average Recall is: %d\n',avgrecall);
% ANMRR=mean(NMRR);
% fprintf('ANMRR Value is: %d\n',ANMRR);
% cur_prec_mean=mean(cur_prec);
% cur_recall_mean=mean(cur_recall);

% [a_precision,indexx]=sort(precision,'descend');
% % a_recall=recall(indexx);
% a_recall=sort(recall,'ascend');
%  rv=max(a_recall*100);
% % rv=max(cur_recall_mean);
% plot(a_recall*100,a_precision*100,'b.-');
% xlabel('Recall');
% ylabel('Precision');
% title('Precison Recall Graph');
% axis([0 rv 0 100]);
% grid;
% rv=max(cur_recall_mean);
% plot(cur_recall_mean(1,1:10),cur_prec_mean(1,1:10),'b.-');
% xlabel('Recall');
% ylabel('Precision');
% title('Precison Recall Graph');
% axis([0 rv 0 1]);
% grid;
Iterationprecision(or)=avgprecision;
IterationRecall(or)=avgrecall;


end
% end
% fprintf('Average Precision is: %d\n',(sum(Iterationprecision)/Numberofiterations));
% fprintf('Average Recall is: %d\n',(sum(IterationRecall)/Numberofiterations));