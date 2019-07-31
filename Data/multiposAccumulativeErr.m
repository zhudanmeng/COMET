load ('posCombs');
load ('PosNumStartEndIdx');

% load myResults
myResults = myResults(1,1);

lastBest = [];
for iNumPos = 1 : 16   
    minErr = inf;
    minErrIdx = 0;
    addingPos = 0;
    for iPosComb = posNumStartEndIdx(iNumPos,1):posNumStartEndIdx(iNumPos,2)        
        if all(ismember(lastBest, posCombs(iPosComb).comb))                                    
            addingPos = addingPos + 1;
            while(size(find(lastBest==addingPos),2))
                addingPos = addingPos + 1;
            end
            if (myResults.multiPosEMGErr(iPosComb) < minErr)
                minErr = myResults.multiPosEMGErr(iPosComb);
                minErrIdx = iPosComb;
                addedPos = addingPos;
            end
        end
    end
    
    minMultErrIdx(iNumPos) = minErrIdx;
    minMultErr(iNumPos) = minErr;
    minMultAddedPos(iNumPos) = addedPos;
    lastBest = posCombs(minErrIdx).comb;
end
