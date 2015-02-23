clc;clear all;

pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train4_1/Pos0/';
firstFrame = 1;
lastFrame = 21499;

% pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Train1_1/Pos0/';
% firstFrame = 1;
% lastFrame = 18302;


% pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/PreTrain1_1/Pos0/';
% firstFrame = 1;
% lastFrame = 19086;

%pathToTif = '/Users/rezadehestaniardekani/Desktop/ForReza_2_20_2015/Test1_1/Pos0/';
%firstFrame = 1;
%lastFrame = 21499;


stepSize = 100;

% roi.x = 1;
% roi.y = 1;
% roi.width = 324;
% roi.height = 344;

%for the rightside
roi.x = 330;
roi.y = 1;
roi.width = 362;
roi.height = 344;

bg = returnBackgroundModel(pathToTif, roi, firstFrame,lastFrame,stepSize);

se = strel('ball',2,2);
allInfo = zeros(lastFrame-firstFrame + 1,5);
tic
for fn = firstFrame:lastFrame

    img = readFrame(fn, pathToTif, roi);
    changeMask = uint16(bg - double(img));
    
    changeMaskThresh = zeros(size(changeMask));
    %TODO: make this threshold accessable
    changeMaskThresh(find(changeMask>5000)) = 1;

    [x, y] = find(changeMaskThresh>0);
    xPos = floor(mean(x));
    yPos = floor(mean(y));
    allInfo(fn,1) = fn;
    allInfo(fn,2) = 1;
    allInfo(fn,3) = xPos;
    allInfo(fn,4) = yPos;
    allInfo(fn,5) = floor(mean2(img));
    %imshow(changeMaskThresh,[]);
    %pause(0.1);
    if ~(mod(fn,100))   
        display(fn)
    end
end
roi_text = strcat(num2str(roi.x),'_',num2str(roi.y),'_',num2str(roi.width),'_', num2str(roi.height));

csvwrite(strcat(pathToTif, '/allInfo_',roi_text,'.csv'), allInfo);



