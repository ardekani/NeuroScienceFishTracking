function [figureHandle figTitle] = plotLightDarkTrajectories(filename)

%[lightOns, lightOffs, averageIntensity] = findLightsOnOffFrames(filename);

    load('lightOnOffInfo.mat');
    if(~isempty(strfind(filename,'2015-03-27_essay1')))
        pp = 1;
    elseif (~isempty(strfind(filename,'2015-03-30_essay1')))
        pp=2;
    elseif (~isempty(strfind(filename,'2015-03-31_essay1')))
        pp = 3;
    end
    lightOns = lightOnAll{pp};
    lightOffs = lightOffAll{pp};

trackLeft = csvread(filename);
tmp = strsplit(filename,'\');
expName = tmp(length(tmp)-2);
[a b c] = fileparts(filename);

figTitle = char(strcat(expName,b));

figTitle = strrep(figTitle, '_', '-')

figTitle = strrep(figTitle, 'allInfo', '')


figureHandle = figure;

% make this num better.. will fail
num = ceil(sqrt(length(lightOns)));

xPos = trackLeft(:,4); % switched x and y 
yPos = 350 - trackLeft(:,3); % swithced up and down
%yPos = (max(trackLeft(:,3))+20) - trackLeft(:,3); % swithced up and down

%halfTime = 180;
halfTime = floor(mean(lightOffs-lightOns)/2);

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
    xlabel('X(pixels)');
    ylabel('Y(pixels)');
    
    title(strcat(figTitle,'-cycle-',num2str(ll)));
    grid on;
    hold off;
    figFileName = strcat(figTitle,'-cycle-',num2str(ll),'.tif');
    saveas(h,figFileName);
end

%suptitle(figTitle);

end
