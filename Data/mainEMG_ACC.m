addpath 'C:\Users\Peter Zhu\Documents\MATLAB'
clear
close all
clc
           
users{1} = '\Data\Subjects\Ashkan2_.USER';
repOrder{1} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16];  

users{2} = '\Data\Subjects\Ali_.USER';
repOrder{2} = [ 8  1  3  7  2  4  5  6 15 11  9 16 13 12 10 14 ...
               11 15  9 16 12 13 14 10  8  7  5  1  6  3  2  4 ...
                7  4  8  3  2  6  5  1 16 10 12 13 11 14  9 15 ...
               16 13 15 12 11 14  9 10  5  6  3  2  4  1  7  8];

users{3} = '\Data\Subjects\Rolando_.USER';
repOrder{3} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
               15 14 11 16 13 12  9 10  4  6  2  7  8  5  1  3 ...
                4  8  6  3  7  1  2  5 13 10 14 12 16 15  9 11 ...
               14  9 12 16 15 10 13 11  4  3  8  1  5  2  6  7];  
           
users{4} = '\Data\Subjects\Bahareh_.USER';
repOrder{4} = [ 4  3  5  6  7  8  1  2 12  9 10 15 16 14 11 13 ...
                9 12 11 14 15 10 16 13  6  8  3  4  7  2  1  5 ...
                7  5  8  4  3  6  2  1 10 14 16  9 15 13 12 11 ...
               15 16 13 12 10 11 14  9  5  1  2  6  8  7  4  3];  
           
users{5} = '\Data\Subjects\AB_.USER';    % Ali Bagherpour
repOrder{5} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
               13 10  9 15 14 16 11 12  8  2  3  1  6  5  4  7 ...
                6  1  5  3  7  2  8  4 16 14 12 13  9 15 11 10 ...
               12 14 10 15 11 16 13  9  7  6  3  8  5  4  1  2];  

users{6} = '\Data\Subjects\AM_.USER';    % Arash Mansouri
repOrder{6} = [ 4  5  8  6  3  7  1  2 13 10 14 12 16 15  9 11 ...
               16 14 12 13  9 15 11 10  6  1  5  3  7  2  8  4 ...
                8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
               16 11 12  9 13 10 14 15  6  1  4  3  8  7  2  5]; 

users{7} = '\Data\Subjects\SHR_.USER';    % Shayan Rafizadeh
repOrder{7} = [ 3  5  7  4  2  8  1  6 16  9 11 15 10 12 13 14 ...
               11 15  9 16 12 13 14 10  7  3  1  8  5  4  2  6 ...
                8  7  5  1  6  3  2  4 12 15 16 11 10 14 13  9 ...
               16 13 15 12 11 14  9 10  8  2  4  5  3  6  1  7]; 
          
users{8} = '\Data\Subjects\MRR_.USER';    % Mohammad Reza Rafipour
repOrder{8} = [ 3  1  6  7  2  5  4  8 15  9 13 16 14 10 12 11 ...
               14 11  9 15 12 13 10 16  1  7  4  2  8  3  6  5 ...
                6  8  7  2  3  5  1  4 10  9 15 16 11 12 14 13 ...
               11  9 15 16 10 14 12 13  2  7  5  8  1  4  3  6]; 
           
users{9} = '\Data\Subjects\AZ_.USER';    % Abtin Zohrabi
repOrder{9} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
                14  9 13 11 15 10 16 12  8  6  4  5  1  7  3  2 ...
                 8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
                15 14 11 16 13 12  9 10  4  6  2  7  3  8  5  1];
           
users{10} = '\Data\Subjects\AP_.USER';    % Amir Pourafshar
repOrder{10} = [ 8  6  4  5  3  1  2  7 14 10 11 12  9 16 13 15 ...
                12 10 11  9 13 14 16 15  5  2  4  8  1  3  7  6 ...
                 8  3  6  4  5  2  1  7 10 16  9 11 13 15 12 14 ...
                12 13 16 14 11 15  9 10  4  3  5  6  7  8  1  2];

           
userList = 1:length(users);
userList = [1:10];

className{1} = 'Wrist Flexion';
className{2} = 'Wrist Extension';
className{3} = 'Wrist Pronation';
className{4} = 'Wrist Supination';
className{5} = 'Wrist Abduction';
className{6} = 'Wrist Adduction';
className{7} = 'Hand Open';
className{8} = 'Key Grip';
className{9} = 'Chuck Grip';
className{10} = 'Power Grip';
className{11} = 'Pinch Grip';
className{12} = 'No Movement';

desc{1}  = 'P1:  Arm Down Left Far';
desc{2}  = 'P2:  Arm Down Right Far';
desc{3}  = 'P3:  Arm Mid Left Far';
desc{4}  = 'P4:  Arm Mid Right Far';
desc{5}  = 'P5:  Arm Forward Left Far';
desc{6}  = 'P6:  Arm Forward Right Far';
desc{7}  = 'P7:  Arm Up Left Far';
desc{8}  = 'P8:  Arm Up Right Far';
desc{9}  = 'P9:  Arm Down Left Close';
desc{10} = 'P10: Arm Down Right Close';
desc{11} = 'P11: Arm Mid Left Close';
desc{12} = 'P12: Arm Mid Right Close';
desc{13} = 'P13: Arm Forward Left Close';
desc{14} = 'P14: Arm Forward Right Close';
desc{15} = 'P15: Arm Up Left Close';
desc{16} = 'P16: Arm Up Right Close';

positions = 1:16;

numPositions = length(positions);

class = [1 2 3 4 7 10 11 12];
numClasses = length(class);

emgChans = 1:8; 
inertialChans = 9:14;  

verbose = 1;

posNumStartEndIdx = [];
posCombs = [];
combNum = 1;
for iNumPos = 1 : 16            
    posNumStartEndIdx(iNumPos,1) = combNum;
    if iNumPos > 1
        posNumStartEndIdx(iNumPos-1,2) = combNum-1;
    end

    curPosCombs = nchoosek(1:numPositions, iNumPos);
    for iComb = 1: size(curPosCombs,1)                                    
        posCombs(combNum).comb = curPosCombs(iComb,:);
        combNum = combNum + 1;
    end
end
posNumStartEndIdx(iNumPos,2) = combNum-1;
save('posCombs','posCombs');
save('posNumStartEndIdx','posNumStartEndIdx');

