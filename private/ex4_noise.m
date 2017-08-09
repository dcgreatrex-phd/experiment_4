function noise = ex4_noise(noiseDur, playbackFreq, isRamp, gateDur, soundNoise)
%FUNCTION_HEADER - 
% 
% Syntax:  [y] = FUNCTION_HEADER(x)
%
% Input: 
%           x:             
%
% Output:
% 
%           y:            
%
% Example:
%
%           [y] = FUNCTION_HEADER(x)
%
% m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: David C Greatrex
% Work Address: Centre for Music and Science, Cambridge University
% email: dcg32@cam.ac.uk
% Website: http://www.davidgreatrex.com
% mmm YYYY; Last revision: DD-MM-YYYY
    
%------------------------------------------
if nargin < 5 									% do not sound noise prior to returning function
    soundNoise = 0;
end
if nargin < 4 									% set to on/offset ramp duration to 10 ms
    gateDur = 0.01;
end
if nargin < 3 									% set to on/offset ramps required
    isRamp = 1;
end
if nargin < 2 									% set default sampling freq
    playbackFreq = 44100;
end

n = (randn(1, floor(playbackFreq*noiseDur))*2)-1; % generate noise

normalizedNoise = n/max(abs(n)); 				% normalise noise

if isRamp == 1                                  % add on and offset ramps
    gate = cos(linspace(pi, 2*pi, playbackFreq*gateDur));
    gate = gate+1;
    gate = gate/2;
    offsetgate = fliplr(gate);
    sustain = ones(1, (length(normalizedNoise)-2*length(gate)));
    envelope = [gate, sustain, offsetgate];
    smoothedNoise = envelope .* normalizedNoise;
    noise = smoothedNoise;
else
    noise = normalizedNoise;
end

% Add butterworth bandpass filter to limit the frequency of noise:
%% LINKS: http://uk.mathworks.com/help/signal/ref/designfilt.html

% % % Butterworth filter - 10th order
[b,a] = butter(8, [300 20000]/(playbackFreq/2), 'bandpass');
noise = filter(b,a,noise);

%FIR filter with 10th order
% bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
%          'StopbandFrequency1', 390, ... 
%          'PassbandFrequency1', 400, ...
%          'PassbandFrequency2',19090, ...
%          'StopbandFrequency2',20000, ...
%          'DesignMethod','ls', ...
%          'SampleRate',playbackFreq);
% noise = filter(bpFilt,noise);

if soundNoise == 1;
    sound(noise, playbackFreq);
end

%------------------------------------------