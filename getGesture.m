function [ gesture ] = getGesture( fingers, palm_pt, wrist_mid_pt, debug )
% Recognizes and returns the gesture displayed by the fingers (or the lack
% there of. 
% fingers      = BW image showing the arm AND fingers with palm removed
% palm_pt      = center of palm
% wrist_mid_pt = center of wrist
% debug        = used for printing images
% gesture      = one of the Gesture enumerations

% Initialize result
gesture = Gesture.Unsure;

%{
 Get connected components (fingers/arms), their region properties, and the
 angles for the components. The number of angles returned is also the 
 number of fingers in the image.
%}
CC = bwconncomp(fingers);
stats  = regionprops(CC, 'Centroid', 'FilledArea');
angles = getFingerAngles(stats, palm_pt, wrist_mid_pt);
numFingers = length(angles);

if debug
   figure; imshow(fingers); title('Calculating Angles'); hold on;
   
   % Draw Palm Center
    palmCenter = plot(palm_pt(2), palm_pt(1), 'o', 'MarkerEdgeColor', 'b');
    set(palmCenter, 'MarkerSize', 6, 'LineWidth', 5);
    
    % Plot the wrist midpoint
    wrist_m = plot(wrist_mid_pt(2), wrist_mid_pt(1), 'o', ...
        'MarkerEdgeColor', 'b');
    set(wrist_m, 'MarkerSize', 6, 'LineWidth', 5);
    
    % Plot palm-to-wrist vector
    plot([palm_pt(2), wrist_mid_pt(2)], [palm_pt(1), wrist_mid_pt(1)], ...
        'b', 'LineWidth', 5);
    
    % Plot finger points and lines
    for i=1:length(stats)
        % Point
        centroid = stats(i).Centroid;
        cent_pt = plot(centroid(1), centroid(2), 'o', ...
            'MarkerEdgeColor', 'r');
        set(cent_pt, 'MarkerSize', 6, 'LineWidth', 3);
        
        % point-to-palm line
        plot([palm_pt(2), centroid(1)], [palm_pt(1), centroid(2)], ...
            'r', 'LineWidth', 2);
    end
    hold off;
end

% *******  Easy Cases *******
% Zero fingers - assume the user is showing a fist
if (numFingers == 0) gesture = Gesture.Fist;  return; end

% Three fingers - gesture for three
if (numFingers == 3) gesture = Gesture.Three; return; end

% Four fingers - gesture for four
if (numFingers == 4) gesture = Gesture.Four;  return; end

% Six objects means the arm and five fingers - a splay
if (numFingers == 5) gesture = Gesture.Splay; return; end
% *****  End Easy Cases  *****

% ***** More Challenging Cases *****
if numFingers == 1
    gesture = getOneFingerGesture(angles);
elseif numFingers == 2
    gesture = getTwoFingerGesture(angles);
end

end

