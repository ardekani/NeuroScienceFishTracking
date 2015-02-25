function [figureHandle figTitle] = plotLightDarkTrajectories(filename)

[lightOns, lightOffs, averageIntensity] = findLightsOnOffFrames(filename);

trackLeft = csvread(filename);
tmp = strsplit(filename,'/');
expName = tmp(length(tmp)-2);
[a b c] = fileparts(filename);

figTitle = char(strcat(expName,b));

figTitle = strrep(figTitle, '_', '-')

figTitle = strrep(figTitle, 'allInfo', '')


figureHandle = figure;

% make this num better.. will fail
num = ceil(sqrt(length(lightOns)));

xPos = trackLeft(:,3);
yPos = trackLeft(:,4);

halfTime = 180;
for ll = 1:length(lightOns)
%     subplot(num,num-1,ll);
%     axis square;
    on  = lightOns(ll);
    off = lightOffs(ll);
    darkIndx1 = (on - halfTime):(on-1);
    darkIndx2 = off:(off + halfTime-1);
    %darkIndx = [darkIndx1,darkIndx2];
    
    darkIndx1(find(darkIndx1<=0)) = 1;
    darkIndx1(find(darkIndx1>length(xPos))) = length(xPos);
    
    darkIndx2(find(darkIndx2<=0)) = 1;
    darkIndx2(find(darkIndx2>length(xPos))) = length(xPos);
    
    lightIndx = on:off;
    
    h = figure;
    axis square;

    plot(xPos(darkIndx1),yPos(darkIndx1),'.b');
    hold on;
    plot(xPos(lightIndx),yPos(lightIndx),'.g');
    plot(xPos(darkIndx2),yPos(darkIndx2),'.k');
    xlim([1 350]);
    ylim([1 350]);
    legend('before light', 'during light', 'after light', 'location','northwest');
    xlabel('X(pixels)')
    ylabel('Y(pixels)')
    title(figTitle);
    grid on;
    hold off;
    figFileName = strcat(figTitle,num2str(ll),'.tif');
    saveas(h,figFileName);
end

%suptitle(figTitle);

end
