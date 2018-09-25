function dijkstraFinder = dijkstraRouteFinder(curr_Node, Nodes, pathObj, k)
%DIJKSTRAROUTEFINDER
%   This function finds the cheapest route from a given start node to a
%   specified destination node. curr_Node has to be the start node as
%   specified in Path object pathObj. Nodes is a cell array of Node objects,
%   and k is the number of times this function has been called. k must be 1
%   at the start node.

LOS_vector = [-15 18]; % line-of-sight vector that goes directly from 
                        % the start point to the destination. It is assumed 
                        % that the robot is initially facing this
                        % direction.
N = length(Nodes);
e2 = length(pathObj.nodes);

%fprintf('curr_Node.coords : %.2f %.2f\n', curr_Node.coords);
%% NOW CALCULATE THE COST OF GOING FROM THE CURRENT NODE TO
%   EACH OF ITS NEIGHBOURS

len = length(curr_Node.neighbours); % num of curr_Node's neighbours
for d = 1:len % for each neighbour, compute the costs
    edge = Edge(curr_Node, curr_Node.neighbours(d));
    edge_cost = edge.edgeCost();
    
    if k == 1 %on the start node,
        % the robot is directly facing the destination at the beginning.
        % therefore, turning costs are incurred for turning between the 
        % line-of-sight vector and edge vectors that emanate from the start
        % point.
        
        % Here, Nodes{k} is the same as curr_Node
        turning_cost = angl(LOS_vector, curr_Node.neighbours(d).coords-curr_Node.coords);
        
        total_cost = turning_cost + edge_cost;
        curr_Node.neighbours(d).updateCost(pathObj.nodes(e2), total_cost); 
            % update the cost to the checked neighbour

    else 
        if e2 > 30
            disp('ERRORRRRRRRRRRR');
            return;
        end
        turning_cost = angl(curr_Node.neighbours(d).coords-curr_Node.coords, ...
            curr_Node.coords-pathObj.nodes(e2-1).coords);
        
        total_cost = turning_cost + edge_cost;
        
        if curr_Node.neighbours(d).checkInPath(pathObj) == false % the current neighbouring node 
                                                                 % is not already in the path
            curr_Node.neighbours(d).updateCost(pathObj.nodes(e2), total_cost); 
            % update the cost to the checked neighbour
        end
    end
end
%% Costs to the current Node's neighbours have now been updated.
%  Next task is to select the cheapest to go through.

next_Node = findLeastCostNode(curr_Node.neighbours, pathObj);
%fprintf('next_Node is: %d %d\n', next_Node.coords);

pathObj.addNode(next_Node);

%fprintf('length of path.nodes after node add: %d ', length(pathObj.nodes));
k = k + 1; % increment k
%disp('Next node: ')
%disp(next_Node)
% fprintf('size of Next_Node.coords is: %d %d\n', size(next_Node.coords));
% fprintf('size of Nodes{N}.coords is: %d %d\n\n', size(Nodes{N}.coords));
if (next_Node.coords(1) ~= Nodes{N}.coords(1)) && ... 
        (next_Node.coords(2) ~= Nodes{N}.coords(2))% not at destination yet?
    dijkstraFinder = dijkstraRouteFinder(next_Node, Nodes, pathObj, k);
else
    %% WE HAVE arrived at the destination. SHOW IT!!
    disp('WE HAVE arrived at the destination');
    dijkstraFinder = pathObj.draw();
end

end

