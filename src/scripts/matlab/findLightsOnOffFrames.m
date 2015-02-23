% Author: Reza Ardekani
% Date: Feb 2015
% function: based on the change in the intensity it finds
% on and off periods
%function [ lightOns lightOffs averageIntensity] = findLightsOnOffFrames( firstFrame, lastFrame,pathToTif,roi)
function [ lightOns lightOffs averageIntensity] = findLightsOnOffFrames(inputCSVFile)
    inp = csvread(inputCSVFile);
    averageIntensity = inp(:,5);
    isLightOn = zeros(size(averageIntensity));
    isLightOn(find(averageIntensity>mean(averageIntensity) + std(averageIntensity))) = 1;
    lightOns = find(diff(isLightOn)>0);
    lightOffs = find(diff(isLightOn)<0); 
end



