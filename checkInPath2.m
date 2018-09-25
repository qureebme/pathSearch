function checker2 = checkInPath2(node,pathObj)
%CHECKINPATH2 Summary of this function goes here
%   Detailed explanation goes here
answer = false;
for i = 1:length(pathObj.nodes)
    d = pathObj.nodes(i).coords == node.coords;
    if sum(d) == 2%(d(1) == 1) && (d(2) == 1)
        answer = true; % This node is already in the path
        break; % That's it. No point going on!
    end
end
checker2 = answer;
end

