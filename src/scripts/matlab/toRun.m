%%  To Run the adultfishTracking function
% 
tic
% took around 200sec
pathToTif = 'E:\Reza\fish_learning\assey1\2015-03-27_essay1\fishBehavior_training_and_test_1\testing\';
firstFrame = 212442;
lastFrame  = 232719;
display(pathToTif);
roiTopLeft.x      = 1;
roiTopLeft.y      = 1;
roiTopLeft.width  = 240;
roiTopLeft.height = 210;

roiTopRight.x      = 250;
roiTopRight.y      = 1;
roiTopRight.width  = 240;
roiTopRight.height = 210;

roiBottLeft.x      = 1;
roiBottLeft.y      = 215;
roiBottLeft.width  = 240;
roiBottLeft.height = 210;

roiBottRight.x      = 250;
roiBottRight.y      = 215;
roiBottRight.width  = 240;
roiBottRight.height = 210;

roiList= {roiTopLeft, roiTopRight, roiBottLeft, roiBottRight};
adultFishTracking(pathToTif,firstFrame, lastFrame,roiList);
t= toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
%took around 400sec
pathToTif = 'E:\Reza\fish_learning\assey1\2015-03-30_essay1\fishBehavior_full_rec_1\testing\';
firstFrame = 265783;
lastFrame =  292051;

roiTopLeft.x      = 1;
roiTopLeft.y      = 1;
roiTopLeft.width  = 225;
roiTopLeft.height = 200;

roiTopRight.x      = 230;
roiTopRight.y      = 1;
roiTopRight.width  = 230;
roiTopRight.height = 200;

roiBottLeft.x      = 1;
roiBottLeft.y      = 200;
roiBottLeft.width  = 230;
roiBottLeft.height = 210;

roiBottRight.x      = 230;
roiBottRight.y      = 200;
roiBottRight.width  = 240;
roiBottRight.height = 210;

roiList= {roiTopLeft, roiTopRight, roiBottLeft, roiBottRight};
adultFishTracking(pathToTif,firstFrame, lastFrame,roiList);

t = toc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
tic
% same ROI as previous experiment
pathToTif = 'E:\Reza\fish_learning\assey1\2015-03-31_essay1\FullBehavior_1\testing\';

firstFrame = 244355;
lastFrame = 268548;

roiTopLeft.x      = 1;
roiTopLeft.y      = 1;
roiTopLeft.width  = 225;
roiTopLeft.height = 200;

roiTopRight.x      = 230;
roiTopRight.y      = 1;
roiTopRight.width  = 230;
roiTopRight.height = 200;

roiBottLeft.x      = 1;
roiBottLeft.y      = 200;
roiBottLeft.width  = 230;
roiBottLeft.height = 210;

roiBottRight.x      = 230;
roiBottRight.y      = 200;
roiBottRight.width  = 240;
roiBottRight.height = 210;

roiList= {roiTopLeft, roiTopRight, roiBottLeft, roiBottRight};
adultFishTracking(pathToTif,firstFrame, lastFrame,roiList);

t = toc







    
