function averaging_threshold(subNo)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    %---------------------
    % variable configuration:
    [Prepair, Stimuli] = config(subNo);
    %---------------------
    % folder and ptb setup:
    [Pointers, Response] = setup(subNo, Prepair);
    m = 'Welcome to the Experiment \n\nClick the mouse to begin...';
    ptb_onscreen_text(Pointers.w, m); 
    %---------------------
    % run practice procedure
    practice_main(subNo, Pointers, Stimuli, Response, Prepair);
    %---------------------
    % run staircasing procedure and adjust threshold if required
    t = staircase_main(subNo, Pointers, Response, Prepair, Stimuli);
    t = ex4_checkThreshold(t, Prepair.minThresh, Prepair.maxThresh);
    %---------------------
    % run main experimental procedure
    trialloop(Pointers, Stimuli, Response, t, Prepair);       
	%---------------------
    % clean up:
    cleanup();
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();    % clean up:
end
%------------------------------------------