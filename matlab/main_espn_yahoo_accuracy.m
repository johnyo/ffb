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

%strcmp(name(end-2,:),name(end-3,:))

% figure
% hold on
% indices = strmatch('Johnson | Calvin', name, 'exact')
% plot(year(indices),points_eoy(indices))


% 
% N = 20;
% a = name(1:N,:);
% i = 1;
% num_players = 0;
% while(i <= N)
%    num_players = num_players + 1;
%    indices =  strmatch(a(i,:), a, 'exact');
%    
%    % indicies now contains indices for a single player over all years
%    
%    
%    
%    i = indices(end)+1;
% end

% rank players for 2007

M = 30;
% 
% FigHandle = figure('Position', [1000, 1000, 1000, 1000]);
% subplot(3,2,1)
% hold on
% for i = 1:M
%    name = espn2012(i,:)
%    index = strmatch(name, name2012, 'exact')
%    plot(i,points2012_eoy(index),'ro')
%    plot(i,points2012_eoy(i),'b+')
% end
% title('2012 End of Year Fantasy Points: ESPN Preseason vs. Actual')
% legend('ESPN','End of Year')




%###############################################################
% Plot ESPN Data
%###############################################################

FigHandle = figure('Position', [2000, 2000, 800, 500]);

subplot(3,2,1)
hold on
for i = 1:M
   name = espn2012(i,:);
   index = strmatch(name, name2012, 'exact');
   plot(i,points2012_eoy(index),'ro')
   plot(i,points2012_eoy(i),'b+')
end
title('2012 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')

subplot(3,2,2)
hold on
for i = 1:M
   name = espn2011(i,:);
   index = strmatch(name, name2011, 'exact');
   plot(i,points2011_eoy(index),'ro')
   plot(i,points2011_eoy(i),'b+')
end
title('2011 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')

subplot(3,2,3)
hold on
for i = 1:M
   name = espn2010(i,:);
   index = strmatch(name, name2010, 'exact');
   plot(i,points2010_eoy(index),'ro')
   plot(i,points2010_eoy(i),'b+')
end
title('2010 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')

subplot(3,2,4)
hold on
for i = 1:M
   name = espn2009(i,:);
   index = strmatch(name, name2009, 'exact');
   plot(i,points2009_eoy(index),'ro')
   plot(i,points2009_eoy(i),'b+')
end
title('2009 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')

subplot(3,2,5)
hold on
for i = 1:M
   name = espn2008(i,:);
   index = strmatch(name, name2008, 'exact');
   plot(i,points2008_eoy(index),'ro')
   plot(i,points2008_eoy(i),'b+')
end
title('2008 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')

subplot(3,2,6)
hold on
for i = 1:M
   name = espn2007(i,:);
   index = strmatch(name, name2007, 'exact');
   plot(i,points2007_eoy(index),'ro')
   plot(i,points2007_eoy(i),'b+')
end
title('2007 End of Year Fantasy Points: ESPN Preseason vs. Actual')
legend('ESPN','End of Year')





%###############################################################
% Plot Yahoo Data
%###############################################################

FigHandle = figure('Position', [2000, 2000, 800, 500]);

subplot(3,2,1)
hold on
for i = 1:M
   name = yahoo2012(i,:);
   index = strmatch(name, name2012, 'exact');
   plot(i,points2012_eoy(index),'ro')
   plot(i,points2012_eoy(i),'b+')
end
title('2012 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')

subplot(3,2,2)
hold on
for i = 1:M
   name = yahoo2011(i,:);
   index = strmatch(name, name2011, 'exact');
   plot(i,points2011_eoy(index),'ro')
   plot(i,points2011_eoy(i),'b+')
end
title('2011 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')

subplot(3,2,3)
hold on
for i = 1:M
   name = yahoo2010(i,:);
   index = strmatch(name, name2010, 'exact');
   plot(i,points2010_eoy(index),'ro')
   plot(i,points2010_eoy(i),'b+')
end
title('2010 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')

subplot(3,2,4)
hold on
for i = 1:M
   name = yahoo2009(i,:);
   index = strmatch(name, name2009, 'exact');
   plot(i,points2009_eoy(index),'ro')
   plot(i,points2009_eoy(i),'b+')
end
title('2009 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')

subplot(3,2,5)
hold on
for i = 1:M
   name = yahoo2008(i,:);
   index = strmatch(name, name2008, 'exact');
   plot(i,points2008_eoy(index),'ro')
   plot(i,points2008_eoy(i),'b+')
end
title('2008 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')

subplot(3,2,6)
hold on
for i = 1:M
   name = yahoo2007(i,:);
   index = strmatch(name, name2007, 'exact');
   plot(i,points2007_eoy(index),'ro')
   plot(i,points2007_eoy(i),'b+')
end
title('2007 End of Year Fantasy Points: Yahoo Preseason vs. Actual')
legend('Yahoo','End of Year')
