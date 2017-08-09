function IOIarray = ex4_compute_ioiarray_staircase(rhythmic_flag, nTarget, periodicIOI)
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

%------------- BEGIN CODE -------------- 
try 
    % setup exclusion sampling range
    excludeWindow = 0.030;                  % IOI resampling limit
    %IOIrange = periodicIOI/2;               % IOI ± range 
    IOIrange = periodicIOI * 0.6;

    % generate IOI array
    if rhythmic_flag == 1                   
        IOIarray(1:nTarget) = periodicIOI;  % periodic: return an array of zeros
        return;
    else    
        tMinus1 = 0;
        lsum = (periodicIOI * nTarget)-(periodicIOI/10);
        usum = (periodicIOI * nTarget)+(periodicIOI/10);
        IOIarray = [];
        while true

            for i = 1:nTarget 
                t = periodicIOI.*rand(1,1) + IOIrange;  

                if tMinus1 ~= 0
                    isLowbound  = t >= (tMinus1 - excludeWindow);  
                    isHighbound = t <= (tMinus1 + excludeWindow);
                    if (isLowbound && isHighbound)    % resample if IOI value is within IOI exclude window
                        continue
                    else
                        IOIarray(i) = t;
                        tMinus1 = t;
                    end
                else
                    IOIarray(i) = t;
                    tMinus1 = t;
                end

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
%------------- END OF CODE --------------