function [outtone] = ex4_IID_Schnupp(IID_db, wav, freq)
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


% Code taken from Jan Schupp's experiment
% https://auditoryneuroscience.com/topics/ITD-ILD-practical
% relevant code is in scripts entitled: main.m && test_ILD.m within the main matlab folder

%------------------------------------------
try 
	%---------------------
	% interaural intensity difference (IID)
	%---------------------
    ILDRight=IID_db/2; 
    ILDLeft = - ILDRight; % dB
    scaleLeft=10.^(ILDLeft./20);    % amplitude
    scaleRight=10.^(ILDRight./20);
    maxVal=max([abs(scaleLeft),abs(scaleRight)]); 
    outtone=[wav.*scaleLeft ; wav.*scaleRight];
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------