close all
clear all
clc

d = read_mixed_csv('../data_formatted/formatted_wr_v3.csv',',');

RUSH_YDS_PER_PT = 10;
RUSH_TD_PTS = 6;
RECEIVE_YDS_PER_PT = 10;
RECEIVE_TD_PTS = 6;
PASS_YDS_PER_PT = 25;
PASS_TD_PTS = 4;
FUMBLE_PENALTY = 2;
INT_PENALTY = 2;

%d(isnan(d)) = 0 ;

%wr_2012_fp = d(:,11)/RUSH_YDS_PER_PT + d(:,12)*RUSH_TD_PTS + d(:,15)/RECEIVE_YDS_PER_PT + d(:,16)*RECEIVE_TD_PTS + d(:,19)/PASS_YDS_PER_PT + d(:,20)*PASS_TD_PTS - d(:,21)*FUMBLE_PENALTY - d(:,22)*INT_PENALTY;






