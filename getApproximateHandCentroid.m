function [centroid] = getApproximateHandCentroid(palm_pt, wrist_pt, bounds)
% Approximate the hand's centroid since the arm would skew the centroid of
% the entire image.
% palm_pt  = the palm's center (row, col)
% wrist_pt = midpoint of wrist (row, col)
% centroid = returns (x, y) coordinates with top-left as the origin

% % Use palm center as centroid
% centroid = [palm_pt(2), palm_pt(1)];
% return;

row_diff = (wrist_pt(1) - palm_pt(1));
col_diff = (palm_pt(2) - wrist_pt(2));

% Determine the new point
% Potentially don't move by the full difference (adjust by multiplier)
multiplier = .5;
row = palm_pt(1) - (row_diff * multiplier);
col = palm_pt(2) + (col_diff * multiplier);

% Handle issues where you go outside the bounds of the image
if (row < 1)      row = 1;      end
if (row > bounds) row = bounds; end
if (col < 1)      col = 1;      end
if (col > bounds) col = bounds; end

centroid = [row, col];

end

