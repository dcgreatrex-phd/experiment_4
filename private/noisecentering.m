function noisecentering(Stimuli, Pointers)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
	[~, ~, keyCode] = KbCheck(-1);    % Initialize KbCheck:
	WaitSecs(0.5); 
	toneduration = 5.00;
	noise = ex4_noise(toneduration, Stimuli.playbackFreq, 0, 0, 0);    % create broadband Gaussian noise

	%---------------------
	% initialse noise audio handle
	%---------------------
	[paMASTER] = ptb_open_audiomaster(Stimuli.playbackFreq);     % master handle
	PsychPortAudio('Volume', paMASTER, 0.5);
	panoise = PsychPortAudio('OpenSlave', paMASTER, 1);          % sine tone slave
	PsychPortAudio('Volume', panoise, 0.3);
	noise2 = [noise; noise];
	pabufnoise = PsychPortAudio('CreateBuffer', [], noise2);
    PsychPortAudio('FillBuffer', panoise, pabufnoise); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    message = 'Before you start... \n\nPlease adjust your headphones so that the noise you hear \nis perceived as coming from directly infront of you. \n\n This will ensure that you hear the sounds as they are meant to be presented. \n\n\n\n\n\n\n\n\n\n\n\n When you are ready, press the space bar to continue.';
    y = Pointers.coordinates(2) - 300;
    c = (Pointers.screenCenter/2);
    ptb_onscreen_text(Pointers.w, message, 'center', y, 0, 0);
    Screen('DrawLines', Pointers.w, [-30 30; 0 0], [3], [255 255 0], c);
    Screen('DrawLines', Pointers.w, [0 0; -30 30], [3], [255 255 0], c);
    [~, startTime] = Screen('Flip', Pointers.w, 0); 		     % initiate click track
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PsychPortAudio('Start', panoise, 0, 0);    % start the click track
    KbReleaseWait;
	while ~KbCheck
		WaitSecs(0.1);
	end
	PsychPortAudio('Stop', panoise);		   % stop the audio track
	Screen('Flip', Pointers.w, 0); 
	PsychPortAudio('Close');				   % close psychportaudio
	[~, ~, keyCode] = KbCheck(-1);             % Initialize KbCheck:

    %---------------------
catch ME
   rethrow(ME);
end
%------------------------------------------