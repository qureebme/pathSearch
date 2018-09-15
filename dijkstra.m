clc

map_definition

start_pt = [17 2];  % the start point
dest = [2 20];      % the destination

plot(start_pt(1),start_pt(2),'r*');
plot(dest(1),dest(2),'bo');

numOfPts = 1; % number of points added to the map.
              % these points represent Node objects.

n = input('How many other nodes do you want to create? ');

% Initialize a cell of n+2 items where 
% Node objects will be held
Nodes{n+2} = Node(dest);   % dest node as last object in the cell,
Nodes{1} = Node(start_pt); % and start_pt as the first.

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