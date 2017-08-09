function [Sequence] = trialloop_definesequence(Stimuli, mu, isPeriodic, testLevel, index)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    % generate target array
    [targetArray, ~] = ex4_compute_pattern_complexity(mu, Stimuli.gapBetweenTones);

    % calculate the IOI array
    IOIarray = {};
    nTarget = Stimuli.nTarget - 1;
    IOIarray = ex4_compute_ioiarray(isPeriodic, nTarget, Stimuli.periodicIOI);

    % build structure
    f1 = 'targetArray';    v1 = {targetArray};
    f2 = 'mu';             v2 = mu;
    f3 = 'testLevel';      v3 = testLevel;
    f4 = 'isPeriodic';     v4 = isPeriodic;
    f5 = 'IOIarray';       v5 = {IOIarray};
    f6 = 'index';          v6 = index;

    Sequence = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
                      f5, v5, f6, v6);

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------