function [ matches ] = passwordMatches( passGestures, passQuadrants, ...
    enteredGestures, enteredQuadrants )
% Tests to see if the entered password matches

matches = true;

if length(passQuadrants) ~= length(enteredQuadrants)
    matches = false;

else
    for i=1:length(passQuadrants)
        if passQuadrants(i) ~= enteredQuadrants(i)
            matches = false;
        elseif passGestures(i) ~= enteredGestures(i)
            matches = false;
        end
    end
end
            
end

