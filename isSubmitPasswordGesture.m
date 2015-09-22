function [ isSubmitGesture ] = isSubmitPasswordGesture( BW )
% Determines if the BW image is the 'OK' sign by determining if there are
% more than one boundary. In this case, it would be an inner boundary for
% the circle created by making the 'OK' gesture.

isSubmitGesture = false;
B = bwboundaries(BW);
numBoundaries = length(B);
kMinBoundryPtsForSubmission = 75;

if numBoundaries > 2
    pts_per_bdry = [numBoundaries, 1];
    for i=1:numBoundaries
        bdry = B{i};
        pts_per_bdry(i) = length(bdry);
    end

    pts_per_bdry = sort(pts_per_bdry, 'descend');
    
    if pts_per_bdry(2) > kMinBoundryPtsForSubmission
        isSubmitGesture = true;
    end
end

end

