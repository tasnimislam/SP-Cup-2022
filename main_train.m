clc;
clear all;
close all;

%%train
yamnet_train('./semisup_ds/semisup_ds/labeled');
% %% If custom trained please use 'weight_name.mat' instead of 'imbalenced_2k_yam.mat' in prediction_yamnet
% %Change the path name here
% %Part 1
% pred_folder_name = "./spcup_2022_eval_part1" %Change root directory here
% pred_file_name = 'part_1_predictions.csv'; %change filename here
% prediction_yamnet('imbalenced_2k_yam.mat', pred_folder_name, pred_file_name) ;
% 
% %%Part 2
% pred_folder_name = "./spcup_2022_eval_part2"
% pred_file_name = 'part_2_predictions.csv';
% prediction_yamnet('imbalenced_2k_yam.mat', pred_folder_name, pred_file_name) ;