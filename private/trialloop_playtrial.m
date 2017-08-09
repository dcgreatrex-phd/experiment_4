function ResponseData = trialloop_playtrial(Pointers, Sequence, Response, paTarget, paTestTone)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    while KbCheck; end    % flush keyboard events
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % play sequence
    [keyCode, startTime, startInterval, playtimeEnd, totalDuration] = ex4_play_stimulus(Pointers, ...
                                                          paTarget, Sequence.duration, ...
                                                          paTestTone);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get trial data
    ResponseData = ex4_get_trialdata(Pointers, Response, keyCode, playtimeEnd, Sequence);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute trial data
    ResponseData = ex4_compute_trialdata(ResponseData, Response, Sequence.testLevel);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % present feedback
    ex4_feedback(ResponseData, Sequence, Pointers, 0)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % update response data structure
    [ResponseData(:).startInterval] = startInterval;
    [ResponseData(:).totalDuration] = totalDuration;  
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------