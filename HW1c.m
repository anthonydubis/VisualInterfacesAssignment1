close all; clear all; clc;
debug = true;

% Set the desired password's gestures and corresponding quadrants
passGestures  = [Gesture.HangLoose; Gesture.HangLoose; Gesture.HangLoose];
passQuadrants = [1; 2; 5];

% Create structures to accept input
enteredGestures  = [];
enteredQuadrants = [];

% Get the image filenames
imgPath = '/Users/anthonydubis/Documents/MATLAB/VisualInterfaces/HW1/S7/';
imgType = '*.JPG'; % change based on image type
images  = dir([imgPath imgType]);

for i=1:length(images)
    imageName = [imgPath images(i).name];
    fprintf(imageName); fprintf('\n');
    
    % Get the image
    [rgb, gray, BW] = getBasicImages(imageName, debug);
    
    if isSubmitPasswordGesture(BW);
        fprintf('Submit password\n');
        break;
    else
        fprintf('Analyzing a new gesture.\n');
        
        [quadrant, gesture] = getQuadrantAndGesture(BW, debug);
        
        % If location/gesture cannot be determined, ignore the input
        if quadrant == -1
            fprintf('Unable to determine position - please try agian.\n');
            continue;
        elseif gesture == Gesture.Unsure
            fprintf('Unable to determine gesture - please try again.\n');
            continue;
        end
        
        enteredQuadrants = [enteredQuadrants; quadrant];
        enteredGestures  = [enteredGestures; gesture];
    end
end

enteredGestures
enteredQuadrants

if (passwordMatches(passGestures, passQuadrants, enteredGestures, ...
        enteredQuadrants))
    fprintf('Access Granted!');
else
    fprintf('Access Denied!');
end