function referent = ex4_trialTexture(Pointers, diameter)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try     
    extra = (diameter/2); % displacement of the circle from mid point
    
    rect = [Pointers.coordinates(1) - diameter, ... % draw a rectangle with stated diameter, mid point is centered at 1/4 height.
           (Pointers.coordinates(2) - diameter + extra), ...
            Pointers.coordinates(1) + diameter, ...
            Pointers.coordinates(2) + diameter + extra];
    
    % referent point on the arc [x, y]
    referent =  [rect(1) + ((rect(3)-rect(1)) / 2), ...
                 rect(2) + ((rect(4)-rect(2)) / 2)];

    % draw semi circle and fill with colour
    Screen('FillOval', Pointers.w, [127 127 127], [rect]);
    Screen('FrameArc',Pointers.w, [0 0 0], rect,0,90, [5], [5], []);
    Screen('FrameArc',Pointers.w, [0 0 0], rect,0,-90, [5], [5], []);

    % draw horizontal line across the bottom of the arc.
    Screen('DrawLine', Pointers.w, [0 0 0], rect(1), ... 
                                            rect(2) + ((rect(4)-rect(2)) / 2), ... 
                                            rect(3), ...
                                            rect(2) + ((rect(4)-rect(2)) / 2), ...
                                            [5]); 

    % draw vertical line onto the arc.
    Screen('DrawLine', Pointers.w, [0 0 0], rect(1) + ((rect(3)-rect(1)) / 2), ...
                                            rect(2), ...
                                            rect(1) + ((rect(3)-rect(1)) / 2), ...
                                            rect(2) + ((rect(4)-rect(2)) / 2), ...
                                            [5]); % vertical line
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------