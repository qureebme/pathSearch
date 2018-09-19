function dijkstraFinder = dijkstraRouteFinder(curr_Node, Nodes, pathObj, k)
%DIJKSTRAROUTEFINDER Summary of this function goes here
%   Detailed explanation goes here

LOS_vector = [-15 18];

N = length(Nodes);

fprintf('curr_Node.coords : %.2f %.2f\n, k is: %d', curr_Node.coords,k);
%% NOW CALCULATE THE COST OF GOING FROM THE CURRENT NODE TO
%   EACH OF ITS NEIGHBOURS

len = length(curr_Node.neighbours); % num of curr_Node's neighbours
for d = 1:len % for each neighbour, compute the costs
    edge = Edge(curr_Node, curr_Node.neighbours(d));
    edge_cost = edge.edgeCost();
    
    % k is the number of function calls
    if k == 1 %on the start node... FIRST CALL ONLY'''''''''''''''''''''''''''''''''''''
        % we will assume the robot is directly facing the destination at the beginning.
        % therefore, turning is between the line-of-sight vector and edges
        % that emanate from the start point.
        
        turning_cost = angl(LOS_vector, curr_Node.neighbours(d).coords-Nodes{1}.coords);
        
        total_cost = turning_cost + edge_cost;
        curr_Node.neighbours(d).updateCost(total_cost);% update the cost to the checked node

    else % CALLS OTHER THAN THE FIRST..............................................
        e = length(pathObj.nodes);
        if e>30
            disp('ERRORRRRRRRRRRR');
            return;
        end

        %q = pathObj.nodes(e).coords-pathObj.nodes(e-1).coords; % vector1

        %fprintf('q is : %.2f %.2f\n', q);
        %% turning_cost = angl(q, curr_Node.coords-pathObj.nodes(e).coords);
        turning_cost = 0.5; % DEBUGGING
        total_cost = turning_cost + edge_cost;
        if curr_Node.checkInPath(pathObj) == false % the current node is not in the path
            curr_Node.neighbours(d).updateCost(total_cost); % update the cost to the checked node
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

