function practice_main(subNo, Pointers, Stimuli, Response, Prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    rng('default') 
    rng shuffle

    % present instrcutions for the practice session
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 1);
    ptb_onscreen_text(Pointers.w, m); 
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 2);
    ptb_onscreen_text(Pointers.w, m); 

    % Open out file
    fpointer = ml_open_files(subNo, Prepair.outFolder, ...    % open output files:
                                    Prepair.nOutfile, 'practice', 0); 
    
    ml_writetofile(fpointer, Prepair.tableVariable);          % print headings to outfiles

    % run the experimental loop
    block = 1;
    ntrials = 50;
    index = 1;
    for i = 1:ntrials;
        if i == 30
            m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 3);
            ptb_onscreen_text(Pointers.w, m); 
        end
        if i < 30
            practiceFeedback = 1; % set practice feedback
        else
            practiceFeedback = 0; % remove practice feedback
        end

        % randomly assign rhythmic flag: 1 = Periodic, 0 = Aperiodic
        if round(rand) == 1
            isPeriodic = 1;
        else
            isPeriodic = 0;
        end

        % randomly select a testlevel 
        increment = (3 - 1).*rand(1,1) + 1;    % random increment between 1 and 3
        testLevel = (-3 - 3).*rand(1,1) + 3;   % random test level between -3 and 3.
        testLevel = round(testLevel*2)/2;      % round test level to nearest .5
        while testLevel == 0                   % resample if test level == 0
            testLevel = randi([-3 3],1,1);
        end
        level = testLevel * increment;         % compute randomly selected test level

        % random value between -4 : 4. Change in dB intensity
        absRange = 4;
        mu = (absRange-(-absRange)).*rand(1,1) + (-absRange);

        % compute target array and return sequence information
        [Sequence] = trialloop_definesequence(Stimuli, mu, isPeriodic, level, index);
        [Sequence(:).isPractice] = practiceFeedback;    

        % load audio sequence into audio buffers ready for playback
        [paTarget, Sequence, paTestTone] = trialloop_loadsound(Stimuli, Sequence);

        % play trial sequence, compute trial data
        ResponseData = trialloop_playtrial(Pointers, Sequence, Response, paTarget, paTestTone);

        % save trial data
        ex4_savedata(Pointers.subNo, fpointer, Sequence, ResponseData, block)
        
        % pause before next trial
        WaitSecs(0.700);
        index = index + 1;
    end  
    WaitSecs(1);
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------