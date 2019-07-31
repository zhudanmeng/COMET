clc;clear all;
load ('posResults','-mat');

for iUser = 1 : 10    
    decisions = posResults(1,iUser).decision;
    targets = posResults(1,iUser).targets;
    
    for iNumClusters = [2,4,8,16]            
        posClusters = [];
        switch iNumClusters
            case 2
                posClusters(1,1,:) = [1:8];
                posClusters(1,2,:) = [9:16];
                
                posClusters(2,1,:) = [1:2:15];
                posClusters(2,2,:) = [2:2:16];
                
                posClusters(3,1,:) = [1:4,9:12];
                posClusters(3,2,:) = [5:8,13:16];                
            case 4
                posClusters(1,1,:) = [1:4];                
                posClusters(1,2,:) = [5:8];                
                posClusters(1,3,:) = [9:12];                
                posClusters(1,4,:) = [13:16];                
                
                posClusters(2,1,:) = [1,2,9,10];                
                posClusters(2,2,:) = [3,4,11,12];                
                posClusters(2,3,:) = [5,6,13,14];                
                posClusters(2,4,:) = [7,8,15,16];                
                
                posClusters(3,1,:) = [1,3,5,7];                
                posClusters(3,2,:) = [2,4,6,8];                
                posClusters(3,3,:) = [9,11,13,15];                
                posClusters(3,4,:) = [10,12,14,16];                
                
                posClusters(4,1,:) = [1,3,9,11];                
                posClusters(4,2,:) = [2,4,10,12];                
                posClusters(4,3,:) = [5,7,13,15];                
                posClusters(4,4,:) = [6,8,14,16];                
            case 8
                posClusters(1,1,:) = [1,9];                
                posClusters(1,2,:) = [2,10];                
                posClusters(1,3,:) = [3,11];                
                posClusters(1,4,:) = [4,12];   
                posClusters(1,5,:) = [5,13];                
                posClusters(1,6,:) = [6,14];                
                posClusters(1,7,:) = [7,15];                
                posClusters(1,8,:) = [8,16];
                
                posClusters(2,1,:) = [1,2];                
                posClusters(2,2,:) = [3,4];                
                posClusters(2,3,:) = [5,6];                
                posClusters(2,4,:) = [7,8];   
                posClusters(2,5,:) = [9,10];                
                posClusters(2,6,:) = [11,12];                
                posClusters(2,7,:) = [13,14];                
                posClusters(2,8,:) = [15,16];
                
                posClusters(3,1,:) = [1,3];                
                posClusters(3,2,:) = [2,4];                
                posClusters(3,3,:) = [5,7];                
                posClusters(3,4,:) = [6,8];   
                posClusters(3,5,:) = [9,11];                
                posClusters(3,6,:) = [10,12];                
                posClusters(3,7,:) = [13,15];                
                posClusters(3,8,:) = [14,16];
                
            case 16                
                posClusters(1,1,:) = [1];                
                posClusters(1,2,:) = [2];                
                posClusters(1,3,:) = [3];                
                posClusters(1,4,:) = [4];   
                posClusters(1,5,:) = [5];                
                posClusters(1,6,:) = [6];                
                posClusters(1,7,:) = [7];                
                posClusters(1,8,:) = [8];
                posClusters(1,9,:) = [9];                
                posClusters(1,10,:) = [10];                
                posClusters(1,11,:) = [11];                
                posClusters(1,12,:) = [12];   
                posClusters(1,13,:) = [13];                
                posClusters(1,14,:) = [14];                
                posClusters(1,15,:) = [15];                
                posClusters(1,16,:) = [16];
        end
        
        for iCase = 1 : size(posClusters,1)            
            errCount = 0;
            
            for iFrame = 1:length(targets)
                %% Use Position Using EMG                          
                
                detectedPosition = decisions(iFrame);                
                knownPosition = targets(iFrame);                                    
                                
                detectedClusterIdx = 0;
                knownClusterIdx = 0;
                
                for iCluster = 1 : iNumClusters
                    clusterIncldsDtctdPos = size(find(posClusters(iCase,iCluster,:)==detectedPosition),1);
                    clusterIncldsKnownPos = size(find(posClusters(iCase,iCluster,:)==knownPosition),1);
                    
                    if clusterIncldsDtctdPos
                        detectedClusterIdx = iCluster;
                    end
                    if clusterIncldsKnownPos
                        knownClusterIdx = iCluster;
                    end                                 
                    
                    if clusterIncldsDtctdPos ~= clusterIncldsKnownPos
                        errCount  = errCount + .5; % counts twice: once for target, once for decision
                    end
                end                
            end
            emgPosClassificationResults(iUser).error(iNumClusters,iCase) = 100*errCount / length(targets);
        end
    end
end







