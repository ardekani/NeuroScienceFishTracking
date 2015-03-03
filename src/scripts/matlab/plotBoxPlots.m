function plotBoxPlots(trajFile)

    segVel = extractInfoFromTrajectories(trajFile);
    allVbefore = [];
    allVduring = [];
    allVafter = [];
    h = figure;
    [a b c] = fileparts(trajFile);
    tmp = strsplit(trajFile,'/');
    expName = tmp(length(tmp)-2);
    [a b c] = fileparts(trajFile);
    figTitle = char(strcat(expName,b));
    figTitle = strrep(figTitle, '_', '-')
    figTitle = strrep(figTitle, 'allInfo', '')


    for ii = 1:length(segVel)
        curBvel = segVel{ii}(:,1);
        curDvel = segVel{ii}(:,2);
        curAvel = segVel{ii}(:,3);
        allVbefore = [allVbefore; curBvel];
        allVduring = [allVduring; curDvel];
        allVafter  = [allVafter; curAvel];
        subplot(3,2,ii);
        boxplot([curBvel curDvel curAvel],'colors',['b','g','k']);
        hold on;
        mx = mean([curBvel curDvel curAvel]);
        stdx = std([curBvel curDvel curAvel]);
        xstr1 = strcat('mean : ',num2str(mx));
        xstr2 = strcat('std  : ',num2str(stdx));
        xstr = sprintf('%s\n%s',xstr1,xstr2);
        xlabel(xstr);
    end
    text(3, 32,figTitle);

    figFileName = strcat(figTitle,'_segmentedBoxPlots.tif');
    saveas(h,figFileName);

    h = figure;boxplot([allVbefore allVduring allVafter], 'colors',['b','g','k']);
    title(strcat(figTitle, ' -- ', 'all data'));
    figFileName = strcat(figTitle,'_collectiveBoxPlot.tif');
    saveas(h,figFileName);

end
