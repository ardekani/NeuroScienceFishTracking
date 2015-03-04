function [allSegmentsVel] = extractInfoFromTrajectories(trajFile)

    tracks = csvread(trajFile);
    xPos = tracks(:,4);
    yPos = tracks(:,3);
    vv = diff(xPos).^2 + diff(yPos).^2;
    V = sqrt(vv);
    V = [V;V(length(V))];
    [lightOns, lightOffs, averageIntensity] = findLightsOnOffFrames(trajFile);
    halfTime = 180; %TODO : make it an input arguement
    allSegmentsVel = [];
    for ll = 1:length(lightOns)
        on  = lightOns(ll);
        off = lightOffs(ll);
        darkIndx1 = (on - halfTime):(on-1);
        darkIndx2 = off:(off + halfTime-1);

        darkIndx1(find(darkIndx1<=0)) = 1;
        darkIndx1(find(darkIndx1>length(xPos))) = length(xPos);
        darkIndx1 = unique(darkIndx1);

        darkIndx2(find(darkIndx2<=0)) = 1;
        darkIndx2(find(darkIndx2>length(xPos))) = length(xPos);
        darkIndx2 = unique(darkIndx2);
        lightIndx = on:off;   
        Vbefore = V(darkIndx1);
        Vafter = V(darkIndx2);
        Vduring = V(lightIndx);
        
        %to make all vectors the same length.. will remove it afterwards
       maxLength = max(max(length(Vbefore),length(Vduring)),length(Vafter));
       Vbefore = [Vbefore;repmat(-1,maxLength-length(Vbefore),1)];
       Vafter  = [Vafter; repmat(-1,maxLength-length(Vafter),1)];
       Vduring = [Vduring;repmat(-1,maxLength-length(Vduring),1)]; 
        %TODO: FIX THIS!!
%         if (length(Vbefore) == length(Vduring) && length(Vafter)==length(Vduring))
             allSegmentsVel{ll} = [Vbefore, Vduring, Vafter]; 
%         end
    end
end