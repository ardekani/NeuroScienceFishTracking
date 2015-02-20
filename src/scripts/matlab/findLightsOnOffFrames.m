% Author: Reza Ardekani
% Date: Feb 2015
% function: based on the change in the intensity it finds
% on and off periods
function [ lightOns lightOffs averageIntencity] = findLightsOnOffFrames( firstFrame, lastFrame,pathToTif)

    roi.x = 200;
    roi.y = 200;
    roi.width = 5;
    roi.height = 5;

    averageIntencity = zeros(1, lastFrame-firstFrame + 1);

    for fn = firstFrame:lastFrame
        img1 = readFrame(fn, pathToTif, roi);
        averageIntencity(fn) = mean2(img1);
    end

    diffAv = diff(averageIntencity);
    minDiffAve = min(diffAv); % negative number
    maxDiffAve = max(diffAv); % positive number

    % they both have to have the same length
    lightOns = find(diffAv>0.7*maxDiffAve);
    lightOffs = find(diffAv<0.7*minDiffAve);

end



