clc

map_definition

start_pt = [17 2]; % the start point
dest = [2 20]; % the destination

plot(start_pt(1),start_pt(2),'r*');
plot(dest(1),dest(2),'bo');

n = input('How many other nodes do you want to create? ');

% Initialize a cell of n+2 items where 
% Node objects will be kept
pt_coords{n+2} = Node(dest); 
pt_coords{1} = Node(start_pt);
