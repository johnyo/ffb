function [N,name,team,year,games_played,rush_num,rush_yds,rush_tds, ...
    receiving_targets,receiving_catches,receiving_yds,receiving_tds, ...
    points_eoy,espn2007,espn2008,espn2009,espn2010,espn2011,espn2012, ...
    espn2013,yahoo2007,yahoo2008,yahoo2009,yahoo2010,yahoo2011, ...
    yahoo2012, yahoo2013] = read_and_format_data()

    data = read_mixed_csv('../data_formatted/formatted_wr_v3.csv',',');
    data(1,:) = [];
    data(:,12:end) = [];

    emptyIndex = cellfun(@isempty,data);
    data(emptyIndex) = {'0'};

    N = size(data,1);

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

    RUSH_YDS_PER_PT = 10;
    RUSH_TD_PTS = 6;
    RECEIVE_YDS_PER_PT = 10;
    RECEIVE_TD_PTS = 6;

    points_eoy = rush_yds/RUSH_YDS_PER_PT + rush_tds*RUSH_TD_PTS + receiving_yds/RECEIVE_YDS_PER_PT + receiving_tds*RECEIVE_TD_PTS;

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
   
    
end