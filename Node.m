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
            neighbours = self.neighbours;
        end
        
        function update = updateCost(neighb_node, curr_node, total_cost)
            % curr_node is the last node the pathObj
            % neighb_node is a neighbour of curr_Node
            % total_cost is the cost of going from curr_Node to neighb_node
            neighb_node.cost = min(neighb_node.cost, curr_node.cost + total_cost);
            update = [];
        end
        
        function checker = checkInPath(self, path)
            %CHECKINPATH Summary of this function goes here
            %   Detailed explanation goes here
            answer = false;
            for p = 1:length(path)
                if self.coords == path.nodes(p).coords
                    answer = true; % the node is already in the path
                end
            end
            checker = answer;
        end
        
        function draw = draw(self)
            draw = plot(self.coords(1), self.coords(2), 'b*');
        end
        
    end
end

