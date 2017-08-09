function newMean = staircase_2u1d(mu, isCorrectList, stepSize)
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
    
%------------- BEGIN CODE ---------------
try  
	% initialize input variables
    outcome = isCorrectList(end);

    if length(isCorrectList) > 1

    	% initialize input variables
        outcomeLag1 = isCorrectList(end - 1);
    	
    	% implement the staircasing rule
    	if outcomeLag1 == 1 && outcome == 1

    		if mu < stepSize
    			newMean = 0;
    		else
    		    newMean = mu - stepSize;
    	    end
    
        elseif outcomeLag1 == 1 && outcome == 0
        	
            newMean = mu + stepSize;
        
        elseif outcomeLag1 == 0 && outcome == 0  
        
        	newMean = mu + stepSize;
        
        elseif outcomeLag1 == 0 && outcome == 1
            newMean = mu;
        end
    else
        newMean = mu;            
    end 
        
    %---------------------
catch ME
    rethrow(ME);
end
%------------- END OF CODE --------------