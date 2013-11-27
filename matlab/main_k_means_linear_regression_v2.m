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
M = 29;

%###############################################################
%###############################################################
%###############################################################
%###############################################################
% K MEANS ON CATCHES
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR CATCHES')
disp('############################################')

catches2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    catches2011_espn2012 = [catches2011_espn2012; receiving_catches2011(index)];
   
end

kvector = kmeans(catches2011_espn2012,2);

namesToRank_k1 = [];
namesToRank_k2 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    end
end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

%############################################################
% Merge two lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];
    elseif( isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    else
        if( sorted_Y_test_k1(1) > sorted_Y_test_k2(1) )
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        end
    end
end

% lin_reg_k_means_out

%#############################################################
% Get actual results
%############################################################

% players actual results
actual_results = [];

for i = 1:M
    
    index = strmatch(lin_reg_k_means_out(i,:), name2012, 'exact');
    actual_results = [actual_results; index];
    
end

% actual_results

%############################################################
% Quantify how good our rankings were
%############################################################

err_lin_reg_2012 = sum(quantify_error(actual_results,1:30))
err_dcg_lin_reg_2012 = sum(quantify_error_dcg(actual_results,1:30))

%###############################################################
%###############################################################
%###############################################################
%###############################################################
% K MEANS ON FP
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR FP')
disp('############################################')

fp_eoy_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    fp_eoy_2011_espn2012 = [fp_eoy_2011_espn2012; points2011_eoy(index)];
   
end

kvector = kmeans(fp_eoy_2011_espn2012,2);

namesToRank_k1 = [];
namesToRank_k2 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    end
end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

%############################################################
% Merge two lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];
    elseif( isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    else
        if( sorted_Y_test_k1(1) > sorted_Y_test_k2(1) )
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        end
    end
end

% lin_reg_k_means_out

%#############################################################
% Get actual results
%############################################################

% players actual results
actual_results = [];

for i = 1:M
    
    index = strmatch(lin_reg_k_means_out(i,:), name2012, 'exact');
    actual_results = [actual_results; index];
    
end

% actual_results

%############################################################
% Quantify how good our rankings were
%############################################################

err_lin_reg_2012 = sum(quantify_error(actual_results,1:30))
err_dcg_lin_reg_2012 = sum(quantify_error_dcg(actual_results,1:30))

%###############################################################
%###############################################################
%###############################################################
%###############################################################
% K MEANS ON TDS
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR TDS')
disp('############################################')

tds_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    tds_2011_espn2012 = [tds_2011_espn2012; receiving_tds2011(index)];
   
end

kvector = kmeans(tds_2011_espn2012,2);

namesToRank_k1 = [];
namesToRank_k2 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    end
end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

%############################################################
% Merge two lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];
    elseif( isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    else
        if( sorted_Y_test_k1(1) > sorted_Y_test_k2(1) )
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        end
    end
end

% lin_reg_k_means_out

%#############################################################
% Get actual results
%############################################################

% players actual results
actual_results = [];

for i = 1:M
    
    index = strmatch(lin_reg_k_means_out(i,:), name2012, 'exact');
    actual_results = [actual_results; index];
    
end

% actual_results

%############################################################
% Quantify how good our rankings were
%############################################################

err_lin_reg_2012 = sum(quantify_error(actual_results,1:30))
err_dcg_lin_reg_2012 = sum(quantify_error_dcg(actual_results,1:30))

%###############################################################
%###############################################################
%###############################################################
%###############################################################
% K MEANS ON YDS
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR RECEIVING YDS')
disp('############################################')

yds_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    yds_2011_espn2012 = [yds_2011_espn2012; receiving_yds2011(index)];
   
end

kvector = kmeans(yds_2011_espn2012,2);

namesToRank_k1 = [];
namesToRank_k2 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    end
end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

%############################################################
% Merge two lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];
    elseif( isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    else
        if( sorted_Y_test_k1(1) > sorted_Y_test_k2(1) )
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        end
    end
end

% lin_reg_k_means_out

%#############################################################
% Get actual results
%############################################################

% players actual results
actual_results = [];

for i = 1:M
    
    index = strmatch(lin_reg_k_means_out(i,:), name2012, 'exact');
    actual_results = [actual_results; index];
    
end

% actual_results

%############################################################
% Quantify how good our rankings were
%############################################################

err_lin_reg_2012 = sum(quantify_error(actual_results,1:30))
err_dcg_lin_reg_2012 = sum(quantify_error_dcg(actual_results,1:30))


%###############################################################
%###############################################################
%###############################################################
%###############################################################
% K MEANS ON TARGETS
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR RECEIVING TARGETS')
disp('############################################')

targets_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    targets_2011_espn2012 = [targets_2011_espn2012; receiving_targets2011(index)];
   
end

kvector = kmeans(targets_2011_espn2012,2);

namesToRank_k1 = [];
namesToRank_k2 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    end
end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

%############################################################
% Merge two lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];
    elseif( isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    else
        if( sorted_Y_test_k1(1) > sorted_Y_test_k2(1) )
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        end
    end
end

% lin_reg_k_means_out

%#############################################################
% Get actual results
%############################################################

% players actual results
actual_results = [];

for i = 1:M
    
    index = strmatch(lin_reg_k_means_out(i,:), name2012, 'exact');
    actual_results = [actual_results; index];
    
end

% actual_results

%############################################################
% Quantify how good our rankings were
%############################################################

err_lin_reg_2012 = sum(quantify_error(actual_results,1:30))
err_dcg_lin_reg_2012 = sum(quantify_error_dcg(actual_results,1:30))









