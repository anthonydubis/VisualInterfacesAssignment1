function [ quadrant, gesture ] = getQuadrantAndGesture( BW, debug )
% getQuadrantAndGesture() will give back the quadrant location and gesture
% as determined by the system.
% BW       = black white image of input where the skin is white
% debug    = prints relavant images if true
% quadrant = 1 of 9 quadrants the hand can be in, or -1 if undetermined
% gesture  = one of the recognized gestures, or Unsure if undetermined

% Initialize the results and other varaibles
quadrant = -1;
gesture  = Gesture.Unsure;
imgSize  = length(BW);

% Get palm center, and palm radius, and palm boundary points (for mask)
[palm_pt, palm_r, palm_mask_pts] = getPalmProperties(BW, debug);
palm_d = palm_r * 2;

% Get wrist endpoints and midpoint
[wrist_p1, wrist_p2] = maxDistanceBetweenSeqPoints(palm_mask_pts);
wrist_mid_pt = [(wrist_p1(1) + wrist_p2(1)) / 2, ...
    (wrist_p1(2) + wrist_p2(2)) / 2];

% Get the approximate hand centroid
centroid = getApproximateHandCentroid(palm_pt, wrist_mid_pt, imgSize);

% Take a second to debug and see how our numbers are looking
if debug
    figure; imshow(BW);
    hold on;
    
    % title('Palm Center and Circle'); 
    
    % Draw Palm Center
    palmCenter = plot(palm_pt(2), palm_pt(1), 'o', 'MarkerEdgeColor', 'b');
    set(palmCenter, 'MarkerSize', 6, 'LineWidth', 3);
    
    % Draw palm circle
    innerCircle = plot(palm_pt(2), palm_pt(1), 'o', ...
        'MarkerEdgeColor', 'b');
    set(innerCircle, 'MarkerSize', palm_r*2, 'LineWidth', 3);
    
    % Draw hand centroid
    center = plot(centroid(2), centroid(1), 'o', 'MarkerEdgeColor', 'r');
    set(center, 'MarkerSize', 6, 'LineWidth', 3);
    
    % Draw wrist points
    wrist_pt1 = plot(wrist_p1(2), wrist_p1(1), 'o', ...
        'MarkerEdgeColor', 'g');
    set(wrist_pt1, 'MarkerSize', 6, 'LineWidth', 3);
    wrist_pt2 = plot(wrist_p2(2), wrist_p2(1), 'o', ...
        'MarkerEdgeColor', 'g');
    set(wrist_pt2, 'MarkerSize', 6, 'LineWidth', 3);
    
    % Connect wrist points
    plot([wrist_p1(2), wrist_p2(2)], [wrist_p1(1), wrist_p2(1)], ...
        'g', 'LineWidth', 5);
    
    % Plot the wrist midpoint
    wrist_m = plot(wrist_mid_pt(2), wrist_mid_pt(1), 'o', ...
        'MarkerEdgeColor', 'b');
    set(wrist_m, 'MarkerSize', 6, 'LineWidth', 3);
    
    hold off;
end

% Get the quadrant and return early if the hand can't be placed
quadrant = getQuadrant(BW, centroid, debug);
if (quadrant == -1)
    return
end

% Get the fingers by removing the palm and doing the analysis
fingers = getFingers(BW, palm_mask_pts, palm_r, debug);
gesture = getGesture(fingers, palm_pt, wrist_mid_pt, debug);

end

