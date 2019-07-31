load ('myResults' , '-mat');
load ('posCombs' , '-mat');
load ('posNumStartEndIdx' , '-mat');

% load ('Results\myResults.mat' , '-mat');
% load ('Results\posCombs.mat' , '-mat');
% load ('Results\posNumStartEndIdx.mat' , '-mat');

combIdxs =[];

for iUser = 1 : 4
    for posCount = 2 : 4 
        [val,idx] = sort(myResults(iUser).multiPosEMGErr(posNumStartEndIdx(posCount,1):posNumStartEndIdx(posCount,2)));        
        userCombIdxs(iUser,posCount).list = idx(1:16);
        for iPos = 1 : 16
            combIdxs(iUser,posCount, iPos).list = [];
            posCountMatrix(iUser,posCount, iPos) = 0;
            for iComb = idx(1:10) + posNumStartEndIdx(posCount-1,2)                
                if size(find(posCombs(iComb).comb == iPos),2)
                    combIdxs(iUser,posCount, iPos).list(length(combIdxs(iUser,posCount,iPos).list) + 1) = iComb;
                    posCountMatrix(iUser,posCount, iPos) = posCountMatrix(iUser,posCount, iPos) + 1; 
                end
            end
        end
    end

    for posCount = 2 : 4   
        for iPos = 1 : 16
            errSum = 0 ;
            for iComb = combIdxs(iUser,posCount, iPos).list
                errSum = errSum + myResults(iUser).multiPosEMGErr(iComb);
            end
            accumErr(iUser,posCount,iPos) = errSum;
        end
    end
end