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
% 3D K MEANS ON CATCHES + FP + TDS
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('3D K MEANS ON PREVIOUS YEAR CATCHES + FP + Targets')
disp('############################################')

catches2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    catches2011_espn2012 = [catches2011_espn2012; receiving_catches2011(index)];
   
end

fp_eoy_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    fp_eoy_2011_espn2012 = [fp_eoy_2011_espn2012; points2011_eoy(index)];
   
end

targets_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    targets_2011_espn2012 = [targets_2011_espn2012; receiving_targets2011(index)];
   
end

tds_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    tds_2011_espn2012 = [tds_2011_espn2012; receiving_tds2011(index)];
   
end

kvector = kmeans([catches2011_espn2012,fp_eoy_2011_espn2012,targets_2011_espn2012],2);

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

% figure
% hold on
% for i = 1:M
%     if ( kvector(i) == 1 )
%         h1 = plot3( catches2011_espn2012(i), fp_eoy_2011_espn2012(i), targets_2011_espn2012(i), 'ro', 'LineWidth',2 );
%     else
%         h2 = plot3( catches2011_espn2012(i), fp_eoy_2011_espn2012(i), targets_2011_espn2012(i), 'bo', 'LineWidth',2 );
%     end
% end
% xlabel('Catches in 2011')
% ylabel('Fantasy Points in 2011')
% zlabel('Receiving Targets in 2011')
% title('K-Means Clustering on Catches + Fantasy Poitns + Targets')
% legend([h1 h2], 'K=1','K=2','K=3')
% grid on
% set(gca,'GridLineStyle','-')

%###############################################################
%###############################################################
%###############################################################
%###############################################################
% 2D K MEANS ON CATCHES + FP
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('2D K MEANS ON PREVIOUS YEAR CATCHES + FP')
disp('############################################')

catches2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    catches2011_espn2012 = [catches2011_espn2012; receiving_catches2011(index)];
   
end

fp_eoy_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    fp_eoy_2011_espn2012 = [fp_eoy_2011_espn2012; points2011_eoy(index)];
   
end

kvector = kmeans([catches2011_espn2012,fp_eoy_2011_espn2012],2);

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

% figure
% hold on
% for i = 1:M
%     if ( kvector(i) == 1 )
%         h1 = plot( catches2011_espn2012(i), fp_eoy_2011_espn2012(i), 'ro', 'LineWidth',2 );
%     else
%         h2 = plot( catches2011_espn2012(i), fp_eoy_2011_espn2012(i), 'bo', 'LineWidth',2 );
%     end
%     
%     if ( i == 27 )
%         text(catches2011_espn2012(i) -25 , fp_eoy_2011_espn2012(i)  , espn2012(i,:),'FontSize',12)
%     elseif ( i == 28 )
%         text(catches2011_espn2012(i) -8 , fp_eoy_2011_espn2012(i) -7 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 29 )
%         text(catches2011_espn2012(i) -22 , fp_eoy_2011_espn2012(i) , espn2012(i,:),'FontSize',12)
%     elseif ( i == 17 )
%         text(catches2011_espn2012(i) , fp_eoy_2011_espn2012(i) -7 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 21 )
%         text(catches2011_espn2012(i) + 3, fp_eoy_2011_espn2012(i) -4 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 22 )
%         text(catches2011_espn2012(i) + 3 , fp_eoy_2011_espn2012(i) -4 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 18 )
%         text(catches2011_espn2012(i) -24 , fp_eoy_2011_espn2012(i)  , espn2012(i,:),'FontSize',12)
%     elseif ( i == 2 )
%         text(catches2011_espn2012(i) + 1 , fp_eoy_2011_espn2012(i) +5 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 14 )
%         text(catches2011_espn2012(i) - 27 , fp_eoy_2011_espn2012(i) , espn2012(i,:),'FontSize',12)
%     elseif ( i == 19 )
%         text(catches2011_espn2012(i) + 2 , fp_eoy_2011_espn2012(i) +6 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 7 )
%         text(catches2011_espn2012(i) - 19 , fp_eoy_2011_espn2012(i) , espn2012(i,:),'FontSize',12)
%     elseif ( i == 11 )
%         text(catches2011_espn2012(i) - 19 , fp_eoy_2011_espn2012(i) , espn2012(i,:),'FontSize',12)
%     elseif ( i == 9 )
%         text(catches2011_espn2012(i) - 6, fp_eoy_2011_espn2012(i) + 7 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 15 )
%         text(catches2011_espn2012(i) - 7, fp_eoy_2011_espn2012(i) - 7 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 5 )
%         text(catches2011_espn2012(i) + 2, fp_eoy_2011_espn2012(i) + 3 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 20 )
%         text(catches2011_espn2012(i) + 3, fp_eoy_2011_espn2012(i) - 1 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 16 )
%         text(catches2011_espn2012(i) + 3, fp_eoy_2011_espn2012(i) + 3 , espn2012(i,:),'FontSize',12)
%     elseif ( i == 8 )
%         text(catches2011_espn2012(i) - 14, fp_eoy_2011_espn2012(i) + 6 , espn2012(i,:),'FontSize',10)
%     else
%         text(catches2011_espn2012(i) + 3, fp_eoy_2011_espn2012(i) + 0, espn2012(i,:),'FontSize',12)
%     end
% end
% xlabel('Catches in 2011')
% ylabel('Fantasy Points in 2011')
% title('K-Means Clustering on Catches + Fantasy Poitns')
% legend([h1 h2], 'K=1','K=2')

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
% K MEANS ON FP x2
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR FP x2')
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
% K MEANS ON FP x3
%###############################################################
%###############################################################
%###############################################################
%###############################################################

