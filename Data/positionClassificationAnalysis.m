clc;clear all;
load ('posResults','-mat');

posClusters = [];
positionErr = [];

for iUser = 1 : 10
    decisions = posResults(1,iUser).decision;
    targets = posResults(1,iUser).targets;
    
    posFrames = [];
    currentPos = 1;
    lastPosEnd = 0;
    
    for iFrame = 1 : length(targets)
        if targets(iFrame) == currentPos + 1
            posFrames(currentPos).frames = [lastPosEnd + 1 : iFrame - 1];
            lastPosEnd = iFrame - 1;
            currentPos = currentPos + 1;
        end
    end
    posFrames(length(posFrames)+1).frames = [lastPosEnd + 1 : iFrame];
    currentClusters = posFrames;        
    
    for iPos = 1 : 16
        currentClusters(iPos).positions = [iPos];
    end
    
    for iNumClust = 16 : -1 : 2  
        posClusters(iUser,iNumClust).clusters = currentClusters;
        positionErr(iUser,iNumClust) = 100*sum(decisions~=targets) / length(targets);
        
        countRes(iUser).counter = zeros(iNumClust,iNumClust);
        for iClust = 1 : iNumClust
            for iTar = currentClusters(iClust).frames
                countRes(iUser).counter(decisions(iTar),iClust) = countRes(iUser).counter(decisions(iTar),iClust) + 1/((length(currentClusters(iClust).positions))*(length(currentClusters(decisions(iTar)).positions)));
            end
        end    
    
        countRes(iUser).normCounter = countRes(iUser).counter;
        for iCol = 1 : iNumClust
            countRes(iUser).normCounter(:,iCol) = countRes(iUser).counter(:,iCol) / sum(countRes(iUser).counter(:,iCol));    
        end                
    
        maxVal = 0;
        maxCol = 1;
        maxRow = 1;
        for iCol = 1 : iNumClust
            [val,idx] = sort(countRes(iUser).normCounter(:,iCol),'descend');            
            
            canMerge = false;
            for i = 1 : length(idx)
                if idx(i)==iCol
                    continue;
                end
                
                clust1 = currentClusters(idx(i));
                clust2 = currentClusters(iCol);
                                
                for ic1 = clust1.positions;
                    for ic2 = clust2.positions;
                        if abs(ic1-ic2)==8 || (ic1<9 && ic2<9 && rem(ic1+ic2,2)==0 && abs(ic1-ic2)==2) ...
                                           || (ic1>8 && ic2>8 && rem(ic1+ic2,2)==0 && abs(ic1-ic2)==2) ...
                                           || (ic1<9 && ic2<9 && rem(max(ic1,ic2),2)==0 && abs(ic1-ic2)==1) ...
                                           || (ic1>8 && ic2>8 && rem(max(ic1,ic2),2)==0 && abs(ic1-ic2)==1) ...
                            canMerge = true;
                        end
                    end
                end
                if canMerge
                    break;
                end
            end            
            
            maxIdx = idx(i);
            mVal = val(i);

            if mVal > maxVal
                maxVal = mVal;
                maxCol = iCol;
                maxRow = maxIdx;
            end
        end
        
        % clusters maxCol and maxRow should be combined
        minClust = min(maxCol, maxRow);
        maxClust = max(maxCol, maxRow);
        
        nextClusters = [];        
        
        iClust = 1;
        while iClust < minClust
            nextClusters(iClust).positions = currentClusters(iClust).positions;
            nextClusters(iClust).frames = currentClusters(iClust).frames;
            iClust = iClust + 1;
        end
        
        % combine minClust and maxClust
        combinedCluster = currentClusters(minClust);
        combinedCluster.positions = [combinedCluster.positions currentClusters(maxClust).positions];
        combinedCluster.frames = [combinedCluster.frames currentClusters(maxClust).frames];
        nextClusters(iClust).positions = combinedCluster.positions;
        nextClusters(iClust).frames = combinedCluster.frames;
        
        targets(targets == maxClust) = minClust;
        decisions(decisions == maxClust) = minClust;
        
        unqTar = unique(targets);
        unqDec = unique(decisions);
        for iFrame =  1: length(targets)
            targets(iFrame) = find(unqTar == targets(iFrame));
            decisions(iFrame) = find(unqDec == decisions(iFrame));
        end
        
        iClust = iClust + 1;
        
        % ignore maxClust because it is already combined
        while iClust < maxClust
            nextClusters(iClust).positions = currentClusters(iClust).positions;
            nextClusters(iClust).frames = currentClusters(iClust).frames;
            iClust = iClust + 1;
        end  
        
        % add the rest of clusters to next clusters array
        while iClust < iNumClust
            nextClusters(iClust).positions = currentClusters(iClust+1).positions;
            nextClusters(iClust).frames = currentClusters(iClust+1).frames;
            iClust = iClust + 1;
        end  
        
        currentClusters = nextClusters;
    end
end
