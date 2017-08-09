function ex4_feedback(ResponseData, Sequence, Pointers, isSound)
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
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% make onscreen trial texture
	if Sequence.isPractice == 1
	    referent = ex4_trialTexture(Pointers, 500); 
        
        % draw tone onscreen
        targetLevel = Sequence.mu + Sequence.testLevel;
        if targetLevel >= 0
    		toneAngle = (90 / 20) * targetLevel;
    		toneAngle = toneAngle - 90;
        else
        	toneAngle = (-90 / -20) * targetLevel;
        	toneAngle = toneAngle - 90;
        end
	    ex4_drawAngle(Pointers.w, toneAngle, 500, referent(1), referent(2), [255 255 255], 0);
        
        % draw average onscreen
	    mu = Sequence.mu;
	    muAngle = (90 / 20) * mu;
	    muAngle = muAngle - 90;
	    ex4_drawAngle(Pointers.w, muAngle, 500, referent(1), referent(2), [0 0 0], ...
	                  1, ResponseData.isCorrect);
	    
	    % present feedback onscreen
		Screen('Flip', Pointers.w, 0);  
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% play feedback sound if requested
	if isSound == 1
	    if ResponseData.isCorrect ~= 1    % beep if choice and trial variables do not match      
	        beep; 
	    end
	end
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------