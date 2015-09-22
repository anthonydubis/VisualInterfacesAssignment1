function [max_pt1,max_pt2,max_dist] = maxDistanceBetweenSeqPoints(points)
%MAX_DISTANCE_BETWEEN_SEQUENTIAL_POINTS This function will find the two
%consecutive points in a list that are the furthest from each other
%compared to the rest. Used to identify the wrist.
%   points   = list of sequential points to compare
%   max_pt1  = one of the points in the max_distance line -> (col, row)
%   max_pt2  = the other point in the max_distance line   -> (col, row)
%   max_dist = distance between max_pt1 and max_pt2

if length(points) < 2
    throw(MExceptoin('Input size too small'));
else
    max_pt1   = points(1,:);
    max_pt2   = points(2,:);
    max_dist  = pdist([max_pt1; max_pt2], 'euclidean');
    
    for i=2:length(points)
        j = i+1;
        if (j > length(points)) 
            j = 1; 
        end;
        
        p1   = points(i,:);
        p2   = points(j,:);
        dist = pdist([p1; p2], 'euclidean');
        
        if dist > max_dist
            max_pt1  = p1;
            max_pt2  = p2;
            max_dist = dist;
        end
    end
end

