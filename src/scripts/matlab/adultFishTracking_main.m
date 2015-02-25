
clc;clear all;

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train4_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;
display(pathToTif);
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train1_1/Pos0/';
firstFrame = 1;
lastFrame = 18302;
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';
firstFrame = 1;
lastFrame = 19086;
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;
adultFishTracking(pathToTif,firstFrame, lastFrame);