bestCombs(1,:) = [16,70,344,1536,4892,11959,23104,36522,49015,57773,62738,64775,65321,65511,65534,65535];
bestCombs(2,:) = [15,108,502,2235,6141,9144,18986,30140,43729,52529,58821,63154,64858,65411,65522,65535];
bestCombs(3,:) = [ 8,106,211,1037,2766,8395,15417,27496,39770,52823,59119,63068,64970,65403,65522,65535];
bestCombs(4,:) = [ 2,94,314,1462,4337,10716,15721,26446,39466,51051,58849,63091,64900,65429,65527,65535];
bestCombs(5,:) = [ 1, 30,235,1051,3704,9742,19806,32717,42563,55416,60414,63949,65175,65459,65532,65535];
bestCombs(6,:) = [11,86,259,1976,5921,12213,21785,26656,39803,51430,59383,63500,65035,65457,65522,65535];
bestCombs(7,:) = [ 4,104,378,1414,6802,11815,22833,36178,48369,58649,62653,64018,65202,65476,65532,65535];
bestCombs(8,:) = [ 8,63,337,906,3241,8804,15811,27658,43230,54125,59460,64386,64896,65402,65519,65535];
bestCombs(9,:) = [4,95,321,1139,4626,11588,22787,29327,41605,53022,60384,63850,65169,65452,65529,65535];
bestCombs(10,:) = [2,35,282,2260,5836,10841,15846,28093,46305,56198,62048,64557,65012,65458,65530,65535];

for iUser = 1:length(userList)

    clearvars -except numClasses class numPositions positions desc className users iUser emgChans repOrder bestCombs...
        inertialChans userResults verbose featType iFeat allClassifiers userList posCombs posNumStartEndIdx combNum myResults

    try
        diaryFile = ['userLog_' featType '_' num2str(userList(iUser)) '.txt'];
        diary off
        if exist(diaryFile,'file')
            eval(['delete ' diaryFile]);
        end
    catch
    end

    diary(['userLog' num2str(userList(iUser)) '.txt']);
    diary on

    disp(['Loading User File ' num2str(iUser) ' of ' num2str(length(userList))]);

    loadPath = [pwd users{userList(iUser)}];
    load(loadPath,'-mat');       

    if exist('sessionInfo','var');            

        className{1} = 'No Movement';
        className{2} = 'Wrist Flexion';
        className{3} = 'Wrist Extension';
        className{4} = 'Wrist Pronation';
        className{5} = 'Wrist Supination';
        className{6} = 'Key Grip';
        className{7} = 'Chuck Grip';
        className{8} = 'Power Grip';
        className{9} = 'Pinch Grip';
        className{10} = 'Point Grip';
        className{11} = 'Hook Grip';
        className{12} = 'Hand Open';

        class = [1 2 3 4 5 8 9 12];  %[1 2 3 8];
        numClasses = length(class);

        positions = 1:16;
        numPositions = length(positions);

        emgChans = 1:6;

        inertialChans = 9:32;
%             inertialChans = [7  8  9  19 20 21];            % Roll-Pitch-Yaw
        inertialChans = [12 13 14 24 25 26];            % ACCEL
%             inertialChans = [10 11 12 13 14 15 22 23 24 25 26 27]; %ACCEL-GYRO
%             inertialChans = [13 14 15 25 26 27];            % Gyro
%             inertialChans = [16 17 18 28 29 30];            % MAG

        for i = 1:length(sessionInfo.prData) 
            tmpLoadPath = [loadPath(1:length(loadPath)-5) num2str(i) '.USER'];
            load(tmpLoadPath,'-mat');         
            sessionInfo.prData(i) = tmpClassData;
            clear tmpClassData;
        end 

        userInfo.prSetup.prData = sessionInfo.prData; 
        userInfo.settings = sessionInfo.settings;
    end

    disp('Formatting the Data Structure');

    data = [];
    for iClass=1:numClasses
        for iPos=1:numPositions
            posReps = find(repOrder{userList(iUser)}==positions(iPos));
            %==============================
            posReps = posReps(1:2);
            %==============================
            data(iClass,iPos).EMG = [];
            data(iClass,iPos).ACCEL = [];
            for iRep = 1:length(posReps)
                data(iClass,iPos).EMG = [data(iClass,iPos).EMG; ...
                    userInfo.prSetup.prData(class(iClass)).trainData(userInfo.prSetup.prData(class(iClass)).trainRepStart(posReps(iRep)) ...
                    : userInfo.prSetup.prData(class(iClass)).trainRepStop(posReps(iRep)),emgChans)];
                newData = userInfo.prSetup.prData(class(iClass)).trainData(userInfo.prSetup.prData(class(iClass)).trainRepStart(posReps(iRep)) ...
                    : userInfo.prSetup.prData(class(iClass)).trainRepStop(posReps(iRep)),inertialChans);

                data(iClass,iPos).ACCEL = [data(iClass,iPos).ACCEL; newData];
            end

            % TODO 
            if find(inertialChans == 7)
                for c = 1 : length (inertialChans)
                    for i =  1001: length(data(iClass,iPos).ACCEL(:,1))
                        meanV = mean(data(iClass,iPos).ACCEL(i-1000:i-1,c));
                        if abs(data(iClass,iPos).ACCEL(i,c)-meanV) > 200
                            if (data(iClass,iPos).ACCEL(i,c) < meanV)
                                data(iClass,iPos).ACCEL(i,c) = data(iClass,iPos).ACCEL(i,c) + 360;
                            else 
                                data(iClass,iPos).ACCEL(i,c) = data(iClass,iPos).ACCEL(i,c) - 360;
                            end
                        end
                    end
                end
            end

            data(iClass,iPos).class = className{class(iClass)};
            data(iClass,iPos).desc = desc{positions(iPos)};
        end
    end

    userInfo.settings.frameLen = 200; %200
    userInfo.settings.frameInc = 100;  %100

    userInfo.settings.enableNotch = 0;
    userInfo.settings.notchFreq = [60 180 300];   % Notch Frequencies
    userInfo.settings.notchQ = 1;                 % Notch Q (Order)

    userInfo.settings.enableLPF = false;          % Enable Low Pass Filtering
    userInfo.settings.enableHPF = false;           % Enable High Pass Filtering

    userInfo.settings.cutoffFreq = 20;            % High Pass Filter Cutoff Frequency
    userInfo.settings.filterOrder = 3;            % High Pass Filter Order                
    userInfo.settings.sampleFreq = 1000;          % Sampling Frequency 

    userInfo.settings.featType = 'TD';
    disp('Extracting and Storing EMG Features from Channels:');
    disp(emgChans);
%     data = extractNormFeatures(data,userInfo.settings,userInfo.settings.featType);

