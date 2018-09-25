function leastCostNode = findLeastCostNode(nodeArray, pathObj)
%FINDLEASTCOSTNODE selects the node with least cost from an array of nodes.
% It also checks to ensure that this node is not already in the optimal path
array2 = Node([]); % array2 initialized for Node objects
for i = 1:length(nodeArray)
    if (nodeArray(i).checkInPath(pathObj) == false)
        array2(length(array2)+1) = nodeArray(i);
    end
    
end

array2(1) = '';
% array2 now contains members of nodeArray which aren't already in the path
% if sum(size(array2)) == 1
%     fprintf('THERE IS NO PATH TO THE DESTINATION\n');
%     return;
% end
array2costs(length(array2)) = 0; %row matrix of zeros
for j = 1:length(array2)
    array2costs(j) = array2(j).cost;
end
% c = find(array2costs == min(array2costs));
c = logical(array2costs == min(array2costs));
leastCostNode = array2(c);
end