function [ResponseData] = ex4_get_trialdata(Pointers, Response, keyCode, playtimeEnd, Sequence)
%FUNCTION_HEADER - 
% 
% Syntax:  [y] = FUNCTION_HEADER(x)
%
% Input: 
%           x:             
%
% Output:
% 
%           y:            
%
% Example:
%
%           [y] = FUNCTION_HEADER(x)
%
% m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: David C Greatrex
% Work Address: Centre for Music and Science, Cambridge University
% email: dcg32@cam.ac.uk
% Website: http://www.davidgreatrex.com
% mmm YYYY; Last revision: DD-MM-YYYY
    
%------------------------------------------
try
    diameter = 500;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % make onscreen trial texture
    referent = ex4_trialTexture(Pointers, diameter);
    % draw probe tone position
    if Sequence.isPractice == 1
        targetLevel = Sequence.mu + Sequence.testLevel;
        if targetLevel >= 0
    		toneAngle = (90 / 20) * targetLevel;
    		toneAngle = toneAngle - 90;
        else
        	toneAngle = (-90 / -20) * targetLevel;
        	toneAngle = toneAngle - 90;
        end
        ex4_drawAngle(Pointers.w, toneAngle, diameter, referent(1), referent(2), [255 255 255], 0)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start response period
    [~, startResponse] = Screen('Flip', Pointers.w, playtimeEnd - Pointers.slack);    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check for keyboard responses
	[keyCode, endResponse] = ml_reactiontime(keyCode, startResponse, ...    
										Response.timeoutDur, ...
										Response.left, ...
										Response.right); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save data in the ResponseData structure
	f1 = 'startResponse'; v1 = startResponse;
	f2 = 'endResponse';   v2 = endResponse;
	f3 = 'keyCode';       v3 = keyCode;
	ResponseData = struct(f1, v1, f2, v2, f3, v3);
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------