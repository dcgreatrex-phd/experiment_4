function [paMASTER, paTarget, paTestTone] = ex4_open_audioslave(targetArray, playbackFreq)
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
	%---------------------
	% initialse master audio handle
	%---------------------
	[paMASTER] = ptb_open_audiomaster(playbackFreq); % master handle
	PsychPortAudio('Volume', paMASTER, 0.5);

	%---------------------
	% open slave handles
	%---------------------
    paTarget = PsychPortAudio('OpenSlave', paMASTER, 1); % sine tone slave
    PsychPortAudio('Volume', paTarget, 1);

    %---------------------
	% initialse test tone handle
	%---------------------
	paTestTone = PsychPortAudio('OpenSlave', paMASTER, 1);         % sine tone slave
	PsychPortAudio('Volume', paTestTone, 1);

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------