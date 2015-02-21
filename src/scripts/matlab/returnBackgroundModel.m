% Author: Reza Ardekani
% Date: Feb 2015
% Function: returns background model from tif image sequences..
% TODO: Params..
% TODO: have a better return value!ß

function [ bg ] = returnBackgroundModel( pathToTif, roi, firstFrame, lastFrame, stepSize)
    frameNumbers = firstFrame:stepSize:lastFrame;
    bg = readFrame(frameNumbers(1),pathToTif,roi);
    count = 1;
    for ii = 2:length(frameNumbers)
        
        curFrame = readFrame(frameNumbers(ii),pathToTif,roi);
        bg = (count*double(bg) + double(curFrame))./(count+1);
       count = count+1;     
    end


end

