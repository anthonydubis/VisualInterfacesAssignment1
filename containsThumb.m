function [ hasThumb ] = containsThumb( angles )
% containsThumb determines if a thumb is present in the gesture based on
% the finger angles. Theis within 135 degrees of the palm-to-wrist point
%
% angles = angles sorted in increasing order
% hasThumb = boolean, true if a thumb angle exists

% Initialize results and constants
hasThumb       = false;
kMaxThumbAngle = 135;

for i=1:length(angles)
    if (angles(i) < kMaxThumbAngle) || (angles(i) > (360 - kMaxThumbAngle))
        hasThumb = true;
        break;
    end
end

