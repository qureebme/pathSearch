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
        
        function update = updateCost(self, cost)
            if self.cost == Inf %the node has never been checked out before
                self.cost = cost;
            else
                self.cost = self.cost + cost;
                update = [];
            end
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

