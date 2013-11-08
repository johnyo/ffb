function [N,name,team,year,games_played,rush_num,rush_yds,rush_tds,receiving_targets,receiving_catches,receiving_yds,receiving_tds] = read_and_format_data()

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

end