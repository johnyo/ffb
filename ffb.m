close all
clear all
clc


filenames = {
    'data_formatted/formatted_wr_2012.xlsx',
    };

d = xlsread(filenames{1});

RUSH_YDS_PER_PT = 10;
RUSH_TD_PTS = 6;
RECEIVE_YDS_PER_PT = 10;
RECEIVE_TD_PTS = 6;
PASS_YDS_PER_PT = 25;
PASS_TD_PTS = 4;
FUMBLE_PENALTY = 2;
INT_PENALTY = 2;


d(isnan(d)) = 0 ;

N = 30;

wr_2012_ids = d(:,3);
wr_2012_final = d(:,1);
wr_2012_espn_pre = d(:,7);
wr_2012_yahoo_pre = d(:,8);

wr_2012_fp = d(:,11)/RUSH_YDS_PER_PT + d(:,12)*RUSH_TD_PTS + d(:,15)/RECEIVE_YDS_PER_PT + d(:,16)*RECEIVE_TD_PTS + d(:,19)/PASS_YDS_PER_PT + d(:,20)*PASS_TD_PTS - d(:,21)*FUMBLE_PENALTY - d(:,22)*INT_PENALTY;

plot(wr_2012_ids,wr_2012_fp)

figure

wr_2012_yahoo_pre( wr_2012_yahoo_pre == 99999 ) = 90;

hold on
plot(wr_2012_ids,wr_2012_final,'r')
plot(wr_2012_ids,wr_2012_espn_pre,'g')
plot(wr_2012_ids,wr_2012_yahoo_pre,'b')








