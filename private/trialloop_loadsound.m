function [paTarget, Sequence, paTestTone] = trialloop_loadsound(Stimuli, Sequence)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    % open audio slave for each targetArray
    [paMASTER, paTarget, paTestTone] = ex4_open_audioslave(Sequence.targetArray, Stimuli.playbackFreq);

    % assign localised noise bursts to an audioslave
    [pabufTarget] = ex4_load_audioslave(paTarget, Sequence.targetArray, Stimuli, ...
                                       Sequence.mu, Sequence.testLevel, paTestTone);
    
    % create audio schedule - requires array input
    duration = ex4_open_audioschedule(Stimuli.periodicIOI, paTarget, ...
                                         pabufTarget, Sequence.IOIarray);

    % update the Sequence structure with the duration value
    [Sequence(:).duration] = duration;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------