function [targetArray, iArray] = ex4_compute_pattern_complexity(mu, s)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try

    n_movement = 13;    % number of index step jumps (location leaps) that are allowed in the sequence
    n_reversal = 3;     % number of direction reversals that are allowed in the sequence

    % define unordered (ascending) target array (dB ILD values)
    targetArray = [(mu - ((s/2) + s * 2 )), ... 
                   (mu - ((s/2) + s )), ...
                   (mu - (s/2)), ...
                   (mu + (s/2)), ... 
                   (mu + ((s/2) + s )), ... 
                   (mu + ((s/2) + s * 2 ))];

    % define unordered (ascending) index array that will be used to sort the target array
    iArray = 1:length(targetArray);               
  
    while true
        % randomise the index array values.
        iArray = iArray(randperm(length(iArray)));

        % compute movement (noise burst jump) score from the index array
        score = [];
        for i = 1:5
            score(i) = abs(iArray(i + 1) - iArray(i));
        end
        sumscore = sum(score);

        % compute reversal score
        if sumscore == n_movement

            % generate a sign array based on positive and negative array movements
            signs = [];
            for p = 1:(length(iArray)-1)
                signs(p) = iArray(p + 1) - iArray(p);
            end

            % Compute redirect values based on the sign array
            for j = 1:length(signs)
                if j > 1
                    if (signs(j-1) >= 0 && signs(j) < 0) 
                        redirect(j) = 1;
                    elseif (signs(j-1) < 0 && signs(j) >= 0)
                        redirect(j) = 1;
                    else
                        redirect(j) = 0;
                    end
                end
            end

            % if the number of redirects matches the required number break out of the loop
            if sum(redirect) == n_reversal
                % order the target array using the selected and reordered index array
                targetArray = [targetArray(iArray(1)), 
                              targetArray(iArray(2)), 
                              targetArray(iArray(3)), 
                              targetArray(iArray(4)), 
                              targetArray(iArray(5)), 
                              targetArray(iArray(6))];
                % break out of loop and return from function
                break
            end
        end
    end

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------