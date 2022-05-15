%%
function prediction_yamnet(weight_file_name, downloadFolder, pred_file_name) 
%%
downloadF = fullfile(tempdir,'YAMNetDownload');
loc = websave(downloadF,'https://ssd.mathworks.com/supportfiles/audio/yamnet.zip');
YAMNetLocation = tempdir;
unzip(loc,YAMNetLocation);
addpath(fullfile(YAMNetLocation,'yamnet'));
%%
uniqueLabels = [0, 1, 2, 3, 4, 5];
%%
s = load(weight_file_name);
dlnet = s.dataSet;
% classes = s.OutputNames;

%%
ads = audioDatastore(downloadFolder,'IncludeSubfolders',true,'LabelSource','foldernames');

%%
predictions = [];
file_name = [];
while hasdata(ads)
    [audioIn,fileInfo] = read(ads);
    if length(audioIn)/16000<1
        pad_size = round((1-length(audioIn)/16000)*16000); %Number of zeros to pad
        audioIn = padarray(audioIn, pad_size, 0, 'both');
        display(length(audioIn)/16000);
    end
    features = yamnetPreprocess(audioIn,fileInfo.SampleRate);
    numSpectrums = size(features,4);
    Features = cat(4,features,features);
    dlYPred = predict(dlnet,Features);
    [file_path, file_name_new, ext] = fileparts(fileInfo.FileName);
    display(file_name_new);
    file_name = [cellstr(strcat(file_name_new, ext)); file_name];
    dlYPred = mean(dlYPred,1);
    % Determine corresponding classes.
    predictions = [dlYPred; predictions];
end
[arg_value, arg_max] = max(predictions');
arg_max = arg_max - 1;
file_pred = [cellstr(file_name) num2cell(arg_max')];
writecell(file_pred, pred_file_name, 'WriteMode', 'overwrite');
% save(sprintf('%s', pred_file_list), 'file_name');
% save(sprintf('%s', pred_list), 'predictions');
end
