function newMean = staircase_3u1d(mu, isCorrectList, stepSize)
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
	% initialize input variables
    outcome = isCorrectList(end);

    if length(isCorrectList) > 1
    	
    	% implement the staircasing rule
    	if outcome == 1

    		if mu < stepSize
    			newMean = 0;
    		else
    		    newMean = mu - stepSize;
    	    end
    
        elseif outcome == 0
        	
            newMean = mu + stepSize * 3;
        end
    else
        newMean = mu;            
    end 
        
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------