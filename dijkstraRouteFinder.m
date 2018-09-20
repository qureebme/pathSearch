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

fprintf('curr_Node.coords : %.2f %.2f, and k is: %d', curr_Node.coords,k);
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
        
        turning_cost = angl(LOS_vector, curr_Node.neighbours(d).coords-Nodes{k}.coords);
        
        total_cost = turning_cost + edge_cost;
        curr_Node.neighbours(d).updateCost(pathObj.nodes(e2), total_cost); 
            % update the cost to the checked neighbour

    else % other than on the start node,
        e = length(pathObj.nodes);
        if e>30
            disp('ERRORRRRRRRRRRR');
            return;
        end

        
        turning_cost = 0.5; % DEBUGGING
        total_cost = turning_cost + edge_cost;
        if curr_Node.checkInPath(pathObj) == false % the current node is not already in the path
            curr_Node.neighbours(d).updateCost(pathObj.nodes(e2), total_cost); 
            % update the cost to the checked neighbour
        end

    end
    
end
%fprintf('turning cost: %.2f, edge cost: %.2f, k2: %.2f \n', turning_cost,edge_cost, k);

% Now look at the costs at each neighbour, and choose the least of them,
%  provided that the node is not already in the path

for j2 = 1:len-1
    for j3 = j2+1:len
        if curr_Node.neighbours(j2).cost < curr_Node.neighbours(j3).cost
            % Extra check to ensure this node hasn't been selected already
            if curr_Node.neighbours(j2).checkInPath(pathObj) == false
                next_Node = curr_Node.neighbours(j2);
            end
            
        else
            if curr_Node.neighbours(j3).checkInPath(pathObj) == false
                next_Node = curr_Node.neighbours(j3);
            end
            
        end
    end
end
% the last for-loop gives us the next node to search from
pathObj.addNode(next_Node);
disp(pathObj);%%%dffffffffffffffffffffffffffffffffffffffffffffffffffffffff

fprintf('length of path.nodes after node add: %d ', length(pathObj.nodes));
k = k + 1; % increment k
if next_Node.coords ~= Nodes{N}.coords
    dijkstraFinder = dijkstraRouteFinder(next_Node, Nodes, pathObj, k);
else
    %% WE HAVE arrived at the destination. SHOW IT!!
    disp('WE HAVE arrived at the destination');
    dijkstraFinder = pathObj.draw();
end

end

