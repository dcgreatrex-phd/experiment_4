function [levelList, isCorrectList, firstError, reversal, outBounds, thresholdList] = staircase_compute(Stimuli, Sequence, ResponseData, levelList, isCorrectList, firstError, reversal, outBounds, thresholdList)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try  
    % only process if the current trial has an aperiodic rhythm
    switch Sequence.isPeriodic
        case 1
            i = 0;
        otherwise
            i = 1;
    end

    if i == 1

        testLevel = abs(Sequence.testLevel);

        isCorrectList(length(isCorrectList) + 1) = ResponseData.isCorrect;    % update Periodic isCorrect list

        % compute reversals
        up3 = 1;
        if up3 == 1
            if length(isCorrectList) >= 2
                a = [isCorrectList(end - 1), isCorrectList(end)];       
                c1 = [1, 0];
                c2 = [0, 1];
                if a == c1
                    reversal(i) = reversal(i) + 1;
                    thresholdList(end + 1) = testLevel;
                elseif a == c2
                    reversal(i) = reversal(i) + 1;
                    thresholdList(end + 1) = testLevel;
                end
            end
        else
            if length(isCorrectList) >= 3
                a = [isCorrectList(end - 2), isCorrectList(end - 1), isCorrectList(end)];       
                c1 = [1, 1, 0];
                c2 = [0, 1, 1];
                if a == c1
                    reversal(i) = reversal(i) + 1;
                    thresholdList(end + 1) = testLevel;
                elseif a == c2
                    reversal(i) = reversal(i) + 1;
                    thresholdList(end + 1) = testLevel;
                end
            end
        end

        % compute staircase
        testLevel = abs(Sequence.testLevel);
        stepSize = Stimuli.stdStepSize;
        
        if reversal(i)
            newLevel = staircase_3u1d(testLevel, isCorrectList, stepSize);
        else
            stepSize = Stimuli.beginStepSize;
            newLevel = staircase_3u1d(testLevel, isCorrectList, stepSize);
        end

        if newLevel > Stimuli.startLevel
            newLevel = Stimuli.startLevel;
            outBounds = outBounds + 1;
        end

        % append new mean to list of means
        levelList(end + 1) = newLevel; 

    else
        levelList = levelList;
        isCorrectList = isCorrectList;
        firstError = firstError;
        reversal = reversal;
        outBounds = outBounds;
    end

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------