%     disp('Training Single-Stage EMG Classifier (Using Data From Multiple Positions)');
%     %% Train Regular Classifier using EMG from MULTIPLE POSITIONS                        
%     for iComb = 1 : length(posCombs)     
%         if rem(iComb,1000) == 0
%             pause(1);
%         end
%         feats = [];
%         targets = [];
%         for iPos = posCombs(iComb).comb            
%             for iClass = 1:numClasses            
%                 feats = [feats; data(iClass,iPos).emgFeats(1:round(size(data(iClass,iPos).emgFeats,1)/2),:)];   
%                 targets = [targets; iClass*ones(round(size(data(iClass,iPos).emgFeats,1)/2),1)];
%             end
%         end
%               
%         multiPosEMGClassifier(iComb).alda = trainALDA(feats',targets');                                 
%     end        
% 
%     dispv('Testing Single-Stage EMG Classifier (Using Data From Multiple Positions)',verbose);
%     %% Test Regular Classifier (trained using multiple positions) using EMG    
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions
%         for iClass = 1:numClasses
%             idx = round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:)];
%             targets = [targets; iClass*ones(length(idx),1)];
%         end                       
%     end
%         
%     multiPosEMGErr = [];
%     minMultiPosEMGErr = [];
%     iNumPos = 1;
%     minErr = inf;            
%     minErrIdx = 0;            
%     
%     for iComb = 1 : length(posCombs)                
%         ldaScore = feats*multiPosEMGClassifier(iComb).alda.W + repmat(multiPosEMGClassifier(iComb).alda.C,size(feats,1),1);
%         [dum prMotion] = max(ldaScore,[],2);
%         
%         multiPosEMGErr(iComb) = 100*sum(prMotion~=targets) / length(targets);                                               
%         if multiPosEMGErr(iComb) < minErr 
%             minErr = multiPosEMGErr(iComb);
%             minErrIdx = iComb;
%         end
%         
%         if (iComb == posNumStartEndIdx(iNumPos,2))        
%             minMultiPosEMGErr(iNumPos) = minErr;
%             minMultiPosEMGErrIdx(iNumPos) = minErrIdx;
%             minErr = inf;
%             minErrIdx = 0;
%             iNumPos = iNumPos + 1;
%         end
%     end
%     
%     dispv(' ',verbose);
%     dispv(['Training With Multiple Positions, Testing in All Positions minimum ERR (1-16): ' num2str(minMultiPosEMGErr) '%']);
%     dispv(' ',verbose);   
%     
%     myResults(iUser).minMultiPosEMGErr = minMultiPosEMGErr;
%     myResults(iUser).minMultiPosEMGErrIdx = minMultiPosEMGErrIdx;
%     myResults(iUser).multiPosEMGErr = multiPosEMGErr;        
    
    
    %% Extracting Inertial Information
    userInfo.settings.enableHPF = 0;
    disp('Extracting and Storing Inertial Features from Channels:');    
    disp(inertialChans);

    data = extractAccelFeatures(data,userInfo.settings);
   
    %% Train Position Classifier using ACCEL 
    disp('Training ACCEL Based Position Classifier using Forearm ACCEL');
    for iComb = 17 : length(posCombs)  %bestCombs(iUser,2:16)%17 : length(posCombs) 
        feats = [];
        targets = [];
        for iPos = posCombs(iComb).comb % 1:numPositions %1:2:numPositions-1
            for iClass = 1:numClasses
                feats = [feats; data(iClass,iPos).accelFeats(1:round(size(data(iClass,iPos).accelFeats,1)/2),1:length(inertialChans)/2)];
                targets = [targets; iPos*ones(round(size(data(iClass,iPos).accelFeats,1)/2),1)];
            end
        end
    
        posForearmClassifier(iComb).alda = trainALDA(feats',targets');
    end
    
