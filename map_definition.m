% Create map vertices
x_obstacle = [0 0 30 30 NaN 1 12 12 13 13 23 23 24 24 29 29 ...
    12 12 15 15 16 16 29 29 16 16 15 15 1 1 8 8 1 1 4 4 1 NaN ...
    8 8 24 24 23 23 13 13 12 12]';
y_obstacle = [0 30 30 0 NaN 1 1 4 4 1 1 4 4 1 1 18 18 19 19 ...
    22 22 19 19 29 29 26 26 29 29 19 19 18 18 12 12 11 11 NaN ...
    11 12 12 8 8 11 11 8 8 11]';

% Inflate the map
pgon = polyshape(x_obstacle, y_obstacle);
pgon_buffer = polybuffer(pgon, 0.3);

figure; plot(pgon);
hold on

% Get inflated vertices
x_buffer = pgon_buffer.Vertices(:,1);
y_buffer = pgon_buffer.Vertices(:,2);

 title('Robot Path Search: Dijkstra Algorithm');

%clear pgon pgon_buffer
%%











