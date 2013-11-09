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
    yahoo2012,yahoo2013,points_pg,num_players, ...
    name2007,team2007,year2007,games_played2007,rush_num2007, ...
    rush_yds2007,rush_tds2007,receiving_targets2007, ...
    receiving_catches2007,receiving_yds2007,receiving_tds2007, ...
    points2007_eoy, points2007_pg, ...
    name2008,team2008,year2008,games_played2008,rush_num2008, ...
    rush_yds2008,rush_tds2008,receiving_targets2008, ...
    receiving_catches2008,receiving_yds2008,receiving_tds2008, ...
    points2008_eoy, points2008_pg, ...
    name2009,team2009,year2009,games_played2009,rush_num2009, ...
    rush_yds2009,rush_tds2009,receiving_targets2009, ...
    receiving_catches2009,receiving_yds2009,receiving_tds2009, ...
    points2009_eoy, points2009_pg, ...
    name2010,team2010,year2010,games_played2010,rush_num2010, ...
    rush_yds2010,rush_tds2010,receiving_targets2010, ...
    receiving_catches2010,receiving_yds2010,receiving_tds2010, ...
    points2010_eoy, points2010_pg, ...
    name2011,team2011,year2011,games_played2011,rush_num2011, ...
    rush_yds2011,rush_tds2011,receiving_targets2011, ...
    receiving_catches2011,receiving_yds2011,receiving_tds2011, ...
    points2011_eoy, points2011_pg, ...
    name2012,team2012,year2012,games_played2012,rush_num2012, ...
    rush_yds2012,rush_tds2012,receiving_targets2012, ...
    receiving_catches2012,receiving_yds2012,receiving_tds2012, ...
    points2012_eoy, points2012_pg ] = read_and_format_data();

M = 30;




% %###############################################################
% % Plot ESPN Data
% %###############################################################

espn = figure('Position', [2000, 2000, 600, 350]);

subplot(3,2,1)
hold on
for i = 1:M
   name = espn2012(i,:);
   index = strmatch(name, name2012, 'exact');
   plot(i,points2012_eoy(index),'ro')
   plot(i,points2012_eoy(i),'b+')
