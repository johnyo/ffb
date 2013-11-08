function [N,name,team,year,games_played,rush_num,rush_yds,rush_tds, ...
    receiving_targets,receiving_catches,receiving_yds,receiving_tds, ...
    points_eoy,espn2007,espn2008,espn2009,espn2010,espn2011,espn2012, ...
    espn2013,yahoo2007,yahoo2008,yahoo2009,yahoo2010,yahoo2011, ...
    yahoo2012,yahoo2013,points_pg,num_players, ...
    name2007,team2007,year2007,games_played2007,rush_num2007, ...
    rush_yds2007,rush_tds2007,receiving_targets2007, ...
    receiving_catches2007,receiving_yds2007,receiving_tds2007, ...
    name2008,team2008,year2008,games_played2008,rush_num2008, ...
    rush_yds2008,rush_tds2008,receiving_targets2008, ...
    receiving_catches2008,receiving_yds2008,receiving_tds2008, ...
    name2009,team2009,year2009,games_played2009,rush_num2009, ...
    rush_yds2009,rush_tds2009,receiving_targets2009, ...
    receiving_catches2009,receiving_yds2009,receiving_tds2009, ...
    name2010,team2010,year2010,games_played2010,rush_num2010, ...
    rush_yds2010,rush_tds2010,receiving_targets2010, ...
    receiving_catches2010,receiving_yds2010,receiving_tds2010, ...
    name2011,team2011,year2011,games_played2011,rush_num2011, ...
    rush_yds2011,rush_tds2011,receiving_targets2011, ...
    receiving_catches2011,receiving_yds2011,receiving_tds2011, ...
    name2012,team2012,year2012,games_played2012,rush_num2012, ...
    rush_yds2012,rush_tds2012,receiving_targets2012, ...
    receiving_catches2012,receiving_yds2012,receiving_tds2012 ] = read_and_format_data()

    data = read_mixed_csv('../data_formatted/formatted_wr_v3.csv',',');
    data(1,:) = [];
    data(:,12:end) = [];
    
    emptyIndex = cellfun(@isempty,data);
    data(emptyIndex) = {'0'};

    N = size(data,1);
    M = 11;

    % Import Raw Data
    name = char(data(:,1));
    team = char(data(:,2));
    year = str2num(cell2mat(data(:,3)));
    games_played = str2num(char(data(:,4)));
    rush_num = str2num(char(data(:,5)));
    rush_yds = str2num(char(data(:,6)));
    rush_tds = str2num(char(data(:,7)));
    receiving_targets = str2num(char(data(:,8)));
    receiving_catches = str2num(char(data(:,9)));
    receiving_yds = str2num(char(data(:,10)));
    receiving_tds = str2num(char(data(:,11))); 

    % Scoring Information
    RUSH_YDS_PER_PT = 10;
    RUSH_TD_PTS = 6;
    RECEIVE_YDS_PER_PT = 10;
    RECEIVE_TD_PTS = 6;

    % Points
    points_eoy = rush_yds/RUSH_YDS_PER_PT + rush_tds*RUSH_TD_PTS + receiving_yds/RECEIVE_YDS_PER_PT + receiving_tds*RECEIVE_TD_PTS;
    points_pg = points_eoy ./ games_played;
    
    % Preseason Rankings
    espn2007 = read_mixed_csv('../data_formatted/espn2007.csv',',');
    espn2007 = char(espn2007(:,2));
    espn2008 = read_mixed_csv('../data_formatted/espn2008.csv',',');
    espn2008 = char(espn2008(:,2));
    espn2009 = read_mixed_csv('../data_formatted/espn2009.csv',',');
    espn2009 = char(espn2009(:,2));
    espn2010 = read_mixed_csv('../data_formatted/espn2010.csv',',');
    espn2010 = char(espn2010(:,2));
    espn2011 = read_mixed_csv('../data_formatted/espn2011.csv',',');
    espn2011 = char(espn2011(:,2));
    espn2012 = read_mixed_csv('../data_formatted/espn2012.csv',',');
    espn2012 = char(espn2012(:,2));
    espn2013 = read_mixed_csv('../data_formatted/espn2013.csv',',');
    espn2013 = char(espn2013(:,2));
    yahoo2007 = read_mixed_csv('../data_formatted/espn2007.csv',',');
    yahoo2007 = char(espn2007(:,2));
    yahoo2008 = read_mixed_csv('../data_formatted/espn2008.csv',',');
    yahoo2008 = char(espn2008(:,2));
    yahoo2009 = read_mixed_csv('../data_formatted/espn2009.csv',',');
    yahoo2009 = char(espn2009(:,2)); 
    yahoo2010 = read_mixed_csv('../data_formatted/espn2010.csv',',');
    yahoo2010 = char(espn2010(:,2)); 
    yahoo2011 = read_mixed_csv('../data_formatted/espn2011.csv',',');
    yahoo2011 = char(espn2011(:,2));
    yahoo2012 = read_mixed_csv('../data_formatted/espn2012.csv',',');
    yahoo2012 = char(espn2012(:,2)); 
    yahoo2013 = read_mixed_csv('../data_formatted/espn2013.csv',',');
    yahoo2013 = char(espn2013(:,2));
    
    % Find out how many players there are
    i = 1;
    num_players = 0;
    while(i <= N)
       num_players = num_players + 1;
       indices =  strmatch(name(i,:), name, 'exact');
       i = indices(end)+1;
    end

    % Data for 2007
    logical2007 = (year == 2007);
    num_players_2007 = sum(logical2007);
    data2007 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2007(i) == 1 )
            data2007 = [data2007; data(i,:)];
        end
        i = i + 1;
    end
	data2007(1,:) = [];
    name2007 = char(data2007(:,1));
    team2007 = char(data2007(:,2));
    year2007 = str2num(cell2mat(data2007(:,3)));
    games_played2007 = str2num(char(data2007(:,4)));
    rush_num2007 = str2num(char(data2007(:,5)));
    rush_yds2007 = str2num(char(data2007(:,6)));
    rush_tds2007 = str2num(char(data2007(:,7)));
    receiving_targets2007 = str2num(char(data2007(:,8)));
    receiving_catches2007 = str2num(char(data2007(:,9)));
    receiving_yds2007 = str2num(char(data2007(:,10)));
    receiving_tds2007 = str2num(char(data2007(:,11)));
    
    % Data for 2008
    logical2008 = (year == 2008);
    num_players_2008 = sum(logical2008);
    data2008 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2008(i) == 1 )
            data2008 = [data2008; data(i,:)];
        end
        i = i + 1;
    end
	data2008(1,:) = [];
    name2008 = char(data2008(:,1));
    team2008 = char(data2008(:,2));
    year2008 = str2num(cell2mat(data2008(:,3)));
    games_played2008 = str2num(char(data2008(:,4)));
    rush_num2008 = str2num(char(data2008(:,5)));
    rush_yds2008 = str2num(char(data2008(:,6)));
    rush_tds2008 = str2num(char(data2008(:,7)));
    receiving_targets2008 = str2num(char(data2008(:,8)));
    receiving_catches2008 = str2num(char(data2008(:,9)));
    receiving_yds2008 = str2num(char(data2008(:,10)));
    receiving_tds2008 = str2num(char(data2008(:,11)));
    
    % Data for 2009
    logical2009 = (year == 2009);
    num_players_2009 = sum(logical2009);
    data2009 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2009(i) == 1 )
            data2009 = [data2009; data(i,:)];
        end
        i = i + 1;
    end
	data2009(1,:) = [];
    name2009 = char(data2009(:,1));
    team2009 = char(data2009(:,2));
    year2009 = str2num(cell2mat(data2009(:,3)));
    games_played2009 = str2num(char(data2009(:,4)));
    rush_num2009 = str2num(char(data2009(:,5)));
    rush_yds2009 = str2num(char(data2009(:,6)));
    rush_tds2009 = str2num(char(data2009(:,7)));
    receiving_targets2009 = str2num(char(data2009(:,8)));
    receiving_catches2009 = str2num(char(data2009(:,9)));
    receiving_yds2009 = str2num(char(data2009(:,10)));
    receiving_tds2009 = str2num(char(data2009(:,11)));
    
    % Data for 2010
    logical2010 = (year == 2010);
    num_players_2010 = sum(logical2010);
    data2010 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2010(i) == 1 )
            data2010 = [data2010; data(i,:)];
        end
        i = i + 1;
    end
	data2010(1,:) = [];
    name2010 = char(data2010(:,1));
    team2010 = char(data2010(:,2));
    year2010 = str2num(cell2mat(data2010(:,3)));
    games_played2010 = str2num(char(data2010(:,4)));
    rush_num2010 = str2num(char(data2010(:,5)));
    rush_yds2010 = str2num(char(data2010(:,6)));
    rush_tds2010 = str2num(char(data2010(:,7)));
    receiving_targets2010 = str2num(char(data2010(:,8)));
    receiving_catches2010 = str2num(char(data2010(:,9)));
    receiving_yds2010 = str2num(char(data2010(:,10)));
    receiving_tds2010 = str2num(char(data2010(:,11)));
    
    % Data for 2011
    logical2011 = (year == 2011);
    num_players_2011 = sum(logical2011);
    data2011 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2011(i) == 1 )
            data2011 = [data2011; data(i,:)];
        end
        i = i + 1;
    end
	data2011(1,:) = [];
    name2011 = char(data2011(:,1));
    team2011 = char(data2011(:,2));
    year2011 = str2num(cell2mat(data2011(:,3)));
    games_played2011 = str2num(char(data2011(:,4)));
    rush_num2011 = str2num(char(data2011(:,5)));
    rush_yds2011 = str2num(char(data2011(:,6)));
    rush_tds2011 = str2num(char(data2011(:,7)));
    receiving_targets2011 = str2num(char(data2011(:,8)));
    receiving_catches2011 = str2num(char(data2011(:,9)));
    receiving_yds2011 = str2num(char(data2011(:,10)));
    receiving_tds2011 = str2num(char(data2011(:,11)));
    
    % Data for 2012
    logical2012 = (year == 2012);
    num_players_2012 = sum(logical2012);
    data2012 = cell(1,M);
    i = 1;
    while(i < N)
        if(logical2012(i) == 1 )
            data2012 = [data2012; data(i,:)];
        end
        i = i + 1;
    end
	data2012(1,:) = [];
    name2012 = char(data2012(:,1));
    team2012 = char(data2012(:,2));
    year2012 = str2num(cell2mat(data2012(:,3)));
    games_played2012 = str2num(char(data2012(:,4)));
    rush_num2012 = str2num(char(data2012(:,5)));
    rush_yds2012 = str2num(char(data2012(:,6)));
    rush_tds2012 = str2num(char(data2012(:,7)));
    receiving_targets2012 = str2num(char(data2012(:,8)));
    receiving_catches2012 = str2num(char(data2012(:,9)));
    receiving_yds2012 = str2num(char(data2012(:,10)));
    receiving_tds2012 = str2num(char(data2012(:,11)));
    
end