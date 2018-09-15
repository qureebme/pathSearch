classdef Node
    
    properties
        coords
        hasNeighbours = false
        neighbours = [] % list of node locations [x,y] ONLY.
                        % each neighboring node is added as a
                        % new row.
    end
    
    methods
        % constructor
        function NodeObj = Node(coords) % coords = [x y]
            NodeObj.coords = coords;
        end
        
        function neighbours = showNeighbours(self)
            neighbours = self.neighbours;
        end
        
        function draw = draw(self)
            draw = plot(self.coords(1), self.coords(2), 'b*');
        end
        
    end
end

