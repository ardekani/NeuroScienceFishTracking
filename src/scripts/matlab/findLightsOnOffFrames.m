% Author: Reza Ardekani
% Date: Feb 2015
% function: based on the change in the intensity it finds
% on and off periods
%function [ lightOns lightOffs averageIntensity] = findLightsOnOffFrames( firstFrame, lastFrame,pathToTif,roi)
function [ lightOns lightOffs averageIntensity] = findLightsOnOffFrames(inputCSVFile)

display( 'SHOULD NOT HAVE BEEN CALLED ');

    inp = csvread(inputCSVFile);
    averageIntensity = inp(:,5);
    isLightOn = zeros(size(averageIntensity));
    mu = mean(averageIntensity);
    sigma = std(averageIntensity);
    isLightOn(find(averageIntensity> (mu + 2*sigma))) = 1;
    
    
    windowSize = 3;

    %isLightOn = zeros(size(averageIntensity));
    sig = isLightOn;
    filSig =filter(ones(1,windowSize)/windowSize,1, sig);
    isLightOn2 = zeros(size(averageIntensity));
    isLightOn2(find(filSig>0)) = 1;
    isLightOn = isLightOn2;
    
    lightOns = find(diff(isLightOn)>0);
    lightOffs = find(diff(isLightOn)<0);
    

    %lightOns = find(diff(isLightOn)>0);
    %lightOffs = find(diff(isLightOn)<0); 
end



