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
    figTitle = strrep(figTitle, '_', '-');
    figTitle = strrep(figTitle, 'allInfo', '');
    figTitle = figTitle(1:(length(figTitle)-10));

    for ii = 1:length(segVel)
        curBvel = segVel{ii}(:,1);curBvel(find(curBvel<0)) = [];
        curDvel = segVel{ii}(:,2);curDvel(find(curDvel<0)) = [];
        curAvel = segVel{ii}(:,3);curAvel(find(curAvel<0)) = [];
        
        lbls=[];
        lbls = [lbls;repmat('dark1',length(curBvel),1)];
        lbls = [lbls;repmat('light',length(curDvel),1)];
        lbls = [lbls;repmat('dark2',length(curAvel),1)]; 
        curVel = [curBvel; curDvel; curAvel];        
   
        allVbefore = [allVbefore; curBvel];
        allVduring = [allVduring; curDvel];
        allVafter  = [allVafter; curAvel];
        subplot(3,2,ii);
        %boxplot([curBvel curDvel curAvel],'colors',['b','g','k']);

        boxplot(curVel, lbls,'colors',['b','g','k']);
        ylabel('Velocity (px/frame)');
        title( strcat(figTitle,num2str(ii)) );
        hold on;
        %mx = mean([curBvel curDvel curAvel]);
        mx   = [mean(curBvel), mean(curDvel),mean(curAvel)];
        stdx = [std(curBvel), std(curDvel),std(curAvel)];
        %stdx = std([curBvel curDvel curAvel]);
        xstr1 = strcat('mean : ',num2str(mx));
        xstr2 = strcat('std  : ',num2str(stdx));
        xstr = sprintf('%s\n%s',xstr1,xstr2);
        xlabel(xstr);
    end
    %text(3, 32,figTitle);

    figFileName = strcat(figTitle,'_segmentedBoxPlots.tif');
    saveas(h,figFileName);

    
    
    h = figure;
    
    all_lbls=[];
    all_lbls = [all_lbls;repmat('dark1',length(allVbefore),1)];
    all_lbls = [all_lbls;repmat('light',length(allVduring),1)];
    all_lbls = [all_lbls;repmat('dark2',length(allVafter),1)]; 
    all_Vel = [allVbefore; allVduring; allVafter];
    boxplot(all_Vel, all_lbls, 'colors',['b','g','k']);    
    ylabel('Velocity (px/frame)');
    
    %boxplot([allVbefore allVduring allVafter], 'colors',['b','g','k']);
    title(strcat(figTitle, ' -- ', 'all data'));
    figFileName = strcat(figTitle,'_collectiveBoxPlot.tif');
    saveas(h,figFileName);

end
