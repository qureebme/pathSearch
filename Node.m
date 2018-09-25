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
        
        function update = updateCost(neighb_node, curr_node, total_cost)
            % curr_node is the last node the pathObj
            % neighb_node is a neighbour of curr_Node. We're currently
            % analysing this neighbour.
            % total_cost is the cost of going from curr_Node to neighb_node
            neighb_node.cost = min(neighb_node.cost, curr_node.cost + total_cost);
            update = [];
        end
        
        function checker = checkInPath(self, path)
            answer = false;
            for p = 1:length(path.nodes)
                %d = self.coords == path.nodes(p).coords;
                %fprintf('p is: %d, d1 is: %d, d2 is: %d',p,d(1),d(2));
                if self.coords == path.nodes(p).coords
                    answer = true; % the node is already in the path
                    break;
                end
            end
            checker = answer;
        end
        
        function draw = draw(self)
            draw = plot(self.coords(1), self.coords(2), 'b*');
        end
        
    end
end

