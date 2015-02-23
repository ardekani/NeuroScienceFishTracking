% Author: Reza Ardekani
% Date: Feb 2015
% function: based on the change in the intensity it finds
% on and off periods
function [ lightOns lightOffs averageIntensity] = findLightsOnOffFrames( firstFrame, lastFrame,pathToTif,roi)

    averageIntensity = zeros(1, lastFrame-firstFrame + 1);

    for fn = firstFrame:lastFrame
        img1 = readFrame(fn, pathToTif, roi);
        averageIntensity(fn) = mean2(img1);
    end

    isLightOn = zeros(size(averageIntensity));
    isLightOn(find(averageIntensity>mean(averageIntensity) + std(averageIntensity))) = 1;
    lightOns = find(diff(isLightOn)>0);
    lightOffs = find(diff(isLightOn)<0); 
 
%     diffAv = diff(averageIntensity);
%     minDiffAve = min(diffAv); % negative number
%     maxDiffAve = max(diffAv); % positive number
% 
%     % they both have to have the same length
%     lightOns = find(diffAv>100);%0.7*maxDiffAve);
%     lightOffs = find(diffAv<-100);%0.7*minDiffAve);

end



