% Author: Reza Ardekani
% Date: Feb 2015
% Function: returns background model from tif image sequences using
% sample frames from the first frame to the last frame with step size of

% Input:
       %pathToTif : the path to the directory
       %roi: processing region of the frame 
       %firstFrame 
       %lastFrame
       %stepSize: the distance between sampled frame
% Output:
        %bg: background model, a matrix with same size of the roi
       
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

