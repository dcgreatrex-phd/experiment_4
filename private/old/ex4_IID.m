function [outtone] = ex4_IID(IID_db, wav, freq)
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
    
%------------- BEGIN CODE -------------- 
try 
	if IID_db > 0 					% detect left or right sound orientation
	    r_sound = 1;
	else
	    r_sound = 0;
	end
	
	%---------------------
	% interaural intensity difference (IID)
	%---------------------
	IID_db = abs(IID_db);
	IID = 10^(-IID_db/20); 			% compute generic IID

	%---------------------
	% generate IID tone
	%---------------------
	L = wav; R = wav;

	if r_sound == 1
	    outtone = [L*IID; R];
	else
	    outtone = [L; R*IID];
	end

	%---------------------
catch ME
    rethrow(ME);
end
%------------- END OF CODE --------------