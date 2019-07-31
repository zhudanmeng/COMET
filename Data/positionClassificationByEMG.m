addpath 'G:\Matlab'
addpath 'G:\Matlab\CLASSES'
clear
close all
clc
            

users{1} = '\Subjects\Ashkan2_.USER';
repOrder{1} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16];  
           
% users{2} = '\Subjects\Ashkan3_.USER';
% repOrder{2} = [ 6  7  2  8  3  4  1  5 16 14 12 13 11  9 10 15 ...
%                14 10 11 12  9 16 13 15  4  2  3  1  5  6  8  7 ...
%                 5  2  4  8  1  3  7  6 16 11 14 12 13 10  9 15 ...
%                10 16  9 11 13 15 12 14  4  5  8  6  3  7  1  2];
  

users{3} = '\Subjects\Ali_.USER';
repOrder{3} = [ 8  1  3  7  2  4  5  6 15 11  9 16 13 12 10 14 ...
               11 15  9 16 12 13 14 10  8  7  5  1  6  3  2  4 ...
                7  4  8  3  2  6  5  1 16 10 12 13 11 14  9 15 ...
               16 13 15 12 11 14  9 10  5  6  3  2  4  1  7  8];

users{4} = '\Subjects\Rolando_.USER';
repOrder{4} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
               15 14 11 16 13 12  9 10  4  6  2  7  8  5  1  3 ...
                4  8  6  3  7  1  2  5 13 10 14 12 16 15  9 11 ...
               14  9 12 16 15 10 13 11  4  3  8  1  5  2  6  7];  
           
users{5} = '\Subjects\Bahareh_.USER';
repOrder{5} = [ 4  3  5  6  7  8  1  2 12  9 10 15 16 14 11 13 ...
                9 12 11 14 15 10 16 13  6  8  3  4  7  2  1  5 ...
                7  5  8  4  3  6  2  1 10 14 16  9 15 13 12 11 ...
               15 16 13 12 10 11 14  9  5  1  2  6  8  7  4  3];  

users{6} = '\Subjects\AB_.USER';    % Ali Bagherpour
repOrder{6} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
               13 10  9 15 14 16 11 12  8  2  3  1  6  5  4  7 ...
                6  1  5  3  7  2  8  4 16 14 12 13  9 15 11 10 ...
               12 14 10 15 11 16 13  9  7  6  3  8  5  4  1  2];  

users{7} = '\Subjects\AM_.USER';    % Arash Mansouri
repOrder{7} = [ 4  5  8  6  3  7  1  2 13 10 14 12 16 15  9 11 ...
               16 14 12 13  9 15 11 10  6  1  5  3  7  2  8  4 ...
                8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
               16 11 12  9 13 10 14 15  6  1  4  3  8  7  2  5]; 

users{8} = '\Subjects\SHR_.USER';    % Shayan Rafizadeh
repOrder{8} = [ 3  5  7  4  2  8  1  6 16  9 11 15 10 12 13 14 ...
               11 15  9 16 12 13 14 10  7  3  1  8  5  4  2  6 ...
                8  7  5  1  6  3  2  4 12 15 16 11 10 14 13  9 ...
               16 13 15 12 11 14  9 10  8  2  4  5  3  6  1  7]; 
          
users{9} = '\Subjects\MRR_.USER';    % Mohammad Reza Rafipour
repOrder{9} = [ 3  1  6  7  2  5  4  8 15  9 13 16 14 10 12 11 ...
               14 11  9 15 12 13 10 16  1  7  4  2  8  3  6  5 ...
                6  8  7  2  3  5  1  4 10  9 15 16 11 12 14 13 ...
               11  9 15 16 10 14 12 13  2  7  5  8  1  4  3  6]; 
           
users{10} = '\Subjects\AZ_.USER';    % Abtin Zohrabi
repOrder{10} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
                14  9 13 11 15 10 16 12  8  6  4  5  1  7  3  2 ...
                 8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
                15 14 11 16 13 12  9 10  4  6  2  7  3  8  5  1];
           
