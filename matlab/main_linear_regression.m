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

%myFig = figure('Position', [2000, 2000, 600, 350]);

%############################################################
% Train
%############################################################

receiving_yds2010_delta1_train = [];
receiving_tds2010_delta1_train = [];
points2010_eoy_train = [];
receiving_yds2010_train = [];
receiving_tds2010_train = [];

Y_train = [];

for index2010 = 1:M
    % Get the players name from the top 30 list in 2010
    name = espn2010(index2010,:);
    
    % See if they played in 2011
    % If they didn't, no point in predicting them for our training data
    index2011 = strmatch(name, name2010, 'exact');
    
    if ( isempty(index2011) )
        
        disp('This Player Is Ineligble for Regression and Was Skipped:');
        name
        
    else
        
        % Get the players data from 2010
        points2010_eoy_train = [ points2010_eoy_train; points2010_eoy(index2010) ];
        receiving_yds2010_train = [ receiving_yds2010_train; receiving_yds2010(index2010) ];
        receiving_tds2010_train = [ receiving_tds2010_train; receiving_tds2010(index2010) ];
        
        % Find player in the 2009 data
        index2009 = strmatch(name, name2009, 'exact');   
        
        % If the player did not play in 2009, set their delta to 0
        if( isempty(index2011) )
            
            receiving_yds2010_delta1_train = [ receiving_yds2010_delta1_train; 0];
            receiving_tds2010_delta1_train = [ receiving_tds2010_delta1_train; 0];

        % If they did play in 2009, calculate their delta
        else
            
            receiving_yds2010_delta1_train = [ receiving_yds2010_delta1_train; ...
                (receiving_yds2010(index2010) - receiving_yds2009(index2009)) ];
            receiving_tds2010_delta1_train = [ receiving_tds2010_delta1_train; ...
                (receiving_tds2010(index2010) - receiving_tds2009(index2009)) ];
        end
        
        % Add their 2011 performance for Y_train
        Y_train = [ Y_train; points2011_eoy(index2011) ];
    end
end

% Put all of my training data together into an X matrix
X_train = [ receiving_yds2010_delta1_train, receiving_tds2010_delta1_train, ...
    points2010_eoy_train, receiving_yds2010_train, ...
    receiving_tds2010_train ];

B = ( (X_train') * X_train)^(-1) * (X_train') * Y_train;


%############################################################
% Test - Predict 2012 Results
%############################################################

receiving_yds2011_delta1_test = [];
receiving_tds2011_delta1_test = [];
points2011_eoy_test = [];
receiving_yds2011_test = [];
receiving_tds2011_test = [];

Y_ground_truth_2012 = [];

for index2011 = 1:M
    % Get the players name from the top 30 list in 2011
    name = espn2011(index2011,:);
    
    % See if they played in 2012
    % If they didn't, no point in predicting them for our test data
    index2012 = strmatch(name, name2012, 'exact');
    if ( isempty(index2012) )
        
        disp('This Player Is Ineligble for Regression and Was Skipped:');
        name
        
    else
        
        % Get the players data from 2011
        points2011_eoy_test = [ points2011_eoy_test; points2011_eoy(index2011) ];
        receiving_yds2011_test = [ receiving_yds2011_test; receiving_yds2011(index2011) ];
        receiving_tds2011_test = [ receiving_tds2011_test; receiving_tds2011(index2011) ];
        
        % Find player in the 2010 data
        index2010 = strmatch(name, name2010, 'exact');   

        % If the player did not play in 2010, set their delta to 0
        if( isempty(index2010) )
            
            receiving_yds2011_delta1_test = [ receiving_yds2011_delta1_test; 0];
            receiving_tds2011_delta1_test = [ receiving_tds2011_delta1_test; 0];

        % If they did play in 2010, calculate their delta
        else
            
            receiving_yds2011_delta1_test = [ receiving_yds2011_delta1_test; ...
                (receiving_yds2011(index2011) - receiving_yds2010(index2010)) ];
            receiving_tds2011_delta1_test = [ receiving_tds2011_delta1_test; ...
                (receiving_tds2011(index2011) - receiving_tds2010(index2010)) ];
        end
        
        % Add their 2011 performance for Y_test
        Y_ground_truth_2012 = [ Y_ground_truth_2012; points2011_eoy(index2011) ];
    end
end

X_test = [ receiving_yds2011_delta1_test, receiving_tds2011_delta1_test, ...
    points2011_eoy_test, receiving_yds2011_test, ...
    receiving_tds2011_test ];

Y_test = X_test * B;

Y_test

Y_ground_truth_2012


