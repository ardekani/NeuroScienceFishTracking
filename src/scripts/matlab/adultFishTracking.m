clc;clear all;
%pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';
pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;
stepSize = 100;

roi.x = 1;
roi.y = 1;
roi.width = 324;
roi.height = 344;

if (0)
    tic;
    [lightOns, lightOffs, averageIntensity] = findLightsOnOffFrames(firstFrame, lastFrame, pathToTif, roi);
    t = toc;
end;

bg = returnBackgroundModel(pathToTif, roi, firstFrame,lastFrame,stepSize);

se = strel('ball',2,2);
allInfo = zeros(lastFrame-firstFrame + 1,4);
for fn = firstFrame:(lastFrame-1)
% for fn = 1:1000
    img = readFrame(fn, pathToTif, roi);
    changeMask = uint16(bg - double(img));
    
    changeMaskThresh = zeros(size(changeMask));
    changeMaskThresh(find(changeMask>5000)) = 1;

    [x, y] = find(changeMaskThresh>0);
    xPos = floor(mean(x));
    yPos = floor(mean(y));
    allInfo(fn,1) = fn;
    allInfo(fn,2) = 1;
    allInfo(fn,3) = xPos;
    allInfo(fn,4) = yPos;
    %imshow(changeMaskThresh,[]);
    %pause(0.1);
    if ~(mod(fn,100))   
        display(fn)
    end
end

csvwrite(strcat(pathToTif, '/allInfo.csv'), allInfo);