users{11} = '\Subjects\AP_.USER';    % Amir Pourafshar
repOrder{11} = [ 8  6  4  5  3  1  2  7 14 10 11 12  9 16 13 15 ...
                12 10 11  9 13 14 16 15  5  2  4  8  1  3  7  6 ...
                 8  3  6  4  5  2  1  7 10 16  9 11 13 15 12 14 ...
                12 13 16 14 11 15  9 10  4  3  5  6  7  8  1  2];
            
userList = 1:length(users);
userList = [1,3,4,5,6,7,8,9,10,11];

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

% positions = 1:5;
positions = 1:16;

numPositions = length(positions);

class = [1];%[1 2 3 4 7 10 11 12];
numClasses = length(class);

emgChans = 1:8; 
inertialChans = 9:14;  % 7:30 

% emgChans = 1:6; 
% inertialChans = 7:12;  % 7:30 

verbose = 1;

allFeats = {'TD'}; 


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
% save('posCombs','posCombs');
% save('posNumStartEndIdx','posNumStartEndIdx');

for iUser = 1:length(userList)

    clearvars -except numClasses class numPositions positions desc className users iUser emgChans repOrder posResults PosEMGErr...
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

        class = [12];% 1 2 3 4 5 8 9 12];
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

    userInfo.settings.enableNotch = 1;
    userInfo.settings.notchFreq = [60 180 300];   % Notch Frequencies
    userInfo.settings.notchQ = 1;                 % Notch Q (Order)

    userInfo.settings.enableLPF = false;          % Enable Low Pass Filtering
    userInfo.settings.enableHPF = false;           % Enable High Pass Filtering

    userInfo.settings.cutoffFreq = 20;            % High Pass Filter Cutoff Frequency
    userInfo.settings.filterOrder = 3;            % High Pass Filter Order                
    userInfo.settings.sampleFreq = 1000;          % Sampling Frequency 

%         userInfo.settings.enableLPF = 0;
    userInfo.settings.featType = 'TD';
    disp('Extracting and Storing EMG Features from Channels:');
    disp(emgChans);
    data = extractNormFeatures(data,userInfo.settings,userInfo.settings.featType);
    
    %% Training Position classifier using EMG 
    disp('');
    disp('Training Position classifier using EMG ');
    feats = [];
    targets = [];
    for iPos = positions          
        for iClass = 1:numClasses            
%             feats = [feats; data(iClass,iPos).emgFeats(1:round(size(data(iClass,iPos).emgFeats,1)/2),:)];   
%             targets = [targets; iPos*ones(round(size(data(iClass,iPos).emgFeats,1)/2),1)];
            feats = [feats; data(iClass,iPos).emgFeats];   
            targets = [targets; iPos*ones(round(size(data(iClass,iPos).emgFeats,1)),1)];
        end
    end
    
    PosEMGClassifier.alda = trainALDA(feats',targets');                                 
    
    %% Testing Position classifier using EMG 
    disp('');
    disp('Testing Position classifier using EMG ');
%     feats = [];
%     targets = [];
%     for iPos = 1:numPositions
%         for iClass = 1:numClasses
%             idx = round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1);
%             feats = [feats; data(iClass,iPos).emgFeats(idx,:)];
%             targets = [targets; iPos*ones(length(idx),1)];
%         end                       
%     end
    ldaScore = feats*PosEMGClassifier.alda.W + repmat(PosEMGClassifier.alda.C,size(feats,1),1);
    [dum prPos] = max(ldaScore,[],2);
    
    posResults(iUser).decision = prPos;
    posResults(iUser).targets = targets;
    posResults(iUser).error = 100*sum(prPos~=targets) / length(targets);       
    PosEMGErr(iUser) = 100*sum(prPos~=targets) / length(targets)       
end
save('posResults','posResults');