function cleanup()
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    PsychPortAudio('Close');
    ptb_cleanup();
    clear all

    %---------------------
catch ME
    clear all
end
%------------------------------------------