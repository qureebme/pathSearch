function leastCostNode = findLeastCostNode(nodeArray, pathObj)
%FINDLEASTCOSTNODE selects the node with least cost from an array of nodes.
% It also checks to ensure that this node is not already in the optimal path

array2 = Node([]); % array initialized for Node objects
for i = 1:length(nodeArray)
    if (nodeArray(i).checkInPath(pathObj) == false)
        array2(length(array2)+1) = nodeArray(i); % select only nodes that are not yet in the path
    end
    
end

array2(1) = ''; % remove the first (dummy) Node object
% array2 now contains members of nodeArray which aren't already in the path
if length(array2) == 0
    fprintf('There is no viable path to the destination.\n');
    fprintf('Please run the program again or increase the number of nodes.\n');
    pathObj.draw();
    leastCostNode = [];
    return;
end

array2costs(length(array2)) = 0; % row matrix of zeros
for j = 1:length(array2)
    array2costs(j) = array2(j).cost; % add cost values to array2costs
end
% c = find(array2costs == min(array2costs));
c = logical(array2costs == min(array2costs));
leastCostNode = array2(c);
end