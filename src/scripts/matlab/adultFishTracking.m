
function adultFishTracking(pathToTif, firstFrame, lastFrame)

stepSize = 100;

roiLeft.x = 1;
roiLeft.y = 1;
roiLeft.width= 324;
roiLeft.height = 344;

roiRight.x = 335;
roiRight.y = 1;
roiRight.width = 362;
roiRight.height = 344;

roiList = {roiLeft, roiRight};
for rr = 1:length(roiList)
    
    roi= roiList{rr};
    bg = returnBackgroundModel(pathToTif, roi, firstFrame,lastFrame,stepSize);

    allInfo = zeros(lastFrame-firstFrame + 1,5);
    %for fn = firstFrame:lastFrame
    %for fn = 2186:2726
    for fn = 1517:2056
        frameStr = num2str(fn,'%.9d');
        fname = strcat('orig_img_',frameStr,'_Default_000.png');
        img = readFrame(fn, pathToTif, roi);
        h1 = figure;
        imshow(img,[]);
        saveas(h1, fname);
        close(h1);
        changeMask = uint16(bg - double(img));
%         imshow(changeMask,[]);
%         pause(0.2);
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
%         imshow(changeMaskThresh,[]);
%         hold on;
%         plot(allInfo(fn,4), allInfo(fn,3),'o', 'linewidth',2);
%         pause(0.2);
%         hold off;
        frameStr = num2str(fn,'%.9d');
        fname = strcat('output_img_',frameStr,'_Default_000.png');
        h = figure;
        imshow(changeMaskThresh,[]);
        hold on;
        plot(allInfo(fn,4), allInfo(fn,3),'.', 'MarkerSize',20);
        saveas(h,fname); % will create FIG1, FIG2,...
        hold off;
        close (h);
    
        if ~(mod(fn,1000))
            display(fn)
        end
    
    end
    
    roi_text = strcat(num2str(roi.x),'_',num2str(roi.y),'_',num2str(roi.width),'_', num2str(roi.height));
    if (rr==1)
        roi_text='leftChamberNew';
    else
        roi_text = 'rightChamberNew';
    end
    
    csvwrite(strcat(pathToTif, '/allInfo_',roi_text,'.csv'), allInfo);
    
end

end