%     %% Test Position Classifier using Forearm ACCEL
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions %1:2:numPositions-1
%         for iClass = 1:numClasses
%             feats = [feats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,1:length(inertialChans)/2)];
%             targets = [targets; iPos*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
%         end
%     end
% 
%     ldaScore = feats*posForearmClassifier.alda.W + repmat(posForearmClassifier.alda.C,size(feats,1),1);
%     [dum prPos] = max(ldaScore,[],2);
% 
%     posForearmResults.decision = prPos;
%     posForearmResults.targets = targets;
%     posForearmResults.err = 100*sum(prPos~=targets) / length(targets);
%     posForearmResults.acc = 100*sum(prPos==targets) / length(targets);
% 
%     confMatrix = zeros(numPositions,numPositions);
%     for i=1:numPositions
%         for j=1:numPositions
%             confMatrix(i,j) = sum(i==prPos(targets==j));
%         end
%     end
%     posForearmResults.confMatrix = confMatrix;
% 
%     disp(' ');
%     disp(['Classification Error of Limb Position Using Forearm ACCEL: ' num2str(posForearmResults.err) '%']);
%     disp(' ');
% 
% 
      %% Train Position Classifier using Humerus ACCEL
    disp('Training ACCEL Based Position Classifier using Humerus ACCEL');
    for iComb = 17 : length(posCombs)%bestCombs(iUser,2:16)%17 : length(posCombs)
        feats = [];
        targets = [];
        for iPos = posCombs(iComb).comb % 1:numPositions% 1:2:numPositions-1
            for iClass = 1:numClasses
                feats = [feats; data(iClass,iPos).accelFeats(1:round(size(data(iClass,iPos).accelFeats,1)/2),length(inertialChans)/2+1:length(inertialChans))];
                targets = [targets; iPos*ones(round(size(data(iClass,iPos).accelFeats,1)/2),1)];
            end
        end

        posHumerusClassifier(iComb).alda = trainALDA(feats',targets');
    end
% 
% 
%     %% Test Position Classifier using Hunerus ACCEL
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions %1:2:numPositions-1
%         for iClass = 1:numClasses
%             feats = [feats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,length(inertialChans)/2+1:length(inertialChans))];
%             targets = [targets; iPos*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
%         end
%     end
% 
%     ldaScore = feats*posHumerusClassifier.alda.W + repmat(posHumerusClassifier.alda.C,size(feats,1),1);
%     [dum prPos] = max(ldaScore,[],2);
% 
%     posHumerusResults.decision = prPos;
%     posHumerusResults.targets = targets;
%     posHumerusResults.err = 100*sum(prPos~=targets) / length(targets);
%     posHumerusResults.acc = 100*sum(prPos==targets) / length(targets);
% 
%     confMatrix = zeros(numPositions,numPositions);
%     for i=1:numPositions
%         for j=1:numPositions
%             confMatrix(i,j) = sum(i==prPos(targets==j));
%         end
%     end
%     posHumerusResults.confMatrix = confMatrix;
% 
%     disp(' ');
%     disp(['Classification Error of Limb Position Using Humerus ACCEL: ' num2str(posHumerusResults.err) '%']);
%     disp(' ');
% 
% 
%     %% Train Position Classifier using Both ACCEL
    disp('Training ACCEL Based Position Classifier using BOTH ACCEL');
    for iComb = 17 : length(posCombs)%bestCombs(iUser,2:16)%17 : length(posCombs)
        feats = [];
        targets = [];
        for iPos = posCombs(iComb).comb % 1:numPositions%1:2:numPositions-1
            for iClass = 1:numClasses
                feats = [feats; data(iClass,iPos).accelFeats(1:round(size(data(iClass,iPos).accelFeats,1)/2),:)];
                targets = [targets; iPos*ones(round(size(data(iClass,iPos).accelFeats,1)/2),1)];
            end
        end

        posBothClassifier(iComb).alda = trainALDA(feats',targets');
    end
% 
% 
%     %% Test Position Classifier using Both ACCEL
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions %1:2:numPositions-1
%         for iClass = 1:numClasses
%             feats = [feats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:)];
%             targets = [targets; iPos*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
%         end
%     end
% 
%     ldaScore = feats*posBothClassifier.alda.W + repmat(posBothClassifier.alda.C,size(feats,1),1);
%     [dum prPos] = max(ldaScore,[],2);
% 
%     posBothResults.decision = prPos;
%     posBothResults.targets = targets;
%     posBothResults.err = 100*sum(prPos~=targets) / length(targets);
%     posBothResults.acc = 100*sum(prPos==targets) / length(targets);
% 
%     confMatrix = zeros(numPositions,numPositions);
%     for i=1:numPositions
%         for j=1:numPositions
%             confMatrix(i,j) = sum(i==prPos(targets==j));
%         end
%     end
%     posBothResults.confMatrix = confMatrix;
% 
%     disp(' ');
%     disp(['Classification Error of Limb Position Using Both ACCEL: ' num2str(posBothResults.err) '%']);
%     disp(' ');
% 
%     myResults(iUser).posForearmResults = posForearmResults;
%     myResults(iUser).posHumerusResults = posHumerusResults;
%     myResults(iUser).posBothResults = posBothResults;
%         
%     save('myResults', 'myResults');
%     
     %% Test Position specific EMG Classifier using output of Position classifiers,
    disp('Training & Testing Dual-Stage EMG & ACCEL Position Specific EMG Classifiers');
       
    %% Get Position Using Forearm, Humerus, and Both ACCEL    
%     forearmFeats = [];
%     humerusFeats = [];
%     bothFeats = [];
%     knownPos = [];
% 
%         
%     for iPos = 1:numPositions%1:2:numPositions-1
%         for iClass = 1:numClasses
%             forearmFeats = [forearmFeats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,1:length(inertialChans)/2)];
%             humerusFeats = [humerusFeats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,length(inertialChans)/2+1:length(inertialChans))];
%             bothFeats    = [bothFeats;    data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:)];
% %             testTargets = [testTargets; iClass*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
% %             testEMGfeats = [testEMGfeats; data(iClass,iPos).emgFeats(round(size(data(iClass,iPos).emgFeats,1)/2)+1:end,:)];
%             knownPos = [knownPos; iPos*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
%         end
%     end
%     
%     for iPos = 1:numPositions
%         feats = [];
%         targets = [];
%         for iClass = 1:numClasses
%             feats = [feats; data(iClass,iPos).emgFeats(1:round(size(data(iClass,iPos).emgFeats,1)/2),:)];   
%             targets = [targets; iClass*ones(round(size(data(iClass,iPos).emgFeats,1)/2),1)];
%         end                
%         dualStageEMGClassifier(iPos).alda = trainALDA(feats',targets');                                
%     end
    
    for iComb = 17 : length(posCombs)%bestCombs(iUser,2:16)%17 : length(posCombs)
    
        forearmFeats = [];
        humerusFeats = [];
        bothFeats = [];
        knownPos = [];

        posIdx = 0;
        for iPos = posCombs(iComb).comb
            posIdx = posIdx + 1;
            for iClass = 1:numClasses
                forearmFeats = [forearmFeats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,1:length(inertialChans)/2)];
                humerusFeats = [humerusFeats; data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,length(inertialChans)/2+1:length(inertialChans))];
                bothFeats    = [bothFeats;    data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:)];                
                knownPos = [knownPos; posIdx*ones(size(data(iClass,iPos).accelFeats(round(size(data(iClass,iPos).accelFeats,1)/2)+1:end,:),1),1)];
            end
        end

        ldaScore = forearmFeats*posForearmClassifier(iComb).alda.W + repmat(posForearmClassifier(iComb).alda.C,size(forearmFeats,1),1);
        [dum prForearmPos] = max(ldaScore,[],2);            

        ldaScore = humerusFeats*posHumerusClassifier(iComb).alda.W + repmat(posHumerusClassifier(iComb).alda.C,size(humerusFeats,1),1);
        [dum prHumerusPos] = max(ldaScore,[],2);

        ldaScore = bothFeats*posBothClassifier(iComb).alda.W + repmat(posBothClassifier(iComb).alda.C,size(bothFeats,1),1);
        [dum prBothPos] = max(ldaScore,[],2);       

        forearmPosClassificationErr(iComb) = 100*sum(prForearmPos~=knownPos) / length(knownPos);
        humerusPosClassificationErr(iComb) = 100*sum(prHumerusPos~=knownPos) / length(knownPos);
        bothPosClassificationErr(iComb) = 100*sum(prBothPos~=knownPos) / length(knownPos);
        
        
