function yamnet_train(root_train)
downloadFolder = fullfile(tempdir,'YAMNetDownload');
loc = websave(downloadFolder,'https://ssd.mathworks.com/supportfiles/audio/yamnet.zip');
YAMNetLocation = tempdir;
unzip(loc,YAMNetLocation)
addpath(fullfile(YAMNetLocation,'yamnet'));


%% 
downloadFolder = root_train;
ads = audioDatastore(downloadFolder,'IncludeSubfolders',true,'LabelSource','foldernames');
[adsTrain,adsValidation] = splitEachLabel(ads,0.8,0.2);

[x,fileInfo] = read(adsTrain);
fs = fileInfo.SampleRate;

reset(adsTrain);

% sound(x,fs)

figure;
t = (0:size(x,1)-1)/fs;
plot(t,x);
xlabel('Time (s)');
title('State = ' + string(fileInfo.Label));
axis tight;


%%

emptyLabelVector = adsTrain.Labels;
emptyLabelVector(:) = [];

trainFeatures = [];
trainLabels = emptyLabelVector;
while hasdata(adsTrain)
    [audioIn,fileInfo] = read(adsTrain);
    if length(audioIn)/16000<1
        pad_size = round((1-length(audioIn)/16000)*16000); %Number of zeros to pad
        audioIn = padarray(audioIn, pad_size, 0, 'both');
        display(length(audioIn)/16000);
    end
    features = yamnetPreprocess(audioIn,fileInfo.SampleRate);
    numSpectrums = size(features,4);
    trainFeatures = cat(4,trainFeatures,features);
    trainLabels = cat(2,trainLabels,repmat(fileInfo.Label,1,numSpectrums));
end

%%

validationFeatures = [];
validationLabels = emptyLabelVector;
while hasdata(adsValidation)
    [audioIn,fileInfo] = read(adsValidation);
    if length(audioIn)/16000<1
        pad_size = round((1-length(audioIn)/16000)*16000); %Number of zeros to pad
        audioIn = padarray(audioIn, pad_size, 0, 'both');
        display(length(audioIn)/16000);
    end
    features = yamnetPreprocess(audioIn,fileInfo.SampleRate);
    numSpectrums = size(features,4);
    validationFeatures = cat(4,validationFeatures,features);
    validationLabels = cat(2,validationLabels,repmat(fileInfo.Label,1,numSpectrums));
end

%%
s = load('yamnet_21_april.mat');
net = s.dataSet;


uniqueLabels = unique(adsTrain.Labels);
numLabels = numel(uniqueLabels);

lgraph = layerGraph(net.Layers);

% newDenseLayer = fullyConnectedLayer(numLabels,"Name","dense");
% lgraph = replaceLayer(lgraph,"dense",newDenseLayer);
% 
% newClassificationLayer = classificationLayer("Name","Sounds","Classes",uniqueLabels);
% lgraph = replaceLayer(lgraph,"Sound",newClassificationLayer);


%%

miniBatchSize = 128;
validationFrequency = floor(numel(trainLabels)/miniBatchSize);
options = trainingOptions('adam', ...
    'InitialLearnRate',3e-4, ...
    'MaxEpochs',30, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false, ...
    'ValidationData',{single(validationFeatures),validationLabels}, ...
    'ValidationFrequency',validationFrequency, ...
    'OutputNetwork','best-validation-loss');

%%

dataSet = trainNetwork(trainFeatures,trainLabels,lgraph,options);
save yamnet_5_may dataSet
end
