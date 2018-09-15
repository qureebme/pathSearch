classdef Edge
    
    properties
        node1
        node2
        cost % the cost of traversing this edge 
    end
    
    methods
        function EdgeObj = Edge(node1,node2)% constructor
            EdgeObj.node1 = node1;
            EdgeObj.node2 = node2;
        end
        
        function length = getLength(self)
            p1 = self.node1.coords; % p1 and p2 are themselves...
            p2 = self.node2.coords; % Node objects
            length = sqrt((p1(1)-p2(1))^2 + (p1(2)-p2(2))^2);
        end
        
        %the cost of traversing this edge only.
        %turning cost is not included.
        function cost = getCost(self)
            cost = self.getLength * self.cost;
        end
        
        function draw = draw(self)
            hold on
            X = [self.node1.coords(1) self.node2.coords(1)];
            Y = [self.node1.coords(2) self.node2.coords(2)];
            draw = plot(X,Y); % draw this edge.
        end
        
    end
end

