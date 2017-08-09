function test2()

    Stimuli.gapBetweenTones = 4;
    mu = 0;

    s = Stimuli.gapBetweenTones;
    targetArray = [(mu - ((s/2) + s * 2 )), ... 
                   (mu - ((s/2) + s )), ...
                   (mu - (s/2)), ...
                   (mu + (s/2)), ... 
                   (mu + ((s/2) + s )), ... 
                   (mu + ((s/2) + s * 2 ))];

    mean = 11.659100000000000;
    sd = 2.291814222672305;
    upper = mean + (sd * 1.5);
    lower = mean - (sd * 1.5);
    while true
        % randomise the array positions.
        targetArray = targetArray(randperm(length(targetArray)));

	    score = [];
	    for j = 1:5
	        score(j) = abs(targetArray(j) - targetArray(j + 1))/4;
	    end
        sumscore = sum(score);
        if sumscore > lower && sumscore < upper
        	break
        end
    end






end