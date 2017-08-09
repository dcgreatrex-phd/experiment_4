function threshold  = staircase_trialloop(Pointers, Stimuli, Response, datafilepointer)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try  
    levelList = [Stimuli.startLevel];
    isCorrectList = [];
    firstError = false;
    reversal = 0;    
    outBounds = 0;
    index = 1;
    thresholdList = [];
    while true
        % randomly assign rhythmic flag: 1 = Periodic, 0 = Aperiodic
        if round(rand) == 1
            isPeriodic = 1;
            if round(rand) == 1
                signOfMean = 1;
                testLevel = levelList(end);
            else
                signOfMean = -1;
                testLevel = levelList(end);
                testLevel = testLevel * signOfMean;
            end
        else
            isPeriodic = 0;
            if round(rand) == 1
                signOfMean = 1;
                testLevel = levelList(end);
            else
                signOfMean = -1;
                testLevel = levelList(end);
                testLevel = testLevel * signOfMean;
            end
        end

        % random integer between [-4, -2, 0, 2, 4]. Change in dB intensity
        direction = randi([-2 2],1,1);
        mu = Stimuli.absRange * direction;

        % compute target array and return sequence information
        [Sequence] = trialloop_definesequence(Stimuli, mu, isPeriodic, testLevel, index);
        [Sequence(:).isPractice] = 0;

        % load audio sequence into audio buffers ready for playback
        [paTarget, Sequence, paTestTone] = trialloop_loadsound(Stimuli, Sequence);

        % play trial sequence, compute trial data
        ResponseData = trialloop_playtrial(Pointers, Sequence, Response, paTarget, paTestTone);

        % compute staircase
        [levelList, isCorrectList, firstError, ...
        reversal, outBounds, thresholdList] = staircase_compute(Stimuli, Sequence, ...
                                                                ResponseData, levelList, ...
                                                                isCorrectList, firstError, ...
                                                                reversal, outBounds, ...
                                                                thresholdList);

        % save trial data
        staircase_savedata(Pointers.subNo, datafilepointer, Sequence, ResponseData, reversal)

        % assess reversals
        if reversal >= Stimuli.noReversals
            break;
        end

        % assess out of bounds
        if outBounds > 2;
            disp('%%%% MORE PRACTICE IS REQUIRED ON THE TASK... ABORTING CURRENT SESSION %%%%');
            break
        end

        % update trial index
        WaitSecs(0.200);
        index = index + 1;
    end
    threshold = mean(thresholdList(5:10));
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------