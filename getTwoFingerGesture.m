function [ gesture ] = getTwoFingerGesture( angles )
% getTwoFingerGesture determines the gesture based on the angles passed in
% angles  = angles sorted in increasing order
% gesture = the determined two-finger gesture

% Initialize results
gesture = Gesture.Unsure;

% Error checking
if length(angles) ~= 2
    return;
end

% Initialize constants
kPeaceSignAngle    = 30;
kMinHangLooseAngle = 85;
angleDifference    = angles(2) - angles(1); 

if  containsThumb(angles)
    fprintf('Contains thumbs');
    if angleDifference > kMinHangLooseAngle
        gesture = Gesture.HangLoose;
    else
        gesture = Gesture.Loser;
    end
elseif angleDifference < kPeaceSignAngle
    gesture = Gesture.Peace;
else
    gesture = Gesture.RockOn;
end

end

