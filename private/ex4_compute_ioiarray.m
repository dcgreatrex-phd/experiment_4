function IOIarray = ex4_compute_ioiarray(rhythmic_flag, nTarget, periodicIOI)
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
try 
    % setup exclusion sampling range
    excludeWindow = 0.025;                  % IOI resampling limit
    IOIrange = periodicIOI * 0.5;           % jitter

    % generate IOI array
    if rhythmic_flag == 1                   
        IOIarray(1:nTarget) = periodicIOI;  % periodic: return an array of zeros
        return;
    else                                        % aperiodic: randomly select IOI array    
        lsum = (periodicIOI * nTarget)-(0.010); % lowest total sequence duration possible
        usum = (periodicIOI * nTarget)+(0.010); % highest total sequence duration possible
        tMinus1 = 0;
        IOIarray = [];
        while true
            for i = 1:nTarget                   % loop until n_target IOIs are found
                
                while true
                    
                    t = periodicIOI.*rand(1,1) + IOIrange;    % random number between periodicIOI ± IOIrange
                    
                    if tMinus1 ~= 0

                        isLowbound  = t >= (tMinus1 - excludeWindow);  
                        isHighbound = t <= (tMinus1 + excludeWindow);
                        if (isLowbound && isHighbound)        % resample if IOI value is within IOI exclude window
                            continue
                        else
                            break
                        end
                    else
                        break
                    end
                end

                IOIarray(i) = t;    % update IOI array with value
                tMinus1 = t;
            end

            if (sum(IOIarray) < lsum || sum(IOIarray) > usum)
                continue
            else
                break
            end
        end
    end
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------