function [ gesture ] = getOneFingerGesture( angles )
% Determines the one-finger gesture.
% In this system, it is either a point or a thumbs up.

% Initialize results
gesture = Gesture.Point;

% Error checking
if length(angles) ~= 1
    return
end;

if containsThumb(angles)
    gesture = Gesture.ThumbsUp;
end

end

