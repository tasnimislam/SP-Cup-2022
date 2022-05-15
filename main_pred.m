clc;
clear all;
close all;

%%Prediction
%% If custom trained please use 'weight_name.mat' instead of 'imbalenced_2k_yam.mat' in prediction_yamnet
% %Change the path name here
% %Part 1
% pred_folder_name = "./spcup_2022_eval_part1" %Change root directory here
% pred_file_name = 'part_1_predictions_yam.csv'; %change filename here
% prediction_yamnet('imbalenced_2k_yam.mat', pred_folder_name, pred_file_name) ;
% 
% %%Part 2
% pred_folder_name = "./spcup_2022_eval_part2"
% pred_file_name = 'part_2_predictions_yam.csv';
% prediction_yamnet('imbalenced_2k_yam.mat', pred_folder_name, pred_file_name) ;

%%Final pred
pred_folder_name = "D:\sp cup 2022\Students_Procastinating_ID27592_code_report\semisup_ds\semisup_ds\unlabeled";
pred_file_name = 'semi_5_may_yam.csv';
prediction_yamnet('yamnet_5_may.mat', pred_folder_name, pred_file_name) ;