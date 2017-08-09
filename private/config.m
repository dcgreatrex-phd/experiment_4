function [Prepair, Stimuli] = config(subNo)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
	%--------------------- 
	% Setup variables
	%--------------------- 
	format long; % set output format
	% Folders
	f1 = 'inFolder';     v1 = 'input/';  	        % input folder
	f2 = 'outFolder';    v2 = strcat('output/P_', num2str(subNo), '/');    % output folder
	f3 = 'soundFolder';  v3 = 'stimuli/sounds/';    % sound folder
	f4 = 'imgFolder';    v4 = 'stimuli/images/';    % image folder
	f5 = 'textFolder';   v5 = 'stimuli/text/';

	% screen and response 
	f6 = 'skipTest';     v6 = 0; 				    % 0 = skip test, 1 = do not skip test
	f7 = 'textSize';     v7 = 26; 				    % default text size
	f8 = 'keyArray';     v8 = {{'2', '8', 'p'}};    % response and pause keys
	f9 = 'timeoutDur';   v9 = 5.0;				    % maximum time allowed to respond on each trial

	% data files
	f10 = 'exptName';    v10 = 'exp4_p'; 			% base name of all output files
	f11 = 'nOutfile';    v11 = 1; 				    % number of output files to be opened
	f12 = 'isLogfile';   v12 = 1; 				    % 1 signals to create a log file
	f13 = 'tableVariable'; v13 = {{'subNo', ...     % variable names to print to outfile
								   'index', ...
								   'block', ...
								   'mean', ...
								   'periodicity', ...   
								   'testLevel', ...
								   'pressedKey', ...
								   'answer', ...
								   'isCorrect', ...
								   'rt', ...
								   's1',...
								   's2',...
								   's3',...
								   's4',...
								   's5',...
								   's6',...
								   't1',...
								   't2',...
								   't3',...
								   't4',...
								   't5',...
								   'seqDuration', ...
								   'startInterval', ...
								   'trialDuration'}};
    if mod(subNo,2) == 0
        % even
        instructions = 'instructionsEven';
    else
        % odd
        instructions = 'instructionsOdd';
    end
	f14 = 'textFile'; v14 = instructions; 
	f15 = 'minThresh'; v15 = 1.4;
	f16 = 'maxThresh'; v16 = 3.3;

	Prepair = struct(f1, v1, f2,  v2,  f3,  v3, f4, v4, ...
					 f5, v5, f6,  v6,  f7,  v7, f8, v8, ...
					 f9, v9, f10, v10, f11, v11, f12, v12, ...
					 f13, v13, f14, v14, f15, v15, f16, v16);

    %--------------------- 
	% Stimulus variables
	%--------------------- 
	f1 = 'noiseDur';        v1 = 0.050;    % duration of noise
	f2 = 'isRamp';		    v2 = 1;	       % include on-off set ramps when generating noise 1 = include	
	f3 = 'gateDur';	  	    v3 = 0.005;	   % duration of on and offset cosin ramps	
	f4 = 'playbackFreq';    v4 = 48828;    % sampling rate of sound files
	f5 = 'periodicIOI';     v5 = 0.500;    % default interonset interval on periodic trials
	f6 = 'nTarget';         v6 = 6;		   % number of noise targets in each sequence array

    % tone spacing parameters
	f7 = 'gapBetweenTones'; v7 = 4;		   % spatial gap between tones in dB ILD
	f8 = 'absRange';        v8 = 2;        % sequential distance in dB between each of the mean 
										   % locations. The mean can either be 2*-2, 2*-1, 2*0, 2*1, 2*2
	
	% stiarcasing step parameters
	f9 = 'beginStepSize';   v9  = 2;
	f10 = 'stdStepSize';    v10 = 0.33;
	f11 = 'noReversals';    v11 = 10;
	f12 = 'startLevel';     v12 = 11;	   % starting level of the staircase


	Stimuli = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
					 f5, v5, f6, v6, f7, v7, f8, v8, ...
					 f9, v9, f10, v10, f11, v11, f12, v12);
	
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------