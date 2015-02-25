
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


%% Plotting in Loop

pathToTif_all{1} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train4_1/Pos0/';

pathToTif_all{2} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train1_1/Pos0/';

pathToTif_all{3} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';

pathToTif_all{4} = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';

roi_text{1} = 'leftChamber';
roi_text{2} = 'rightChamber';

for pp = 1:length(pathToTif_all)
    pathToTif = pathToTif_all{pp};

    for rt = 1:length(roi_text)
        tmptxt = roi_text{rt};
        csvFileName = strcat(pathToTif, 'allInfo_',tmptxt,'.csv');
    
        [hh figTitle]= plotLightDarkTrajectories(csvFileName);
        saveas(hh,strcat(pathToTif,figTitle,'.jpg'));
    end
end

    