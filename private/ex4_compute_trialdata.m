function [ResponseData] = ex4_compute_trialdata(ResponseData, Response, testLevel)
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
    RT = round((ResponseData.endResponse - ResponseData.startResponse) * 1000) / 1000; % response time
    pressedKey = KbName(ResponseData.keyCode); % key pressed by subject

    doubleResponse = length(pressedKey) > 1 ;
    if  (doubleResponse)                  % assign category response id (single value integer)
        pressedKey = 'NR';
        answer = 0;
    else
        if pressedKey == KbName(Response.left)
            answer = -1;                  % left
        elseif pressedKey == KbName(Response.right) 
            answer = 1;                   % right
        else
            pressedKey = 'NR';
            answer = 0;                   % no response
        end
    end

    if abs(answer) > 0
        if testLevel < 0 && answer == 1                % was the participants repsonse correct?
            isCorrect = 1;
        elseif testLevel > 0 && answer == -1           % was the participants repsonse correct?
            isCorrect = 1;
        else
            isCorrect = 0; 
        end
    else
        isCorrect = 0;
    end

    % append computed data to the responseData structure
    [ResponseData(:).RT] = RT;
    [ResponseData(:).pressedKey] = pressedKey;
    [ResponseData(:).answer] = answer;
    [ResponseData(:).isCorrect] = isCorrect;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------