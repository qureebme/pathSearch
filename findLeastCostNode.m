function leastCostNode = findLeastCostNode(nodeArray, pathObj)
%FINDLEASTCOSTNODE selects the node with least cost from an array of nodes.
% It also checks to ensure that this node is not already in the optimal path
array2 = Node([]); % array2 initialized for Node objects
for i = 1:length(nodeArray)
    if (nodeArray(i).checkInPath(pathObj) == false)
        array2(length(array2)+1) = nodeArray(i);
        %array2 = [array2, nodeArray(i)];
    end
    
end

array2(1) = ''; % remove the first (empty) Node object
% array2 now contains members of nodeArray which aren't already in the path
if length(array2) == 0
    fprintf('Optimal route cannot contain loops.\n');
    fprintf('   Please run the program again.\n');
    leastCostNode = [];
    return;
end

array2costs(length(array2)) = 0; % row matrix of zeros
for j = 1:length(array2)
    array2costs(j) = array2(j).cost; % add cost values to aaray2costs
end
% c = find(array2costs == min(array2costs));
c = logical(array2costs == min(array2costs));
leastCostNode = array2(c);
end