end
title('2012 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,2)
hold on
for i = 1:M
   name = espn2011(i,:);
   index = strmatch(name, name2011, 'exact');
   plot(i,points2011_eoy(index),'ro')
   plot(i,points2011_eoy(i),'b+')
end
title('2011 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,3)
hold on
for i = 1:M
   name = espn2010(i,:);
   index = strmatch(name, name2010, 'exact');
   plot(i,points2010_eoy(index),'ro')
   plot(i,points2010_eoy(i),'b+')
end
title('2010 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,4)
hold on
for i = 1:M
   name = espn2009(i,:);
   index = strmatch(name, name2009, 'exact');
   plot(i,points2009_eoy(index),'ro')
   plot(i,points2009_eoy(i),'b+')
end
title('2009 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,5)
hold on
for i = 1:M
   name = espn2008(i,:);
   index = strmatch(name, name2008, 'exact');
   plot(i,points2008_eoy(index),'ro')
   plot(i,points2008_eoy(i),'b+')
end
title('2008 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,6)
hold on
for i = 1:M
   name = espn2007(i,:);
   index = strmatch(name, name2007, 'exact');
   plot(i,points2007_eoy(index),'ro')
   plot(i,points2007_eoy(i),'b+')
end
title('2007 Top 30: ESPN Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')
leg_espn = legend('ESPN','Actual');
newPosition = [0.45 0.0 0.15 0.08];
newUnits = 'normalized';
set(leg_espn,'Position', newPosition,'Units', newUnits);

%###############################################################
% Plot Yahoo Data
%###############################################################

yahoo = figure('Position', [2000, 2000, 600, 350]);

subplot(3,2,1)
hold on
for i = 1:M
   name = yahoo2012(i,:);
   index = strmatch(name, name2012, 'exact');
   plot(i,points2012_eoy(index),'ro')
   plot(i,points2012_eoy(i),'b+')
end
title('2012 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,2)
hold on
for i = 1:M
   name = yahoo2011(i,:);
   index = strmatch(name, name2011, 'exact');
   plot(i,points2011_eoy(index),'ro')
   plot(i,points2011_eoy(i),'b+')
end
title('2011 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,3)
hold on
for i = 1:M
   name = yahoo2010(i,:);
   index = strmatch(name, name2010, 'exact');
   plot(i,points2010_eoy(index),'ro')
   plot(i,points2010_eoy(i),'b+')
end
title('2010 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,4)
hold on
for i = 1:M
   name = yahoo2009(i,:);
   index = strmatch(name, name2009, 'exact');
   plot(i,points2009_eoy(index),'ro')
   plot(i,points2009_eoy(i),'b+')
end
title('2009 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,5)
hold on
for i = 1:M
   name = yahoo2008(i,:);
   index = strmatch(name, name2008, 'exact');
   plot(i,points2008_eoy(index),'ro')
   plot(i,points2008_eoy(i),'b+')
end
title('2008 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')

subplot(3,2,6)
hold on
for i = 1:M
   name = yahoo2007(i,:);
   index = strmatch(name, name2007, 'exact');
   plot(i,points2007_eoy(index),'ro')
   plot(i,points2007_eoy(i),'b+')
end
title('2007 Top 30: Yahoo Preseason vs. Actual')
xlabel('Ranking')
ylabel('Fantasy Points')
leg_yahoo = legend('Yahoo','Actual');
newPosition = [0.45 0.0 0.15 0.08];
newUnits = 'normalized';
set(leg_yahoo,'Position', newPosition,'Units', newUnits);

%###############################################################
% Compute Positional Error
%###############################################################

% The point difference visualation above is useful for viewing data
% but the most important thing for a fantasy football draft is the
% final, year-end position rank for each player.

espn2007_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2007(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2007, 'exact');
    % Add the result to our output array
    espn2007_results(i) = name_eof_place;
end
err_espn2007 = sum(quantify_error(espn2007_results,1:30));

espn2008_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2008(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2008, 'exact');
    % Add the result to our output array
    espn2008_results(i) = name_eof_place;
end
err_espn2008 = sum(quantify_error(espn2008_results,1:30));

espn2009_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2009(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2009, 'exact');
    % Add the result to our output array
    espn2009_results(i) = name_eof_place;
end
err_espn2009 = sum(quantify_error(espn2009_results,1:30));

espn2010_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2010(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2010, 'exact');
    % Add the result to our output array
    espn2010_results(i) = name_eof_place;
end
err_espn2010 = sum(quantify_error(espn2010_results,1:30));

espn2011_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2011(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2011, 'exact');
    % Add the result to our output array
    espn2011_results(i) = name_eof_place;
end
err_espn2011 = sum(quantify_error(espn2011_results,1:30));

espn2012_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = espn2012(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2012, 'exact');
    % Add the result to our output array
    espn2012_results(i) = name_eof_place;
end
err_espn2012 = sum(quantify_error(espn2012_results,1:30));

yahoo2007_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2007(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2007, 'exact');
    % Add the result to our output array
    yahoo2007_results(i) = name_eof_place;
end
err_yahoo2007 = sum(quantify_error(yahoo2007_results,1:30));

yahoo2008_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2008(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2008, 'exact');
    % Add the result to our output array
    yahoo2008_results(i) = name_eof_place;
end
err_yahoo2008 = sum(quantify_error(yahoo2008_results,1:30));

yahoo2009_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2009(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2009, 'exact');
    % Add the result to our output array
    yahoo2009_results(i) = name_eof_place;
end
err_yahoo2009 = sum(quantify_error(yahoo2009_results,1:30));

yahoo2010_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2010(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2010, 'exact');
    % Add the result to our output array
    yahoo2010_results(i) = name_eof_place;
end
err_yahoo2010 = sum(quantify_error(yahoo2010_results,1:30));

yahoo2011_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2011(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2011, 'exact');
    % Add the result to our output array
    yahoo2011_results(i) = name_eof_place;
end
err_yahoo2011 = sum(quantify_error(yahoo2011_results,1:30));

yahoo2012_results = zeros(1,M);
for i = 1:M
    % Go through ESPN's top M players in order
    name = yahoo2012(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2012, 'exact');
    % Add the result to our output array
    yahoo2012_results(i) = name_eof_place;
end
err_yahoo2012 = sum(quantify_error(yahoo2012_results,1:30));

err_espn = [err_espn2007, err_espn2008, err_espn2009, ...
    err_espn2010, err_espn2011, err_espn2012];

err_yahoo = [err_yahoo2007, err_yahoo2008, err_yahoo2009, ...
    err_yahoo2010, err_yahoo2011, err_yahoo2012];

%###############################################################
% Plot Rank Errors
%###############################################################

rankErr = figure('Position', [2000, 2000, 600, 350]);

hold on
plot(2007:2012, err_espn, 'ro','LineWidth',2)
plot(2007:2012, err_yahoo, 'b+','LineWidth',2)
title('ESPN/Yahoo Preseason Ranking Error')
legend('ESPN','Yahoo')
xlabel('Year')
ylabel('Error')

%###############################################################
% Save Images
%###############################################################

% saveas(espn, 'figs/espn.png','png');
% saveas(yahoo, 'figs/yahoo.png','png');
% saveas(rankErr, 'figs/rankErr.png','png');





