function [palm_pt, palm_r, mask_pts] = getPalmProperties(BW, debug)
% getPalmProperties takes in a binary image assumed to be a hand in any
% guesture and returns certain properties.
% palm_x   = the x location of the palm (column in BW)
% palm_y   = the y location of the palm (row in BW)
% palm_r   = the palms radius from center to nearest edge of hand
% mask_pts = boundary points around palm (used to construct mask)

% Create distance map - for each pixel in ~BW, determine distance to 
% nearest nonzero pixel ~BW so that the hand is 0s and the background is 1s
% IDX holds the cloest pixel to a location as an index array
% See image output for visual
[D, IDX] = bwdist(~BW);

% The max value in D will give us the pixel in the hand that is furthest
% from any edge of the hand. This can be assumed to be the center of the
% palm. The value of D at this location is the palms radius.
[palm_r, max_loc] = max(D(:));
[palm_y, palm_x]  = ind2sub(size(D), max_loc);
palm_pt = [palm_y, palm_x];

if (debug) 
    figure, imshow(D,[]); title('Distance Transform'); 
end;

% Get boundary points around palm to aid in a mask creation
max_pt = length(BW);
min_pt = 1;
degrees_in_circle = 360;
mask_pts = zeros(degrees_in_circle, 2);
for angle=1:degrees_in_circle
    col = round(cos(angle * pi / 180) * palm_r*1.0 + palm_x);
    row = round(sin(angle * pi / 180) * palm_r*1.0 + palm_y);

    if (col < min_pt)   col = 1;   end;
    if (col > max_pt)   col = 350; end;
    if (row < min_pt)   row = 1;   end;
    if (row > max_pt)   row = 350; end;

    if BW(row, col) == 0
        mask_pts(angle,:) = [row col];
    else
        [bound_row, bound_col] = ind2sub(size(BW), IDX(row, col));
        mask_pts(angle,:) = [bound_row bound_col];
    end
end

end

