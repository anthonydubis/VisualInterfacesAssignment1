function [ quad ] = getQuadrant( BW, point, debug )
% get_object_location returns the HorizontalLocation and VerticalLocation
% BW       = a square binary image
% point    = the point (row, col) located in the grid
% quadrant = quadrant the point lands in
%
% There are 9 quadrants in the following form:
%  | 1 | 2 | 3 |
%  | 4 | 5 | 6 |
%  | 7 | 8 | 9 |
% There's "deadspace" margin around each quadrant. If the point lands in
% this deadspace, the system will assume the user was not clear enough in
% his intentions and ignore the gesture.

% Although the point is stored in (row, col) form, lets abract to (x, y)
size = length(BW);
x    = point(2);
y    = point(1);

% margin = area around square targets designating deadspace
margin = .05 * size; 

% side = length of a side of square quadrant 
side = (size - 4 * margin) / 3;

if debug
    figure; imshow(BW); hold on;
    % Draw hand centroid
    center = plot(point(2), point(1), 'o', 'MarkerEdgeColor', 'r');
    set(center, 'MarkerSize', 6, 'LineWidth', 3);
end

quad = -1;
for r=1:3
    for c=1:3
        quad_x = c * margin + (c - 1) * side;
        quad_y = r * margin + (r - 1) * side;
        if (x > quad_x && x < quad_x + side)
            if (y > quad_y && y < quad_y + side)
                quad = c + (r - 1) * 3;
            end
        end
        
        if debug
            rectangle('Position',[quad_x, quad_y, side, side], ...
                'EdgeColor', 'r', 'LineWidth', 2);
        end
    end
end

if debug 
    hold off;
end

end

