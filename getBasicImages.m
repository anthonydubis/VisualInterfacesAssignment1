function [ rgb, gray, BW ] = getBasicImages( imageName, debug )
% Gets the rgb, grayscale, and BW images given the image file name
% debug is a boolean to determine if the images should be displayed

% Grayscale threashold for binary image
kThresh = 60/255;

rgb  = imread(imageName);
gray = rgb2gray(rgb);
BW   = im2bw(gray, kThresh);

% Eliminate tiny components caused by lint or some odd reflection of light
BW   = bwareaopen(BW, 20);
if debug
    % figure, imshow(rgb);  title('Original Image');
    % figure, imshow(gray); title('Grayscale Image');
    figure, imshow(BW);   title('Binary Image');
end

end

