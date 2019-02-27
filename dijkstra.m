clc
clear all
map_definition

start_pt = [17 2];  % the start point
dest = [2 20];      % the destination

plot(start_pt(1),start_pt(2),'r*');
plot(dest(1),dest(2),'g*');

numOfPts = 1; % number of points added to the map.
              % these points represent Node objects.

n = input('How many other nodes do you want to create? ');
%title('Robot Path Search: Dijkstra Algorithm with ',n, ' nodes');

% Initialize a cell array of n+2 Node items 
Nodes{n+2} = Node(dest);   % dest node as last object in the cell,
Nodes{1} = Node(start_pt); % and start node as the first.

Nodes{1}.cost = 0; % we are already at this location

LOS_vector = [dest(1)-start_pt(1) dest(2)-start_pt(2)]; %line-of-sight vector
% we will assume the robot is directly facing
% the destination at the beginning.
                                             
%% NOW WE FILL UP THE CELL ARRAY OF NODES AS WE CREATE THEM

while numOfPts < n + 1 
%     randx = randi([1 30]);% * 30; % random x coordinate
%     randy = randi([1 30]);% * 30; % random y coordinate
    randx = rand() * 30; % random x coordinate
    randy = rand() * 30; % random y coordinate
    if inpolygon(randx, randy, x_obstacle, y_obstacle) == 0
        Node([randx,randy]).draw();
        numOfPts = numOfPts + 1;
        Nodes{numOfPts} = Node([randx, randy]); % first addition will be Nodes{2}
    end
end

%% Now let's draw edges to connect any two nodes that are
 % visible from each other.
 
 for a = 1:length(Nodes)-1
     
     for b = a+1:length(Nodes)
         pt_1 = Nodes{a}.coords;    % first point
         pt_2 = Nodes{b}.coords;    % second point
         
         if isempty(polyxpoly([pt_1(1) pt_2(1)],[pt_1(2) pt_2(2)], x_obstacle, y_obstacle))
             Edge(Node(pt_1),Node(pt_2)).draw();
             
             Nodes{a}.hasNeighbours = true;
             Nodes{b}.hasNeighbours = true; % obviously!!
             
             % and keep a record of connected nodes
             Nodes{a}.neighbours = [Nodes{a}.neighbours, Nodes{b}];
             Nodes{b}.neighbours = [Nodes{b}.neighbours, Nodes{a}];
         end
         %pause(0.1);
     end

 end

% we are already at the start pt
path = Path(Nodes{1}); % INITIALIZE a Path object with the starting point as
                       % the first node.

dijkstraRouteFinder(Nodes{1}, Nodes, path, 1);
