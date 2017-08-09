function [keyCode, startTrial, startInterval, playtimeEnd, totalDuration] = ex4_play_stimulus(Pointers, paTarget, sequenceDur, paTestTone)
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
	[~, ~, keyCode] = KbCheck(-1);% Initialize KbCheck:
	WaitSecs(0.050);
	diameter = 500;
    startInterval = 0.250.* rand(1,1) + 1.750;    % any number between 1750 - 2000 ms
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start trial
    ex4_trialTexture(Pointers, diameter);        % make onscreen trial texture
	[~, startTrial] = Screen('Flip', Pointers.w, 0); 				             
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % start sound
    ex4_trialTexture(Pointers, diameter);        % make onscreen trial texture
    when = startTrial + startInterval;
	[~, startSound] = Screen('Flip', Pointers.w, when - Pointers.slack);  
	PsychPortAudio('Start', paTarget, [], 0);    % start target sequence
	PsychPortAudio('Stop', paTarget, 3);	     % stop target sequence	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% probe tone
	when = startSound + sequenceDur + 0.250;
    PsychPortAudio('Start', paTestTone, 1, when - Pointers.slack); % start probe
	PsychPortAudio('Stop', paTestTone, 3);                                    % stop probe
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	playtimeEnd =  when - Pointers.slack;    % calculate CPU time to begin response
	totalDuration = playtimeEnd - startTrial;
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------