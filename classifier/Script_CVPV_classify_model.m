%% use the training data in CV and PV folders to create a classification model
% folder locations for training
imds = imageDatastore({'CV','PV'},'LabelSource','foldernames');
numTrainFiles = 14;  % spilt into train and validate
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomized');

inputSize = [12 12 3]; % image dim
numClasses = 2; % two classes: CV and PV 

layers = [
    imageInputLayer(inputSize)
    convolution2dLayer(3,20)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'MaxEpochs',10, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

md_net = trainNetwork(imdsTrain,layers,options); %trained model

YPred = classify(md_net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation);
save('md_net.mat','md_net');%  save model


%%  load some vein image data and test
load veins_train.mat
%model prediction and evalutation, save in test folders
II=II3;
if isfolder('test_CV')
    rmdir('test_CV','s')
end
if isfolder('test_PV')
    rmdir('test_PV','s')
end
if isfolder('test_UN')
    rmdir('test_UN','s')
end
mkdir('test_CV');
mkdir('test_PV');
mkdir('test_UN');




for i=1:10
   for j=1:10    
    img=II((i-1)*12+1:i*12,(j-1)*12+1:j*12,:);
    [ytest(i,j),scores]=classify(md_net,im2uint8(img)); % img needs to be uint8
    if scores(1)>0.65
     fn=fullfile('test_CV',['img4_',num2str(i-1),'-',num2str(j-1),'.png']);
    elseif scores(1)<0.35
     fn=fullfile('test_PV',['img4_',num2str(i-1),'-',num2str(j-1),'.png']); 
    else
     fn=fullfile('test_UN',['img4_',num2str(i-1),'-',num2str(j-1),'.png']);
    end
    imwrite(img,fn);
   end
end

