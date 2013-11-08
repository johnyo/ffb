close all
clear all
clc


%###############################################################
% Import and format data
%###############################################################

[N,name,team,year,games_played,rush_num,rush_yds,rush_tds, ...
receiving_targets,receiving_catches,receiving_yds,receiving_tds, ...
points_eoy,espn2007,espn2008,espn2009,espn2010,espn2011,espn2012, ...
espn2013,yahoo2007,yahoo2008,yahoo2009,yahoo2010,yahoo2011, ...
yahoo2012, yahoo2013] = read_and_format_data();

%strcmp(name(end-2,:),name(end-3,:))

figure
hold on
indices = strmatch(name(652,:), name, 'exact')
for i = 1:length(indices)
   plot( i, points_eoy(indices(i)) , 'ro')
end











