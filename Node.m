classdef Node < handle
    
    properties
        coords
        hasNeighbours = false
        cost = Inf
        neighbours = [] % list of neighbouring nodes                   
    end
    
    methods
        % constructor
        function NodeObj = Node(coords) % coords = [x y]
            NodeObj.coords = coords;
        end
        
        function neighbours = showNeighbours(self)
            for i = 1:length(self.neighbours)
                neighbours = disp(self.neighbours(i));
            end
        end
        
        function update = updateCost(neighb_node, curr_node, total_cost, path)
            % curr_node is the last node added to pathObj
            % neighb_node is a neighbour of curr_Node. We're currently
            % checking this neighbour.
            % total_cost is the cost of going from curr_Node to neighb_node
            
            % However, this cost need not be updated if the checked node
            % is already along the path.
            if (neighb_node.checkInPath(path) == false)
                neighb_node.cost = min(neighb_node.cost, curr_node.cost + total_cost);
            end
            
            update = [];
        end
        
        function checker = checkInPath(self, path)
            answer = false;
            for p = 1:length(path.nodes)
                if self.coords == path.nodes(p).coords
                    answer = true; % the node is already in the path
                    break;
                end
            end
            checker = answer;
        end
        
        function draw = draw(self)
            draw = plot(self.coords(1), self.coords(2), 'bo');
        end
        
    end
end

