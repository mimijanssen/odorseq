%% Plots SWRs from IV
% This code 1) finds the LFP channel that is closest to the one defined in the
% experimental keys for each probe (if they exist). 2) plots the LFP for
% the the SWR intervals. 3) saves the output in a defined folder. 

clear; clc;  

% ~~~ PARAMETERS YOU NEED TO CHANGE ~~~ 

% cd to your session directory 
cd D:\Task2-SWR-derived\M537\preprocessed\M537-2025-04-14

% cd to your figure saving directory 


%% Load all the data 
LoadExpKeys

load('imec0_SWR') % imec0_swr
load('imec0_clean_lfp') % imec0 
load('imec1_SWR') % imec1_swr
load('imec1_clean_lfp') % imec1

% AP for imec0 SWRs 
targetNum = str2double(regexp(ExpKeys.imec0_best_SWR_channel, '\d+', 'match', 'once')); %swr_chan_0 = str2num(erase(ExpKeys.imec0_best_SWR_channel, ['A','P'])); 
apNums = str2double(regexp(cellstr(imec0.channel_ids), '(?<=AP)\d+', 'match', 'once'));
[~, idx_0] = min(abs(apNums - targetNum));

% AP for imec1 SWRs
targetNum = str2double(regexp(ExpKeys.imec1_best_SWR_channel, '\d+', 'match', 'once')); %swr_chan_0 = str2num(erase(ExpKeys.imec0_best_SWR_channel, ['A','P'])); 
apNums = str2double(regexp(cellstr(imec1.channel_ids), '(?<=AP)\d+', 'match', 'once'));
[~, idx_1] = min(abs(apNums - targetNum));

%% Plot and Save the data.

% format iv to MVDM lab structure 
swrs_imec0 = imec0_swr.iv; 
swrs_imec1 = imec1_swr.iv; 

% format tsd to MVDM lab structure
lfp_imec0 = tsd; 
lfp_imec0.data = (imec0.lfp_traces(:,idx_0))'; % with corresponding LFP that has good SWRs
lfp_imec0.tvec = imec0.lfp_tvec; 

lfp_imec1 = tsd; 
lfp_imec1.data = (imec1.lfp_traces(:,idx_1))'; % with corresponding LFP that has good SWRs
lfp_imec1.tvec = imec1.lfp_tvec; 

% plot stuff 
cfg_plot = [];
cfg_plot.display = 'iv';
cfg_plot.mode    = 'center';
cfg_plot.fgcol   = 'k';
PlotTSDfromIV(cfg_plot, swrs_imec0, lfp_imec0);

% save stuff! 


