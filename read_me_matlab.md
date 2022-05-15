Please download the folder first and run in a 'GPU enabled MATLAB setup'

For the prediction folder the folder should include all the .wav files
-Prediction_data_dir
    -.wav(files)

####################################################################################
For prediction only
%% If custom trained please use 'weight_name.mat' instead of 'imbalenced_2k_yam.mat' in prediction_yamnet
1. Please run "main_pred.m"
2. Change the name of the prediction folder according to folder name(including root path name) to be predicted in 'pred_folder_name' variable
3. Change the name of csv file accordingly in the 'pred_file_name' variable

######################################################
For training from scratch
%% If custom trained please use 'weight_name.mat' instead of 'imbalenced_2k_yam.mat' in prediction_yamnet
1. Please run "main_train.m"
2. Change the name of the prediction folder according to folder name(including root path name) to be predicted in 'pred_folder_name' variable
3. Change the name of csv file accordingly in the 'pred_file_name' variable