disp('############################################')
disp('K MEANS ON PREVIOUS YEAR FP x3')
disp('############################################')

fp_eoy_2011_espn2012 = [];

for i = 1:M

    temp_nm = espn2012(i,:);
    index = strmatch(temp_nm, name2011, 'exact');
    fp_eoy_2011_espn2012 = [fp_eoy_2011_espn2012; points2011_eoy(index)];
   
end

kvector = kmeans(fp_eoy_2011_espn2012,3);

namesToRank_k1 = [];
namesToRank_k2 = [];
namesToRank_k3 = [];

for(i = 1:M)
     
    if( kvector(i) == 1 )
        namesToRank_k1 = [namesToRank_k1; espn2012(i,:)];
    elseif( kvector(i) == 2 )
        namesToRank_k2 = [namesToRank_k2; espn2012(i,:)];
    elseif( kvector(i) == 3 )
        namesToRank_k3 = [namesToRank_k3; espn2012(i,:)];
    end

end

[sorted_Y_test_k1, names_to_be_predicted_k1, predicted_lin_reg_2012_k1, B_k1 ] = ...
    function_lin_reg( namesToRank_k1, namesToRank_k1 );

[sorted_Y_test_k2, names_to_be_predicted_k2, predicted_lin_reg_2012_k2, B_k2 ] = ...
    function_lin_reg( namesToRank_k2, namesToRank_k2 );

[sorted_Y_test_k3, names_to_be_predicted_k3, predicted_lin_reg_2012_k3, B_k3 ] = ...
    function_lin_reg( namesToRank_k3, namesToRank_k3 );

%############################################################
% Merge three lists together
%############################################################

lin_reg_k_means_out = [];

for i = 1:M
    
    if( isempty(sorted_Y_test_k1) && isempty(sorted_Y_test_k2) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k3(1,:) ];
        predicted_lin_reg_2012_k3(1,:) = [];
        sorted_Y_test_k3(1) = [];
    elseif( isempty(sorted_Y_test_k1) && isempty(sorted_Y_test_k3) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
        predicted_lin_reg_2012_k2(1,:) = [];
        sorted_Y_test_k2(1) = [];  
    elseif( isempty(sorted_Y_test_k2) && isempty(sorted_Y_test_k3) )
        lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
        predicted_lin_reg_2012_k1(1,:) = [];
        sorted_Y_test_k1(1) = [];
    elseif( isempty(sorted_Y_test_k1) || isempty(sorted_Y_test_k2) || isempty(sorted_Y_test_k3) )
        if( isempty(sorted_Y_test_k1) )
            if( sorted_Y_test_k2(1) > sorted_Y_test_k3(1) )
                lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
                predicted_lin_reg_2012_k2(1,:) = [];
                sorted_Y_test_k2(1) = [];
            else
                lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k3(1,:) ];
                predicted_lin_reg_2012_k3(1,:) = [];
                sorted_Y_test_k3(1) = [];
            end
        elseif( isempty(sorted_Y_test_k2) )
            if( sorted_Y_test_k1(1) > sorted_Y_test_k3(1) )
                lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
                predicted_lin_reg_2012_k1(1,:) = [];
                sorted_Y_test_k1(1) = [];
            else
                lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k3(1,:) ];
                predicted_lin_reg_2012_k3(1,:) = [];
                sorted_Y_test_k3(1) = [];
            end
        elseif( isempty(sorted_Y_test_k3) )
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
    else
        [max_val, max_val_index] = max( [ sorted_Y_test_k1(1), sorted_Y_test_k2(1), sorted_Y_test_k3(1) ] );
        if(max_val_index == 1)
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k1(1,:) ];
            predicted_lin_reg_2012_k1(1,:) = [];
            sorted_Y_test_k1(1) = [];
        elseif(max_val_index == 2)
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k2(1,:) ];
            predicted_lin_reg_2012_k2(1,:) = [];
            sorted_Y_test_k2(1) = [];
        else
            lin_reg_k_means_out = [lin_reg_k_means_out; predicted_lin_reg_2012_k3(1,:) ];
            predicted_lin_reg_2012_k3(1,:) = [];
            sorted_Y_test_k3(1) = [];
        end
    end
end

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









