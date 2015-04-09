
clc;clear all;

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train4_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;
display(pathToTif);
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train1_1/Pos0/';
firstFrame = 1;
lastFrame = 18302;
display(pathToTif);
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';
firstFrame = 1;
lastFrame = 19086;
display(pathToTif);
adultFishTracking(pathToTif,firstFrame, lastFrame);

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;
display(pathToTif);
adultFishTracking(pathToTif,firstFrame, lastFrame);


%% Plotting in Loop
close all;
pathToTif_all{1} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train4_1/Pos0/';

pathToTif_all{2} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train1_1/Pos0/';

pathToTif_all{3} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';

pathToTif_all{4} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';

roi_text{1} = 'leftChamberNew';
roi_text{2} = 'rightChamberNew';

for pp = 1:length(pathToTif_all)
%for pp = 3:3    
    pathToTif = pathToTif_all{pp};

    for rt = 1:length(roi_text)
        tmptxt = roi_text{rt};
        csvFileName = strcat(pathToTif, 'allInfo_',tmptxt,'.csv');
        %plotLightDarkTrajectories(csvFileName);
        plotBoxPlots(csvFileName);
            
    end
end

%%  To Run newer version - for four fishes at the time experiment:
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

toc


%% Plotting new data

%% Plotting in Loop
close all;clc;clear;
pathToTif_all{1} = 'E:\Reza\fish_learning\assey1\2015-03-27_essay1\fishBehavior_training_and_test_1\testing\';

pathToTif_all{2} = 'E:\Reza\fish_learning\assey1\2015-03-30_essay1\fishBehavior_full_rec_1\testing\';

pathToTif_all{3} = 'E:\Reza\fish_learning\assey1\2015-03-31_essay1\FullBehavior_1\testing\';

for pp = 1:length(pathToTif_all)
%for pp = 2:2    
    pathToTif = pathToTif_all{pp};

    for rt = 1:4 % we have 4 roi
        tmptxt = strcat('roi_',num2str(rt));
        csvFileName = strcat(pathToTif, 'allInfo_',tmptxt,'.csv');
        %plotLightDarkTrajectories(csvFileName);
        plotBoxPlots(csvFileName);
        
    end
end






%% find dark and light based on all the area
avIntAll={};
lightOnAll={};
lightOffs ={};
for pp = 1:length(pathToTif_all)
    pathToTif = pathToTif_all{pp};
    avInt = [];
    for rt = 1:4 % we have 4 roi
        tmptxt = strcat('roi_',num2str(rt));
        csvFileName = strcat(pathToTif, 'allInfo_',tmptxt,'.csv');
        [dummy1 dummy2 c] = findLightsOnOffFrames(csvFileName);
         avInt = [avInt,c];
         %onn =[onn ,on];
         %offf =[offf, off];
         %on
         %off
         
    end
    averageIntensity = sum(avInt,2);
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
    lightOffs - lightOns
    avIntAll{pp} = averageIntensity;
    lightOnAll{pp} = lightOns;
    lightOffAll{pp} = lightOffs;
    
end

windowSize = 5;

%isLightOn = zeros(size(averageIntensity));
sig = isLightOn;
filSig =filter(ones(1,windowSize)/windowSize,1, sig);

isLightOn2 = zeros(size(averageIntensity));
isLightOn2(find(filSig>0.3)) = 1;

    lightOns = find(diff(isLightOn2)>0)
    lightOffs = find(diff(isLightOn2)<0)
    



%% Testing ROI 
img = imread('E:\Reza\fish_learning\assey1\2015-03-31_essay1\FullBehavior_1\testing\img_000244355_Default_000.tif');
figure;imshow(img);
tl = readFrame(firstFrame,pathToTif, roiTopLeft);
tr = readFrame(firstFrame,pathToTif, roiTopRight);
bl = readFrame(firstFrame,pathToTif, roiBottLeft);
br = readFrame(firstFrame,pathToTif, roiBottRight);

figure;imshow(tl);
figure;imshow(tr);
figure;imshow(bl);
figure;imshow(br);






    
