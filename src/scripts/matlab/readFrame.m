% Author: Reza Ardekani
% Date: Feb 2015
% Function: returns an image from image sequences..
% TODO: Params..
% TODO: have a better return value!ß

function [ img ] = readFrame( frameNumber,pathToTif, roi)
%readFrame: loads tif file
    frameStr = num2str(frameNumber,'%.9d');
    fname = strcat(pathToTif,'img_',frameStr,'_Default_000.tif');
    
    if exist(fname, 'file')
    
        img = imread(fname,'PixelRegion',{[roi.y,roi.y+ roi.height], [roi.x , roi.x+roi.width]});
    else
        display(strcat(frameStr, '  is not there\n'));
        img = -1*ones(2,2);
    end;

end

