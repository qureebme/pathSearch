# pathSearch
implementation of a few path search algorithms


Here I'm implementing path search algorithms, which find the 'cheapest' path between two nodes in a graph. To move between two nodes
the traveler incurs two kinds of costs:

an edge cost, which is the distance between the two nodes;

a turning cost, which depends on the angle between the most recently traversed edge

    and the one currently under inpection.

In this implementation,

edge cost = Euclidean distance between two connected nodes.

turning cost = the change in angular direction (in radian) between two consecutive traversed edges,

          multiplied by a constant factor. (see angl.m, line 5)
          
          The higher this factor, the higher the penalty on turning.
          
main file: dijkstra.m
CAUTION: This code is incomplete, so it doesn't always find a path, even though one might exist. Fixing...

Language: MATLAB
