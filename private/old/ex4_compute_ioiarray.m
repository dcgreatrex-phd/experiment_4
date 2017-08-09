function IOIarray = ex4_compute_ioiarray(rhythmic_flag, nTarget, periodicIOI, variance)
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
    IOIrange = periodicIOI/2;               % IOI ± range 

    % generate IOI array
    if rhythmic_flag == 1                   
        IOIarray(1:nTarget) = periodicIOI;  % periodic: return an array of zeros
        return;
    else    


        lsum = (periodicIOI * nTarget)-(periodicIOI/10);
        %disp(lsum);
        usum = (periodicIOI * nTarget)+(periodicIOI/10);
        %disp(usum);
        IOIarray = [];
        while true
            for i = 1:nTarget 
                t = periodicIOI.*rand(1,1) + IOIrange;  
                IOIarray(i) = t;
            end
            %disp(sum(IOIarray));

            if (sum(IOIarray) < lsum || sum(IOIarray) > usum)
                continue
            else
                %break
                if variance == 2
                    if (std(IOIarray) < 0.083998168286866) || (std(IOIarray) > 0.120076600751272) % between +0.5 & +2.5 sd of the variance distribution
                        continue
                    else
                        break
                    end
                else
                    if (std(IOIarray) > 0.065958952054664) || (std(IOIarray) < 0.029880519590259) % between -0.5 & -2.5 sd of the variance distribution
                        continue
                    else
                        break
                    end
                end
            end
        end
    end
    %---------------------
catch ME
    rethrow(ME);
end
%------------- END OF CODE --------------