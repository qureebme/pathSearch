classdef Path < handle
    %PATH Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nodes = [];
    end
    
    methods
        % This constructor takes the start node as an argument
        function PathObj = Path(node) % constructor
            PathObj.nodes = node;
        end
        
        function addNode = addNode(self, node)
            self.nodes = [self.nodes, node];
            addNode = '';
        end
        
%         function draw = draw(self) % draw this path
%             n = length(self.nodes);
%             for i = 1:n-1
%                 for j = i+1:n
%                     X = [self.nodes(i).coords(1) self.nodes(j).coords(1)];
%                     Y = [self.nodes(i).coords(2) self.nodes(j).coords(2)];
%                     draw = plot(X,Y,'r-','LineWidth',3);
%                     break;
%                 end
%             end
%         end
        function draw = draw(self) % draw this path
            n = length(self.nodes);
            for i = 1:n-1
                for j = i+1:n
%                     X = [self.nodes(i).coords(1) self.nodes(j).coords(1)];
%                     Y = [self.nodes(i).coords(2) self.nodes(j).coords(2)];
                    draw = quiver(self.nodes(i).coords(1),self.nodes(i).coords(2),...
                         self.nodes(j).coords(1)-self.nodes(i).coords(1),...
                          self.nodes(j).coords(2)-self.nodes(i).coords(2),0,...
                      'r-','LineWidth',2);
                  hold on;
                  pause(0.5);
                    break;
                end
            end
        end
    end
end

