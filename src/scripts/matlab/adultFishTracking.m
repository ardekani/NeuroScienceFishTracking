% TODO:
% get ROI as input arguement
% get stepSize as input arguement
% process all ROI's with one readframe command

% ROI naming format is :
%  1     2    3  ...n
% n+1   n+2  n+3 ...2n
% so with four - the order should be topleft, topright, bottomleft,
% bottomright



function adultFishTracking(pathToTif, firstFrame, lastFrame, roiList)

stepSize = 100;
thresh = 50;
% roiLeft.x = 1;
% roiLeft.y = 1;
% roiLeft.width= 324;
% roiLeft.height = 344;
% 
% roiRight.x = 335;
% roiRight.y = 1;
% roiRight.width = 362;
% roiRight.height = 344;
% 
% roiList = {roiLeft, roiRight};
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
        %TODO: make this threshold accessable
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
%     roi_text = strcat(num2str(roi.x),'_',num2str(roi.y),'_',num2str(roi.width),'_', num2str(roi.height));
%     if (rr==1)
%         roi_text='leftChamberNew';
%     else
%         roi_text = 'rightChamberNew';
%     end
    roi_text = strcat('roi_',num2str(rr));
    
    csvwrite(strcat(pathToTif, '/allInfo_',roi_text,'.csv'), allInfo);
    
end

end


