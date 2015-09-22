function [ fingers ] = getFingers(BW, palm_mask_pts, palm_r, debug)
% This function removes the palm from the BW image and returns the fingers
% and part of the arm in the return image. 

% Get the palm's mask from the boundary points
palm_mask = roipoly(BW, palm_mask_pts(:,1), palm_mask_pts(:,2));
palm_mask = imrotate(palm_mask, 270);
palm_mask = flip(palm_mask,2);

% Dialation the mask so that it eliminates bumps from fingers not a part of
% the gesture.
d_struct      = strel('disk', double(round(palm_r/1.5)));
expanded_mask = imdilate(palm_mask, d_struct);

if debug
    figure;
    imshow(palm_mask); title('Palm Mask');
    
    figure; 
    imshow(palm_mask); title('Palm Mask w/ Boundary Points'); 
    hold on;
    plot(palm_mask_pts(:,2), palm_mask_pts(:,1), 'co');
    hold off;
    
    figure; imshow(expanded_mask); title('Expanded Palm Mask'); 
end

% Subtract the palm mask from the original image, round negative values up
% to 0
fingers = BW - expanded_mask;
fingers = max(fingers, 0);

if debug
    figure; imshow(fingers);
end

end