%         forearmPosClass= [];
%         humerusPosClass= [];
%         bothPosClass= [];
% %         knownPosClass = [];
% 
%         forearmErrCount = 0;
%         humerusErrCount = 0;
%         bothErrCount = 0;
% 
%         for iFrame = 1:length(testTargets)
%             %% Use Position Using Forearn, Humerus, and Both ACCEL            
%             featsTmp = testEMGfeats;
% %                 
%             forearmDetectedPosition = prForearmPos(iFrame);                
%             humerusDetectedPosition = prHumerusPos(iFrame);                
%             bothDetectedPosition = prBothPos(iFrame);                
% %                 knownPosition = knownPos(iFrame);                                    
% 
%             forearmClassifierIdx = posCombs(iComb).comb(forearmDetectedPosition);
%             humerusClassifierIdx = posCombs(iComb).comb(humerusDetectedPosition);
%             bothClassifierIdx = posCombs(iComb).comb(bothDetectedPosition);
% %                 knownClassifierIdx = 0;
% 
%             forearmSelectedClassifier = dualStageEMGClassifier(forearmClassifierIdx).alda;
%             humerusSelectedClassifier = dualStageEMGClassifier(humerusClassifierIdx).alda;
%             bothSelectedClassifier    = dualStageEMGClassifier(bothClassifierIdx).alda;
% %                 knownSelectedClassifier   = dualStageEMGClassifier(iNumClassifiers,iClust,knownClassifierIdx).alda;                
% 
%             ldaScore = featsTmp(iFrame,:)*forearmSelectedClassifier.W + forearmSelectedClassifier.C;
%             [dum forearmPosClass(iFrame)] = max(ldaScore,[],2);
% 
% 
%             ldaScore = featsTmp(iFrame,:)*humerusSelectedClassifier.W + humerusSelectedClassifier.C;
%             [dum humerusPosClass(iFrame)] = max(ldaScore,[],2);
% 
% 
%             ldaScore = featsTmp(iFrame,:)*bothSelectedClassifier.W + bothSelectedClassifier.C;
%             [dum bothPosClass(iFrame)] = max(ldaScore,[],2);
% 
% 
% %             ldaScore = featsTmp(iFrame,:)*knownSelectedClassifier.W + knownSelectedClassifier.C;
% %             [dum knownPosClass(iFrame)] = max(ldaScore,[],2);
%         end
%             
%         dualStageResults(iComb).targets = testTargets;
%         dualStageResults(iComb).forearmPosClassDec = forearmPosClass;
%         dualStageResults(iComb).humerusPosClassDec = humerusPosClass;
%         dualStageResults(iComb).bothPosClassDec = bothPosClass;
% %         dualStageResults(iComb).knownPosClassDec = knownPosClass;  
% 
% %         dualStageResults(iComb).knownPosClassErr = 100*sum(knownPosClass~=testTargets') / length(testTargets);
%         dualStageResults(iComb).forearmPosClassErr = 100*sum(forearmPosClass~=testTargets') / length(testTargets);
%         dualStageResults(iComb).humerusPosClassErr = 100*sum(humerusPosClass~=testTargets') / length(testTargets);
%         dualStageResults(iComb).bothPosClassErr = 100*sum(bothPosClass~=testTargets') / length(testTargets);
% %         dualStageResults(iComb).forearmPositionErr = 100*forearmErrCount / length(testTargets);
% %         dualStageResults(iComb).humerusPositionErr = 100*humerusErrCount / length(testTargets);
% %         dualStageResults(iComb).bothPositionErr = 100*bothErrCount / length(testTargets);
% 
% %         dualStageKnownPosClassErr(iNumClassifiers,iClust) = 100*sum(knownPosClass~=testTargets') / length(testTargets);
%         dualStageForearmPosClassErr(iComb) = 100*sum(forearmPosClass~=testTargets') / length(testTargets);
%         dualStageHumerusPosClassErr(iComb) = 100*sum(humerusPosClass~=testTargets') / length(testTargets);
%         dualStageBothPosClassErr(iComb) = 100*sum(bothPosClass~=testTargets') / length(testTargets);        
% %             
% %             dualStageForearmPositionErr(iNumClassifiers,iClust) = 100*forearmErrCount / length(testTargets);
% %             dualStageHumerusPositionErr(iNumClassifiers,iClust) = 100*humerusErrCount / length(testTargets);
% %             dualStageBothPositionErr(iNumClassifiers,iClust) = 100*bothErrCount / length(testTargets);
% %             
% % %             disp(' ');
% % %             disp('Dual-Stage Position Based Classification Error:');
% % %             disp(['Training In Each Position, Testing In Classified (Forearm) Position ERR: ' num2str(mean(overallForearmErr)) '%']);
% % %             disp(['Training In Each Position, Testing In Classified (Humerus) Position ERR: ' num2str(mean(overallHumerusErr)) '%']);
% % %             disp(['Training In Each Position, Testing In Classified (Both) Position ERR: ' num2str(mean(overallBothErr)) '%']);
% % %             disp(['Training In Each Position, Testing In Known Position ERR: ' num2str(mean(overallKnownErr)) '%']);
% % %             disp(' ');
% % 
% %         end
% %     end
% %                    
% % 
    end
    myResults(iUser).forearmPosClassificationErr = forearmPosClassificationErr;       
    myResults(iUser).humerusPosClassificationErr = humerusPosClassificationErr;
    myResults(iUser).bothPosClassificationErr = bothPosClassificationErr;
%         myResults(iUser).dualStageResults = dualStageResults;
% %     myResults(iUser).dualStageKnownPosClassErr = dualStageKnownPosClassErr;
%         myResults(iUser).dualStageForearmPosClassErr = dualStageForearmPosClassErr;
%         myResults(iUser).dualStageHumerusPosClassErr = dualStageHumerusPosClassErr;
%         myResults(iUser).dualStageBothPosClassErr = dualStageBothPosClassErr;
%     myResults(iUser).dualStageForearmPositionErr = dualStageForearmPositionErr;
%     myResults(iUser).dualStageHumerusPositionErr = dualStageHumerusPositionErr;
%     myResults(iUser).dualStageBothPositionErr = dualStageBothPositionErr;
        save('myResults', 'myResults');
%     
    
%     dispv('Training Regular EMG & Forearm ACCEL Classifier (Using Data From Multiple Positions)',verbose);
%     %% Train Regular Classifier using EMG from MULTIPLE POSITIONS & Forearm ACCEL
%     for iComb = bestCombs(iUser,2:16)%1: length(posCombs)   %bestCombs(iUser,:)    
%         feats = [];
%         featsWoAcc = [];
% %         featsWNoise = [];
%         
%         targets = [];
%         for iPos = posCombs(iComb).comb
%             for iClass = 1:numClasses                  
%                 idx = 1:round(size(data(iClass,iPos).emgFeats,1)/2);
%                 feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,1:length(inertialChans)/2)];
%                 featsWoAcc = [featsWoAcc; data(iClass,iPos).emgFeats(idx,:)];
%                         
%                 targets = [targets; iClass*ones(length(idx),1)];                
%             end
%         end
% 
%         multiPosEMG_Forearm_Classifier(iComb).alda = trainALDA(feats',targets');                         
%         multiPosEMG_WoForearm_Classifier(iComb).alda = trainALDA(featsWoAcc',targets');                         
% %         multiPosEMG_Noise_Classifier(iComb).alda = trainALDA(featsWNoise',targets');                         
%     end    
% 
%     dispv('Testing Regular EMG & Forearm ACCEL Classifier (Using Data From Multiple Positions)',verbose);
%     %% Test Regular Classifier (trained using multiple positions) using EMG & Forearm ACCEL    
% 
%     feats = [];
%     featsWoAcc = [];
% %     featsWNoise = [];
%     
%     targets = [];
%     for iPos = 1: numPositions
%         for iClass = 1:numClasses
%             idx = round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,1:length(inertialChans)/2)];
%             featsWoAcc = [featsWoAcc; data(iClass,iPos).emgFeats(idx,:)];
%             
%             targets = [targets; iClass*ones(length(idx),1)];            
%         end                      
%     end
%         
%     multiPosEMG_Forearm_Err = [];
%     minMultiPosEMG_Forearm_Err = [];
%     iNumPos = 1;
%     minErr = inf;            
%     
%     for iComb = bestCombs(iUser,2:16)%1: length(posCombs)  %bestCombs(iUser,:) %                
%         ldaScore = feats*multiPosEMG_Forearm_Classifier(iComb).alda.W + repmat(multiPosEMG_Forearm_Classifier(iComb).alda.C,size(feats,1),1);
%         [dum prMotion] = max(ldaScore,[],2);
%         
%         ldaScore = featsWoAcc*multiPosEMG_WoForearm_Classifier(iComb).alda.W + repmat(multiPosEMG_WoForearm_Classifier(iComb).alda.C,size(feats,1),1);
%         [dum prMotionWo] = max(ldaScore,[],2);
% 
%         multiPosEMG_Forearm_Err(iComb) = 100*sum(prMotion~=targets) / length(targets);                                               
%         multiPosEMG_ForearmWo_Err(iComb) = 100*sum(prMotionWo~=targets) / length(targets);
% %         multiPosEMG_Noise_Err(iComb) = 100*sum(prMotionNoise~=targets) / length(targets);
%         
%         if multiPosEMG_Forearm_Err(iComb) < minErr 
%             minErr = multiPosEMG_Forearm_Err(iComb);
%         end
%         
%         if (iComb == posNumStartEndIdx(iNumPos,2))        
%             minMultiPosEMG_Forearm_Err(iNumPos) = minErr;
%             minErr = inf;            
%             iNumPos = iNumPos + 1;
%         end
%     end    
%     dispv(' ',verbose);
%     dispv('Position Non-Specific Classification Error using EMG & Forearm ACCEL:');
%     dispv(['Training With Multiple Positions + Forearm ACC, Testing in All Positions minimum ERR (1-16): ' num2str(minMultiPosEMG_Forearm_Err) '%']);
%     dispv(' ',verbose);   
%     
% %     dispv('Training Regular EMG & Humerus ACCEL Classifier (Using Data From Multiple Positions)',verbose);
%     %% Train Regular Classifier using EMG from MULTIPLE POSITIONS & Humerus ACCEL
%     for iComb = bestCombs(iUser,2:16)%1 : length(posCombs)    %bestCombs(iUser,:) %        
%         feats = [];
%         targets = [];
%         for iPos = posCombs(iComb).comb
%             for iClass = 1:numClasses            
%                 idx = 1:round(size(data(iClass,iPos).emgFeats,1)/2);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,length(inertialChans)/2+1:length(inertialChans))];
%             targets = [targets; iClass*ones(length(idx),1)];
%             end
%         end
% 
%         multiPosEMG_Humerus_Classifier(iComb).alda = trainALDA(feats',targets');                         
%     end            
% 
%       dispv('Testing Regular EMG & Humerus ACCEL Classifier (Using Data From All Positions)',verbose);
%     %% Test Regular Classifier (trained using all positions) using EMG & Humerus ACCEL
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions
%         for iClass = 1:numClasses
%             idx = round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,length(inertialChans)/2+1:length(inertialChans))];
%             targets = [targets; iClass*ones(length(idx),1)];
%         end                      
%     end
%         
%     multiPosEMG_Humerus_Err = [];
%     minMultiPosEMG_Humerus_Err = [];
%     iNumPos = 1;
%     minErr = inf;            
%     
%     for iComb = bestCombs(iUser,2:16)%1 : length(posCombs)        %bestCombs(iUser,:) %           
%         ldaScore = feats*multiPosEMG_Humerus_Classifier(iComb).alda.W + repmat(multiPosEMG_Humerus_Classifier(iComb).alda.C,size(feats,1),1);
%         [dum prMotion] = max(ldaScore,[],2);
% 
%         multiPosEMG_Humerus_Err(iComb) = 100*sum(prMotion~=targets) / length(targets);                                               
%         if multiPosEMG_Humerus_Err(iComb) < minErr 
%             minErr = multiPosEMG_Humerus_Err(iComb);
%         end
%         
%         if (iComb == posNumStartEndIdx(iNumPos,2))        
%             minMultiPosEMG_Humerus_Err(iNumPos) = minErr;
%             minErr = inf;            
%             iNumPos = iNumPos + 1;
%         end
%     end    
%     dispv(' ',verbose);
%     dispv('Position Non-Specific Classification Error using EMG & Humerus ACCEL:');
%     dispv(['Training With Multiple Positions + Humerus ACC, Testing in All Positions minimum ERR (1-16): ' num2str(minMultiPosEMG_Humerus_Err) '%']);
% %     dispv(' ',verbose);  
% 
%     dispv('Training Regular EMG & Both ACCEL Classifier (Using Data From All Positions)',verbose);
%     %% Train Regular Classifier using EMG Both 2 ACCEL from ALL POSITIONS
%     for iComb = bestCombs(iUser,2:16)%1 : length(posCombs)  %bestCombs(iUser,:) %          
%         feats = [];
%         targets = [];
%         for iPos = posCombs(iComb).comb
%             for iClass = 1:numClasses            
%                 idx = 1:round(size(data(iClass,iPos).emgFeats,1)/2);
%                 feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,1:6)];
%                 targets = [targets; iClass*ones(length(idx),1)];
%             end
%         end
% 
%         multiPosEMG_Both_Classifier(iComb).alda = trainALDA(feats',targets');                         
%     end        
% 
%     dispv('Testing Regular EMG & 2 ACCEL Classifier (Using Data From All Positions)',verbose);
%     %% Test Regular Classifier (trained using all positions) using EMG & 2 ACCEL
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions
%         for iClass = 1:numClasses
%             idx = round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:) data(iClass,iPos).accelFeats(idx,1:6)];
%             targets = [targets; iClass*ones(length(idx),1)];
%         end                      
%     end
%         
%     multiPosEMG_Both_Err = [];
%     minMultiPosEMG_Both_Err = [];
%     iNumPos = 1;
%     minErr = inf;            
%     minErrIdx = 0; 
%     
%     for iComb = bestCombs(iUser,2:16)%1 : length(posCombs)   %bestCombs(iUser,:) %              
%         ldaScore = feats*multiPosEMG_Both_Classifier(iComb).alda.W + repmat(multiPosEMG_Both_Classifier(iComb).alda.C,size(feats,1),1);
%         [dum prMotion] = max(ldaScore,[],2);
% 
%         multiPosEMG_Both_Err(iComb) = 100*sum(prMotion~=targets) / length(targets);
%         if multiPosEMG_Both_Err(iComb) < minErr
%             minErr = multiPosEMG_Both_Err(iComb);
%             minErrIdx = iComb; 
%         end
%         
%         if (iComb == posNumStartEndIdx(iNumPos,2))
%             minMultiPosEMG_Both_Err(iNumPos) = minErr;
%             minMultiPosEMG_Both_ErrIdx(iNumPos) = minErrIdx;
%             minErr = inf;
%             minErrIdx = 0;
%             iNumPos = iNumPos + 1;
%         end
%     end    
%     dispv(' ',verbose);
%     dispv('Position Non-Specific Classification Error using EMG & Both ACCEL:');
%     dispv(['Training With Multiple Positions + Both ACC, Testing in All Positions minimum ERR (1-16): ' num2str(minMultiPosEMG_Both_Err) '%']);
%     dispv(' ',verbose);
% %     
%     myResults(iUser).minMultiPosEMG_Forearm_Err = minMultiPosEMG_Forearm_Err;
%     myResults(iUser).multiPosEMG_Forearm_Err = multiPosEMG_Forearm_Err;        
%     myResults(iUser).minMultiPosEMG_Humerus_Err = minMultiPosEMG_Humerus_Err;
%     myResults(iUser).multiPosEMG_Humerus_Err = multiPosEMG_Humerus_Err;        
%     myResults(iUser).minMultiPosEMG_Both_Err = minMultiPosEMG_Both_Err;
% %     myResults(iUser).minMultiPosEMG_Both_ErrIdx = minMultiPosEMG_Both_ErrIdx;
%     myResults(iUser).multiPosEMG_Both_Err = multiPosEMG_Both_Err;        
%     
    diary off
