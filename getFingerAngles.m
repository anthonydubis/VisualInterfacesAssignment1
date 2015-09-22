function [ angles ] = getFingerAngles( stats, palm_pt, wrist_mid_pt )
% getFingerAngles returns the angles from the palm-to-wrist vector to the
% palm-to-finger vectors. Angles are measured in degrees and go
% counter-clockwise from the palm-to-wrist vector
%
% stats = regionprops() for the connected components (fingers/arms)
% palm_pt = palm center point
% wrist_mid_pt = center of wrist
% angles = sorted angle to fingers (note: this excludes the arm object)

% Initialize the angles vector and constants
angles        = zeros(length(stats) - 1, 1);
kMaxArmDegree = 45;

% Calculate palm-to-wrist directored vector
palmToWrist = [wrist_mid_pt(1) - palm_pt(1); ... 
    wrist_mid_pt(2) - palm_pt(2)];

idx = 1;
for i=1:length(stats)
    % Calculate palm-to-finger vector
    centroid = stats(i).Centroid;
    palmToFinger = [centroid(2) - palm_pt(1); centroid(1) - palm_pt(2)];

    % Calculate angle in radians
    angle = mod( atan2( det([palmToWrist, palmToFinger]), ... 
        dot(palmToWrist, palmToFinger) ), 2*pi);

    % Convert to degrees
    angle = angle / pi * 180;
    
    % If this is the arm - do not include it in the angles vector
    if angle < kMaxArmDegree || angle > 360 - kMaxArmDegree
        continue;
    end
    
    angles(idx) = angle;
    idx = idx + 1;
end

angles = sort(angles);

end

