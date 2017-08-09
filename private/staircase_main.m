function threshold = staircase_main(subNo, Pointers, Response, Prepair, Stimuli)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    %---------------------
    % present instrcutions and noise centering for the staircase procedure
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 4);
    ptb_onscreen_text(Pointers.w, m);                                                                          
    noisecentering(Stimuli, Pointers);                                  
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 5);
    ptb_onscreen_text(Pointers.w, m); 

    % folder and ptb setup: 
    datafilepointer = staircase_setup(subNo, Prepair);   
    
    % run stiarcase procedure
    threshold = staircase_trialloop(Pointers, Stimuli, Response, ...    
                                    datafilepointer);                 
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();    % clean up:                                                          
end
%------------------------------------------