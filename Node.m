classdef Node
    
    properties
        coords
        hasNeighbours = false
        neighbours = []
    end
    
    methods
        % constructor
        function NodeObj = Node(coords) % coords = [x y]
            NodeObj.coords = coords;
        end
        
        function neighbours = showNeighbours(self)
            neighbours = self.neighbours;
        end
        
    end
end

