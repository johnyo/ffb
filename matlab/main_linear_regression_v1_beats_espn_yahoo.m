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
% Train with X as all data up to 2010 + 2011 preseason rankings, 
% and then use Y as the 2011 end of year results

receiving_yds2010_delta1_train = [];
receiving_tds2010_delta1_train = [];
points2010_eoy_train = [];
receiving_yds2010_train = [];
receiving_tds2010_train = [];
espn2011_train = [];
yahoo2011_train = [];

Y_train = [];

for index2011 = 1:M
    
    % Get the players name from the top 30 ESPN preseason list for 2011
    name = espn2011(index2011,:);
    
    % only predict players that played in 2010 as well
    index2010 = strmatch(name, name2010, 'exact');
        
    if( isempty(index2010) )
        
        disp('Skipped this player in TRAINING because he didnt play in 2010')
        name
        
    else

        % Save the players' preseason espn ranking
        espn2011_train = [ espn2011_train; index2011 ];
        % Save the player's preseason Yahoo ranking
        yahoo2011_train = [ yahoo2011_train; strmatch(name, yahoo2011, 'exact') ];

        % Get the players data from the 2010 season
        points2010_eoy_train = [ points2010_eoy_train; points2010_eoy(index2010) ];
        receiving_yds2010_train = [ receiving_yds2010_train; receiving_yds2010(index2010) ];
        receiving_tds2010_train = [ receiving_tds2010_train; receiving_tds2010(index2010) ];

        % Find player in the 2009 data
        index2009 = strmatch(name, name2009, 'exact');   

        % If the player did not play in 2009, set their delta to 0
        if( isempty(index2009) )

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
X_train = [ ...
    points2010_eoy_train, ...
    receiving_yds2010_train, ...
    receiving_tds2010_train, ...
    receiving_yds2010_delta1_train, ...
    receiving_tds2010_delta1_train, ...
    ];
%     espn2011_train, ...
%     yahoo2011_train ...
%     ];

B = ( (X_train') * X_train)^(-1) * (X_train') * Y_train;

B

%############################################################
% Test - Predict 2012 Results
%############################################################

receiving_yds2011_delta1_test = [];
receiving_tds2011_delta1_test = [];
points2011_eoy_test = [];
receiving_yds2011_test = [];
receiving_tds2011_test = [];
names_to_be_predicted = [];
espn2012_test = [];
yahoo2012_test = [];

Y_ground_truth_2012 = [];

for index2012 = 1:M
 
    % Get the players name from the top 30 ESPN preseason list for 2012
    name = espn2012(index2012,:);
    
    % only predict players that played in 2011 as well
    index2011 = strmatch(name, name2011, 'exact');
        
    if( isempty(index2011) )
        
        disp('Skipped this player in TESTING because he didnt play in 2011')
        name
        
    else

        % Save the players' preseason espn ranking
        espn2012_test = [ espn2012_test; index2012 ];
        % Save the player's preseason Yahoo ranking
        yahoo2012_test = [ yahoo2012_test; strmatch(name, yahoo2012, 'exact') ];
          
        % Get the players data from the 2011 season
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

        % Add their 2012 performance for our ground truth
        Y_ground_truth_2012 = [ Y_ground_truth_2012; points2012_eoy(index2012) ];

        % save the name 
        names_to_be_predicted = [names_to_be_predicted; name];

    end
    
end

X_test = [ ...
    points2011_eoy_test, ...
    receiving_yds2011_test, ...
    receiving_tds2011_test, ...
    receiving_yds2011_delta1_test, ... 
    receiving_tds2011_delta1_test, ...
    ];
%     espn2012_test, ...
%     yahoo2012_test ...
%     ];

% Predict 
Y_test = X_test * B;

names_to_be_predicted;

[ Y_test, Y_ground_truth_2012 ];

%############################################################
% Now rank players based on fantasy point predictions
%############################################################

[sorted_Y_test, sortIndices] = sort(Y_test);
sorted_Y_test = flipud(sorted_Y_test);
sortIndices = flipud(sortIndices);

predicted_lin_reg_2012 = names_to_be_predicted(sortIndices,:)

predicted_espn2012 = espn2012(1:M,:)

predicted_yahoo2012 = yahoo2012(1:M,:)

actual = name2012(1:M,:)

%############################################################
% Quantify how good our rankings were
%############################################################

len = size(predicted_lin_reg_2012,1);
rank_lin_reg_2012 = zeros(len,1);
rank_espn_2012 = zeros(len,1);
rank_yahoo_2012 = zeros(len,1);

for i = 1:len

    rank_lin_reg_2012(i) = strmatch(predicted_lin_reg_2012(i,:), name2012, 'exact');
    rank_espn_2012(i) = strmatch(predicted_espn2012(i,:), name2012, 'exact');
    rank_yahoo_2012(i) = strmatch(predicted_yahoo2012(i,:), name2012, 'exact');
   
end

err_lin_reg_2012 = sum(quantify_error(rank_lin_reg_2012,1:30))
err_espn_2012 = sum(quantify_error(rank_espn_2012,1:30))
err_yahoo_2012 = sum(quantify_error(rank_yahoo_2012,1:30))




