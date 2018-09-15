clc

map_definition

start_pt = [17 2];  % the start point
dest = [2 20];      % the destination

%cost_per_unit = 1;
total_cost = 1e6; % very large figure

plot(start_pt(1),start_pt(2),'r*');
plot(dest(1),dest(2),'bo');

numOfPts = 1; % number of points added to the map.
              % these points represent Node objects.

n = input('How many other nodes do you want to create? ');

% Initialize a cell of n+2 items where 
% Node objects will be held
Nodes{n+2} = Node(dest);   % dest node as last object in the cell,
Nodes{1} = Node(start_pt); % and start_pt as the first.

LOS_vector = [dest(1)-start_pt(1) dest(2)-start_pt(2)]; % we will assume the robot is facing
                                             % the destination at the
                                             % beginning.

while numOfPts < n + 1
    randx = rand() * 30; % random x coordinate
    randy = rand() * 30; % random y coordinate
    
    if inpolygon(randx, randy, x_obstacle, y_obstacle) == 0
        Node([randx,randy]).draw();
        numOfPts = numOfPts + 1;
        Nodes{numOfPts} = Node([randx, randy]); % first addition will be Nodes{2}
    end

    pause(0.1);
end

%% Now let's draw edges to connect nodes that are
 % visible from each other.
 
 for i = 1:length(Nodes)-1
     
     for i2 = i+1:length(Nodes)
         pt_1 = Nodes{i}.coords;    % first point
         pt_2 = Nodes{i2}.coords;    % second point
         
         if isempty(polyxpoly([pt_1(1) pt_2(1)],[pt_1(2) pt_2(2)], x_obstacle, y_obstacle))
             Edge(Node(pt_1),Node(pt_2)).draw();
             
             Nodes{i}.hasNeighbours = true;
             Nodes{i2}.hasNeighbours = true; % obviously!!
             
             % keep a record.
             Nodes{i}.neighbours = [Nodes{i}.neighbours; Nodes{i2}.coords];
             Nodes{i2}.neighbours = [Nodes{i2}.neighbours; Nodes{i}.coords];
         end
         pause(0.1);
     end

 end
 
 %% PATH FINDING BY THE DIJKSTRA ALGORITHM
 
 for j = 1:n % for each node in Nodes
     m = size(Nodes{j}.neighbours); % size of its neighbors property
     
     for k = 1:m(1) % m(1) is Node{j}'s num of neighbours
         edge = Edge(Node(Nodes{j}.coords),Node([Nodes{j}.neighbours(k) Nodes{j}.neighbours(m(1)+k)]));
         % k is the index of the x_coord of the k-th neighbour of Nodes{j}
         %  while m(1)+k is the index of its y_coord.
         
         if j==1 % start node
             rad = angl(LOS_vector, [Nodes{j}.neighbours(k)-start_pt(1) Nodes{j}.neighbours(m(1)+k)-start_pt(2)]);
             % rad is the angle btw LOS path and neighbs of start node
             % which is Nodes{1}. rad is equal to the turning cost
             % 
             edge_cost = edge.edgeCost();
             cost = edge_cost + rad;
             if cost < total_cost
                 total_cost = cost;
             end
         end
     end
     
 end
 
 
 
 