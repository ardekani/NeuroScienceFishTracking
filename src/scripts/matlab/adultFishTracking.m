% Author: Reza Ardekani
% Date  : Feb 2015
% Input:
       %pathToTif : the path to the directory  
       %firstFrame 
       %lastFrame
       %roiList: this is a list of roi objects: (roi.x, roi.y) is the top
       %left corner and roi.width and roi.height are width and height
 
% Output:
       % one csv file for each roi
       % ROI naming format is :
        %  1     2    3  ...n
        % n+1   n+2  n+3 ...2n
        % so with four - the order should be topleft, topright, bottomleft,
        % bottomright
        %output file name is allInfo_roi_{roi_number},'.csv' and it's
        %saved in the same directory as tiff files.
       
%TODO:
% Get stepSize as input arguement
% Get threshold as input arguement
% Sanity check of input arguements
% TO increase the speed: process all ROI's with one readframe command

function adultFishTracking(pathToTif, firstFrame, lastFrame, roiList)

    stepSize = 100;
    thresh = 50;

    for rr = 1:length(roiList)

        roi= roiList{rr};
        bg = returnBackgroundModel(pathToTif, roi, firstFrame,lastFrame,stepSize);

        allInfo = zeros(lastFrame-firstFrame + 1,5);
        for fn = firstFrame:lastFrame
            img = readFrame(fn, pathToTif, roi);
            changeMask = uint16(bg - double(img));
    %         imshow(changeMask,[]);
    %         pause(0.2);
            changeMaskThresh = zeros(size(changeMask));
            %TODO: replace find with logical index to improve the speed
            changeMaskThresh(find(changeMask>thresh)) = 1;

            [x, y] = find(changeMaskThresh>0);
            xPos = floor(mean(x));
            yPos = floor(mean(y));
            allInfo(fn-firstFrame+1,1) = fn;
            allInfo(fn-firstFrame+1,2) = 1;
            allInfo(fn-firstFrame+1,3) = xPos;
            allInfo(fn-firstFrame+1,4) = yPos;
            allInfo(fn-firstFrame+1,5) = floor(mean2(img));
    %         imshow(changeMaskThresh,[]);
    %         hold on;
    %         plot(allInfo(fn,4), allInfo(fn,3),'o', 'linewidth',2);
    %         pause(0.2);
    %         hold off;
            if ~(mod(fn,1000))
                display(fn)
            end
        end

        roi_text = strcat('roi_',num2str(rr));
        csvwrite(strcat(pathToTif, '/allInfo_',roi_text,'.csv'), allInfo);

    end

end


