function [N,name,team,year,gp,rush_num,rush_yds,rush_tds,receiving_targets,receiving_catches,receiving_yds,receiving_tds] = read_and_format_data()

    data = read_mixed_csv('../data_formatted/formatted_wr_v3.csv',',');
    data(1,:) = [];
    data(:,12:end) = [];

    emptyIndex = cellfun(@isempty,data);
    data(emptyIndex) = {'0'};

    N = size(data,1);

    name = cell(N,1);
    for i=1:N
        name{i} = num2str(cell2mat(data(i,1)));
    end

    team = cell(N,1);
    for i=1:N
        team{i} = num2str(cell2mat(data(i,2)));
    end

    year = zeros(N,1);
    for i=1:N
        year(i) = uint16(str2num(cell2mat(data(i,3))));
    end

    gp = zeros(N,1);
    for i=1:N
        gp(i) = uint16(str2num(cell2mat(data(i,4))));
    end

    rush_num = zeros(N,1);
    for i=1:N
        rush_num(i) = str2num(cell2mat(data(i,5)));
    end

    rush_yds = zeros(N,1);
    for i=1:N
        rush_yds(i) = str2num(cell2mat(data(i,6)));
    end

    rush_tds = zeros(N,1);
    for i=1:N
        rush_tds(i) = str2num(cell2mat(data(i,7)));
    end

    receiving_targets = zeros(N,1);
    for i=1:N
        receiving_targets(i) = str2num(cell2mat(data(i,8)));
    end

    receiving_catches = zeros(N,1);
    for i=1:N
        receiving_catches(i) = str2num(cell2mat(data(i,9)));
    end

    receiving_yds = zeros(N,1);
    for i=1:N
        receiving_yds(i) = str2num(cell2mat(data(i,10)));
    end

    receiving_tds = zeros(N,1);
    for i=1:N
        receiving_tds(i) = str2num(cell2mat(data(i,11)));
    end

end