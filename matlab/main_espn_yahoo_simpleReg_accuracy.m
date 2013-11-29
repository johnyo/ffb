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

% M is the number of postition rankings we will consider each year
% This means compare ESPN's top 30 year each with Yahoo's top 30 each
% year.
M = 30;

%###############################################################
% Simple Regression
%###############################################################
% Predicted Points in year Y + 1 = Points in year Y
% For any players in a year's top 30 that retire, skip them

% Predict 2008 results using 2007 results
simple_linear_prediction2008 = zeros(M,1);
for i = 1:M
    % Go through previous year's top M players in order
    name = name2007(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2008, 'exact');
    % Add the result to our output array
    simple_linear_prediction2008(i) = name_eof_place;
end
% The current year data is already sorted, so compare our
% result with the vector 1:30 to get error
err_simple_linear_prediction2008 = sum(quantify_error_dcg(simple_linear_prediction2008,1:30));

% Predict 2009 results using 2008 results
simple_linear_prediction2009 = zeros(M,1);
for i = 1:M
    % Go through previous year's top M players in order
    name = name2008(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2009, 'exact');
    % Add the result to our output array
    simple_linear_prediction2009(i) = name_eof_place;
end
% The current year data is already sorted, so compare our
% result with the vector 1:30 to get error
err_simple_linear_prediction2009 = sum(quantify_error_dcg(simple_linear_prediction2009,1:30));

% Predict 2010 results using 2009 results
simple_linear_prediction2010 = zeros(M,1);
for i = 1:M
    % Go through previous year's top M players in order
    name = name2009(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2010, 'exact');
    % Add the result to our output array
    simple_linear_prediction2010(i) = name_eof_place;
end
% The current year data is already sorted, so compare our
% result with the vector 1:30 to get error
err_simple_linear_prediction2010 = sum(quantify_error_dcg(simple_linear_prediction2010,1:30));

% Predict 2011 results using 2010 results
simple_linear_prediction2011 = zeros(M,1);
for i = 1:M
    % Go through previous year's top M players in order
    % Note T Owens didn't play in 2015 so skip him with this if statement
    if ( i < 15 )
        name = name2010(i,:);
    else
        name = name2010(i+1,:);
    end
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2011, 'exact');
    % Add the result to our output array
    simple_linear_prediction2011(i) = name_eof_place;
end
% The current year data is already sorted, so compare our
% result with the vector 1:30 to get error
err_simple_linear_prediction2011 = sum(quantify_error_dcg(simple_linear_prediction2011,1:30));

% Predict 2012 results using 2011 results
simple_linear_prediction2012 = zeros(M,1);
for i = 1:M
    % Go through previous year's top M players in order
    name = name2011(i,:);
    % Find their rank at the end of the year
    % In the data from read_and_format_data which
    % Is sorted by year-end-performance
    name_eof_place = strmatch(name, name2012, 'exact');
    % Add the result to our output array
    simple_linear_prediction2012(i) = name_eof_place;
end
% The current year data is already sorted, so compare our
% result with the vector 1:30 to get error
err_simple_linear_prediction2012 = sum(quantify_error_dcg(simple_linear_prediction2012,1:30));

%###############################################################
% Aggregate Data
%###############################################################

err_simple_linear_prediction = [ ...
    err_simple_linear_prediction2008, err_simple_linear_prediction2009, ...
    err_simple_linear_prediction2010, err_simple_linear_prediction2011, ...
    err_simple_linear_prediction2012];

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
err_dcg_espn_2007 = sum(quantify_error_dcg(espn2007_results,1:30));

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
err_dcg_espn_2008 = sum(quantify_error_dcg(espn2008_results,1:30));

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
err_dcg_espn_2009 = sum(quantify_error_dcg(espn2009_results,1:30));

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
err_dcg_espn_2010 = sum(quantify_error_dcg(espn2010_results,1:30));

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
err_dcg_espn_2011 = sum(quantify_error_dcg(espn2011_results,1:30));

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
err_dcg_espn_2012 = sum(quantify_error_dcg(espn2012_results,1:30));

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
err_dcg_yahoo_2007 = sum(quantify_error_dcg(yahoo2007_results,1:30));

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
err_dcg_yahoo_2008 = sum(quantify_error_dcg(yahoo2008_results,1:30));

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
err_dcg_yahoo_2009 = sum(quantify_error_dcg(yahoo2009_results,1:30));

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
err_dcg_yahoo_2010 = sum(quantify_error_dcg(yahoo2010_results,1:30));

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
err_dcg_yahoo_2011 = sum(quantify_error_dcg(yahoo2011_results,1:30));

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
err_dcg_yahoo_2012 = sum(quantify_error_dcg(yahoo2012_results,1:30));

% err_espn = [err_espn2007, err_espn2008, err_espn2009, ...
%     err_espn2010, err_espn2011, err_espn2012];
% 
% err_yahoo = [err_yahoo2007, err_yahoo2008, err_yahoo2009, ...
%     err_yahoo2010, err_yahoo2011, err_yahoo2012];

err_espn = [err_dcg_espn_2007, err_dcg_espn_2008, err_dcg_espn_2009, ...
    err_dcg_espn_2010, err_dcg_espn_2011, err_dcg_espn_2012];

err_yahoo = [err_dcg_yahoo_2007, err_dcg_yahoo_2008, err_dcg_yahoo_2009, ...
    err_dcg_yahoo_2010, err_dcg_yahoo_2011, err_dcg_yahoo_2012];

%###############################################################
% Plot Rank Errors
%###############################################################
% 
% rankErr = figure('Position', [2000, 2000, 600, 350]);
% 
% hold on
% plot(2007:2012, err_espn, 'ro','LineWidth',2)
% plot(2007:2012, err_yahoo, 'b+','LineWidth',2)
% title('ESPN/Yahoo Preseason Ranking Error')
% legend('ESPN','Yahoo')
% xlabel('Year')
% ylabel('Error')

rankErr2 = figure('Position', [2000, 2000, 600, 350]);

err_simple_linear_prediction = [0, err_simple_linear_prediction];

hold on
X = [err_espn', err_yahoo', err_simple_linear_prediction'];
bar(X)
title('Discounted Cumulative Gain of Naive Ranking Strategies')
legend('ESPN','Yahoo', 'Previous Year','Location','NorthWest')
xlabel('Year')
ylabel('Discounted Cumulative Gain')
xlim([0.5,6.5])

%###############################################################
% Save Images
%###############################################################

% saveas(espn, 'figs/espn.png','png');
% saveas(yahoo, 'figs/yahoo.png','png');
% saveas(rankErr, 'figs/rankErr.png','png');





