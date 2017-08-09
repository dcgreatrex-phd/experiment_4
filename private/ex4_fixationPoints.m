function ex4_fixationPoints(Pointers, dotColor, dotSizePix)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try      
    % draw angle lines
    [xPosVector, yPosVector] = ex4_drawAngle(Pointers.w, -35, diameter, referent(1), referent(2), [255 255 0], 1);
    [xPosVector, yPosVector] = ex4_drawAngle(Pointers.w, -75, diameter, referent(1), referent(2), [255 255 0], 0);

    % add dot at the base of the circle
    Screen('DrawDots', Pointers.w, ... 
    	   [(rect(1) + ((rect(3)-rect(1)) / 2)) (rect(2) + ((rect(4)-rect(2)) / 2))], ...
    	   dotSizePix, dotColor, [], 2);
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------