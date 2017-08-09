function ex4_drawAngle(w, anglesDeg, diameter, startx, starty, colour, isLine, isCorrect)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    if nargin < 8
        isCorrect = -1;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % define feedback colours
    if isCorrect == 1
        answerColour = [0 255 0];
    elseif isCorrect == 0
        answerColour = [255 0 0];
    else
        answerColour = colour;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % draw feedback angled line or dot as requested
    anglesRad = anglesDeg * (pi / 180);
    radius = diameter + 50;
    xPosVector = cos(anglesRad) .* radius + startx;
    yPosVector = sin(anglesRad) .* radius + starty;
    if isLine 
        Screen('DrawLine', w, answerColour, startx, ...
                                        starty, ...
                                        xPosVector, ...
                                        yPosVector, ...
                                         [5]);     % vertical line
    else
        Screen('DrawDots', w, [xPosVector yPosVector], 15, answerColour, [], 2);
    end
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();                                     % clean up:
end
%------------------------------------------