%     save('myResults', 'myResults');
    save(['Res' num2str(iUser)],'myResults');  
end




% CM = zeros(size(userResults(iUser,iFeat).oneEMGConfMatrix));
% numUsers = 0;
% for i=1:size(userResults,1)
%     if ~isempty(userResults(i,iFeat).oneEMGConfMatrix)
%         numUsers = numUsers +1;
%         CM = CM + userResults(i,iFeat).oneEMGConfMatrix;
%     end
% end
% CM = CM./numUsers;
% dispv('Average Single Position Confusion Matrix for All Users:');
% dispv(CM);
% 
% 
% twoPos = zeros(size(userResults(iUser,iFeat).twoTrainPosErr));
% numUsers = 0;
% for i=1:size(userResults,1)
%     if ~isempty(userResults(i,iFeat).twoTrainPosErr)
%         numUsers = numUsers +1;
%         twoPos = twoPos + userResults(i,iFeat).twoTrainPosErr;
%     end
% end
% twoPos = twoPos./numUsers;
% 
% figure
% hold on
% bar(mean(twoPos,2),0.8,'FaceColor',[0.32 0.44 0.69],'LineStyle','none');
% 
% cpStr = cell(1,size(combinedPositions,1));
% for i=1:size(combinedPositions,1)
% %        cpStr{i} = [num2str(combinedPositions(i,1)) '&' num2str(combinedPositions(i,2))];
%     cpStr{i} = [num2str(combinedPositions{i}(1)) '&' num2str(combinedPositions{i}(2))];
% end
% set(gca,'XLim',[0 size(twoPos,1)+1],'XTick',1:size(combinedPositions,1),'XTickLabel',cpStr);
% 
% meanTwoPos = mean(twoPos,2);
% stdTwoPos = std(twoPos')';
% set(gca,'YLim',[0 round(max(meanTwoPos+stdTwoPos))+2],'Box','on');
% set(gca,'FontSize',24,'YGrid','on','XGrid','off','FontWeight','bold');
% ylabel('Error (%)')
% title({'Average Error when Training with Limb in Two Positions','and testing in all Positions'})
% 
% for i=1:size(meanTwoPos,1)
%     x = errorbar(i,meanTwoPos(i),stdTwoPos(i),'Color','k');
%     y = get(x,'Children');
%     z = get(y(2),'XData');
%     z(4) = z(1) - 0.2;
%     z(5) = z(1) + 0.2;
%     z(7) = z(1) - 0.2;
%     z(8) = z(1) + 0.2;
%     set(y(2),'XData',z);
% end
% 
% 
% 
% figure
% imagesc(100-CM);
% colorbar
% colormap(winter)
% for i=1:length(positions)
%     line([i+0.5 i+0.5],[0 length(positions)+1],'Color','k');
%     line([0 length(positions)+1],[i+0.5 i+0.5],'Color','k');
% end
% for i=1:length(positions)
%     P{i} = ['P' num2str(i)];
% end
% set(gca,'YTick',1:length(positions),'YTickLabel',P,'XTick',1:length(positions),'XTickLabel',P,'FontSize',24,'FontWeight','bold');
% axis square    
% title('Average Inter-Position Error')
% 
% accelErr = zeros(3,length(positions));
% numUsers = 0;
% for i=1:size(userResults,1)
%     if ~isempty(userResults(i,iFeat).posErrBothConfMatrix)
%         numUsers = numUsers +1;
%         accelErr(1,:) = accelErr(1,:) + (1 - diag(userResults(i,iFeat).posErrForearmConfMatrix)'./sum(userResults(i,iFeat).posErrForearmConfMatrix));
%         accelErr(2,:) = accelErr(2,:) + (1 - diag(userResults(i,iFeat).posErrHumerusConfMatrix)'./sum(userResults(i,iFeat).posErrHumerusConfMatrix));
%         accelErr(3,:) = accelErr(3,:) + (1 - diag(userResults(i,iFeat).posErrBothConfMatrix)'./sum(userResults(i,iFeat).posErrHumerusConfMatrix));
%     end
% end
% accelErr = 100*accelErr./numUsers;
% figure
% hold on
% for i=1:length(positions)
%     bar(i,accelErr(1,i),0.3,'FaceColor',[0.32 0.44 0.69],'LineStyle','none');
%     bar(i+0.3,accelErr(2,i),0.3,'FaceColor',[0.72 0.24 0.24],'LineStyle','none');
%     bar(i+0.6,accelErr(3,i),0.3,'FaceColor',[0.4 0.72 0.37],'LineStyle','none');
% end
% 
% dispv('Position Classification Accruacy for All Users:');
% set(gca,'YLim',[0 round(max(accelErr(:))+2)],'Box','on');
% set(gca,'XLim',[0.6 length(positions)+1]);
% set(gca,'XTick',(1:length(positions))+0.3,'XTickLabel',P,'YTick',0:5:round(max(accelErr(:))+2),'FontSize',24,'YGrid','on','XGrid','off','FontWeight','bold');
% ylabel('Error (%)')
% legend({'Forearm ACCEL','Humerus ACCEL','Both ACCEL'},'FontSize',20);
% title('Classification of Position using ACCEL')
% 
% 
% 
% knownPosEMG_Err = zeros(size(userResults(iUser,iFeat).oneKnownPosEMG_Err));
% forearmPosEMG_Err = zeros(size(userResults(iUser,iFeat).oneForearmPosEMG_Err));
% humerusPosEMG_Err = zeros(size(userResults(iUser,iFeat).oneHumerusPosEMG_Err));
% bothPosEMG_Err = zeros(size(userResults(iUser,iFeat).oneBothPosEMG_Err));
% numUsers = 0;
% for i=1:size(userResults,1)
%     if ~isempty(userResults(i,iFeat).oneKnownPosEMG_Err)
%         numUsers = numUsers +1;
%         knownPosEMG_Err = knownPosEMG_Err + userResults(i,iFeat).oneKnownPosEMG_Err;
%         forearmPosEMG_Err = forearmPosEMG_Err + userResults(i,iFeat).oneForearmPosEMG_Err;
%         humerusPosEMG_Err = humerusPosEMG_Err + userResults(i,iFeat).oneHumerusPosEMG_Err;
%         bothPosEMG_Err = bothPosEMG_Err + userResults(i,iFeat).oneBothPosEMG_Err;
%     end
% end
% knownPosEMG_Err = knownPosEMG_Err/numUsers;
% forearmPosEMG_Err = forearmPosEMG_Err/numUsers;
% humerusPosEMG_Err = humerusPosEMG_Err/numUsers;
% bothPosEMG_Err = bothPosEMG_Err/numUsers;
% 
% figure
% hold on
% for i=1:length(positions)
%     bar(i,knownPosEMG_Err(i),0.2,'FaceColor',[0.32 0.44 0.69],'LineStyle','none');
%     bar(i+0.2,forearmPosEMG_Err(i),0.2,'FaceColor',[0.72 0.24 0.24],'LineStyle','none');
%     bar(i+0.4,humerusPosEMG_Err(i),0.2,'FaceColor',[0.5 0.5 0.5],'LineStyle','none');
%     bar(i+0.6,bothPosEMG_Err(i),0.2,'FaceColor',[0.4 0.72 0.37],'LineStyle','none');
% end
% set(gca,'YLim',[0 round(max([knownPosEMG_Err forearmPosEMG_Err humerusPosEMG_Err bothPosEMG_Err])+2)],'Box','on');
% set(gca,'XLim',[0.8 length(positions)+1]);
% set(gca,'XTick',(1:length(positions))+0.3,'XTickLabel',P,'YTick',0:2:round(max([knownPosEMG_Err forearmPosEMG_Err humerusPosEMG_Err bothPosEMG_Err])),'FontSize',24,'YGrid','on','XGrid','off','FontWeight','bold');
% ylabel('Error (%)')
% legend({'Known Position','Forearm ACCEL','Humerus ACCEL','Both ACCEL'},'FontSize',20);
%  title('Position Specific Classification using Given Position');
% 
% 
% 
% emgErr = 0;
% bothForearmErr = 0;
% bothHumerusErr = 0;
% both2Err = 0;
% numUsers = 0;
% for i=1:size(userResults,1)
%     if ~isempty(userResults(i,iFeat).oneEMGConfMatrix)
%         numUsers = numUsers +1;
%         emgErr = emgErr + userResults(i,iFeat).allPosEMG_Err;
%         emgStd(numUsers,:) = userResults(i,iFeat).allPosEMG_Err;
% 
%         bothForearmErr = bothForearmErr + userResults(i,iFeat).allPosEMG_Forearm_Err;
%         bothHumerusErr = bothHumerusErr + userResults(i,iFeat).allPosEMG_Humerus_Err;
%         both2Err = both2Err + userResults(i,iFeat).allPosEMG_Both_Err;
%     end
% end
% emgErr = emgErr/numUsers;
% bothForearmErr = bothForearmErr/numUsers;
% bothHumerusErr = bothHumerusErr/numUsers;
% both2Err = both2Err/numUsers;
% 
% %     
% %     figure
% %     hold on
% %     bar(emgErr,0.8,'FaceColor',[0.32 0.44 0.69],'LineStyle','none');
% %         set(gca,'XLim',[0 length(positions)+1]);
% %     
% %     meanEmgStd = mean(emgStd);
% %     stdEmgStd = std(emgStd);
% %     set(gca,'YLim',[0 round(max(meanEmgStd+stdEmgStd))+2],'Box','on');
% %     set(gca,'XTick',1:length(positions)+0.3,'XTickLabel',P,'YTick',0:5:25,'FontSize',24,'YGrid','on','XGrid','off','FontWeight','bold');
% %     ylabel('Error (%)')
% %     
% %     
% %     for i=1:size(emgStd,2)
% %         x = errorbar(i,meanEmgStd(i),stdEmgStd(i),'Color','k');
% %         y = get(x,'Children');
% %         z = get(y(2),'XData');
% %         z(4) = z(1) - 0.2;
% %         z(5) = z(1) + 0.2;
% %         z(7) = z(1) - 0.2;
% %         z(8) = z(1) + 0.2;
% %         set(y(2),'XData',z);
% %     end
% 
% 
% 
% figure
% hold on
% for i=1:length(positions)
%     bar(i,emgErr(i),0.2,'FaceColor',[0.32 0.44 0.69],'LineStyle','none');
%     bar(i+0.2,bothForearmErr(i),0.2,'FaceColor',[0.72 0.24 0.24],'LineStyle','none');
%     bar(i+0.4,bothHumerusErr(i),0.2,'FaceColor',[0.5 0.5 0.5],'LineStyle','none');
%     bar(i+0.6,both2Err(i),0.2,'FaceColor',[0.4 0.72 0.37],'LineStyle','none');
% end
% set(gca,'YLim',[0 round(max([emgErr bothForearmErr bothHumerusErr both2Err])+2)],'Box','on');
% set(gca,'XLim',[0.8 length(positions)+1]);
% set(gca,'XTick',(1:length(positions))+0.3,'XTickLabel',P,'YTick',0:2:round(max([emgErr bothForearmErr bothHumerusErr both2Err])),'FontSize',24,'YGrid','on','XGrid','off','FontWeight','bold');
% ylabel('Error (%)')
% legend({'EMG Only','EMG & Forearm ACCEL','EMG & Humerus ACCEL','EMG & Both ACCEL'},'FontSize',20);
% title('Position Non-Specific Classification using EMG & ACCEL');
% 
% drawnow
% 
% meanInterPositionAcc = mean(setdiff(CM(:),diag(CM)));
% meanIntraPositionAcc = mean(diag(CM));
