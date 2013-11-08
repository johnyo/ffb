close all
clear all
clc


%###############################################################
% Import and format data
%###############################################################

%[N,name,team,year,gp,rush_num,rush_yds,rush_tds,receiving_targets,receiving_catches,receiving_yds,receiving_tds] = read_and_format_data();








data = read_mixed_csv('../data_formatted/formatted_wr_v3.csv',',');
data(1,:) = [];
data(:,12:end) = [];

emptyIndex = cellfun(@isempty,data);
data(emptyIndex) = {'0'};

N = size(data,1);

name = cell(N,1);
for i=1:N
    name{i} = num2str(cell2mat(data(i,1)));
end

team = cell(N,1);
for i=1:N
    team{i} = num2str(cell2mat(data(i,2)));
end

year = zeros(N,1);
for i=1:N
    year(i) = uint16(str2num(cell2mat(data(i,3))));
end

gp = zeros(N,1);
for i=1:N
    gp(i) = uint16(str2num(cell2mat(data(i,4))));
end

rush_num = zeros(N,1);
for i=1:N
    rush_num(i) = str2num(cell2mat(data(i,5)));
end













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







