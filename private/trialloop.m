function trialloop(Pointers, Stimuli, Response, increment, Prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try 
    rng('default') 
    rng shuffle

    % present instructions and noise centering for the main experiment
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 6);
    ptb_onscreen_text(Pointers.w, m);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 7);
    ptb_onscreen_text(Pointers.w, m);
    noisecentering(Stimuli, Pointers);  
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 8);
    ptb_onscreen_text(Pointers.w, m); 

    % run the experimental loop
    n_blocks = 6;
    for block = 1:n_blocks;

        % load trial information    
        [index, testLevel, isPeriodic direction] = textread(Pointers.input_file,'%f %f %f %f');
        ntrials     = length(index);            % get number of trials
        randomorder = randperm(ntrials);        % random permiatations
        index       = index(randomorder);       % randomise input list
        testLevel   = testLevel(randomorder);
        isPeriodic  = isPeriodic(randomorder);
        direction   = direction(randomorder);

        if block == 3 || block == 5
            m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 9);
            ptb_onscreen_text(Pointers.w, m);
            noisecentering(Stimuli, Pointers); 
            m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 10);
            ptb_onscreen_text(Pointers.w, m);
        end
        if block == 2 || block == 4 || block == 6
            m = 'Great, you have finished a block. \n\n Take a short pause to regather your focus and energy. \n\n Remember: Your task is to say whether the average spatial location of the moving sound \nsequence is to the left or right of the comparison tone.\n\n Click the mouse to begin the next block... '
            ptb_onscreen_text(Pointers.w, m);
        end

        for i = 1:ntrials;

            level = testLevel(i) * increment;

            % assign mean of noise train
            mu = Stimuli.absRange * direction(i);

            % compute target array and return sequence information
            [Sequence] = trialloop_definesequence(Stimuli, mu, isPeriodic(i), level, index(i));
            [Sequence(:).isPractice] = 0;

            % load audio sequence into audio buffers ready for playback
            [paTarget, Sequence, paTestTone] = trialloop_loadsound(Stimuli, Sequence);

            % play trial sequence, compute trial data
            ResponseData = trialloop_playtrial(Pointers, Sequence, Response, paTarget, paTestTone);

            % save trial data
            ex4_savedata(Pointers.subNo, Pointers.fpointer, Sequence, ResponseData, block);
            
            % pause before starting next trial
            WaitSecs(0.200);
        end  
    end
    message = 'Thank you for your time \n\n click the mouse to exit...';
    ptb_onscreen_text(Pointers.w, message)

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------