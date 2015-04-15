% Author: Reza Ardekani
% Date: Feb 2015
% Function: returns an image from image sequences 
% The filename pattern for each frame is img_ddddddddd_Default_000.tif
% TODO: have a better return value in the case of failure

function [ img ] = readFrame( frameNumber,pathToTif, roi)
    frameStr = num2str(frameNumber,'%.9d');
    fname = strcat(pathToTif,'img_',frameStr,'_Default_000.tif');
    
    if exist(fname, 'file')
    
        img = imread(fname,'PixelRegion',{[roi.y,roi.y+ roi.height], [roi.x , roi.x+roi.width]});
    else
        display(strcat(frameStr, '  is not there\n'));
        img = -1*ones(2,2);
    end;

end

