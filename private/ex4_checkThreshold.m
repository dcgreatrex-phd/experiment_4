function [threshold] = ex4_checkThreshold(threshold, minThreshold, maxThreshold)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    threshold = threshold + 0.3;
    if threshold < minThreshold
    	threshold = minThreshold;
    elseif threshold > maxThreshold
    	threshold = maxThreshold;
    else
    	threshold = threshold;
    end
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();    % clean up:
end
%------------------------------------------