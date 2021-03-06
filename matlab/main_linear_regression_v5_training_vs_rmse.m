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


samples = 2:29;

total_lin_reg_rmse = [];
total_lin_reg_dcg = [];
total_espn_rmse = [];
total_yahoo_rmse = [];

for i = 1:length(samples)
    
    M = samples(i);

    namesToRank = espn2012(1:M,:);

    [sorted_Y_test, names_to_be_predicted, predicted_lin_reg_2012, B ] = ...
        function_lin_reg( namesToRank, namesToRank);

    %############################################################
    % Quantify how good our rankings were
    %############################################################

    L = size(sorted_Y_test,1);

    actual_max_pts = 0;
    lin_reg_pts = 0;
    espn_pts = 0;
    yahoo_pts = 0;

    array_actual = zeros(L,1);
    array_lin_reg = zeros(L,1);
    array_espn = zeros(L,1);
    array_yahoo = zeros(L,1);

    for i = 1:L

        actual_max_pts = actual_max_pts + points2012_eoy( i );
        array_actual(i) = points2012_eoy( i );

        lin_reg_pts = lin_reg_pts + points2012_eoy( strmatch(predicted_lin_reg_2012(i,:), name2012, 'exact') );
        array_lin_reg(i) = points2012_eoy( strmatch(predicted_lin_reg_2012(i,:), name2012, 'exact') );

        espn_pts = espn_pts + points2012_eoy( strmatch(espn2012(i,:), name2012, 'exact') );
        array_espn(i) = points2012_eoy( strmatch(espn2012(i,:), name2012, 'exact') );

        yahoo_pts = yahoo_pts + points2012_eoy( strmatch(yahoo2012(i,:), name2012, 'exact') );
        array_yahoo(i) = points2012_eoy( strmatch(yahoo2012(i,:), name2012, 'exact') );

    end
    
    rank_lin_reg_2012 = zeros(L,1);
    for i = 1:L
        rank_lin_reg_2012(i) = strmatch(predicted_lin_reg_2012(i,:), name2012, 'exact');
    end

    err_rmse_lin_reg_2012 = quantify_error_rmse(array_lin_reg,array_actual);
    err_rmse_espn_2012 = quantify_error_rmse(array_espn,array_actual);
    err_rmse_yahoo_2012 = quantify_error_rmse(array_yahoo,array_actual);
    err_dcg_lin_reg_2012 = sum(quantify_error_dcg(rank_lin_reg_2012,1:30));

    total_lin_reg_rmse = [total_lin_reg_rmse; err_rmse_lin_reg_2012];
    total_lin_reg_dcg = [total_lin_reg_dcg; err_dcg_lin_reg_2012];
    total_espn_rmse = [total_espn_rmse; err_rmse_espn_2012];
    total_yahoo_rmse = [total_yahoo_rmse; err_rmse_yahoo_2012];
    
end

figure
subplot(2,1,1)
plot(total_lin_reg_rmse, 'LineWidth',3)
xlabel('Number of Players Used For Training')
ylabel('RMSE (2012 Points)')
title('RMSE Learning Curve for Linear Regression Algorithm')

subplot(2,1,2)
plot(total_lin_reg_dcg, 'LineWidth',3)
xlabel('Number of Players Used For Training')
ylabel('Discounted Cumulative Gain (2012 Points)')
title('Discounted Cumulative Gain vs. Training Set Size')
