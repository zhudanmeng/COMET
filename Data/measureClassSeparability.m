addpath 'C:\Users\Ashkan\UNB\Thesis\Projects\ACE\CLASSES'
clear
close all
clc
           
users{1} = '\Subjects\Old Data\Ashkan2_.USER';
repOrder{1} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16];  
           
users{2} = '\Subjects\Old Data\Ashkan3_.USER';
repOrder{2} = [ 6  7  2  8  3  4  1  5 16 14 12 13 11  9 10 15 ...
               14 10 11 12  9 16 13 15  4  2  3  1  5  6  8  7 ...
                5  2  4  8  1  3  7  6 16 11 14 12 13 10  9 15 ...
               10 16  9 11 13 15 12 14  4  5  8  6  3  7  1  2];
  

users{3} = '\Subjects\Old Data\Ali_.USER';
repOrder{3} = [ 8  1  3  7  2  4  5  6 15 11  9 16 13 12 10 14 ...
               11 15  9 16 12 13 14 10  8  7  5  1  6  3  2  4 ...
                7  4  8  3  2  6  5  1 16 10 12 13 11 14  9 15 ...
               16 13 15 12 11 14  9 10  5  6  3  2  4  1  7  8];

users{4} = '\Subjects\Old Data\Rolando_.USER';
repOrder{4} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
               15 14 11 16 13 12  9 10  4  6  2  7  8  5  1  3 ...
                4  8  6  3  7  1  2  5 13 10 14 12 16 15  9 11 ...
               14  9 12 16 15 10 13 11  4  3  8  1  5  2  6  7];  
           
users{5} = '\Subjects\Old Data\Bahareh_.USER';    %
repOrder{5} = [ 4  3  5  6  7  8  1  2 12  9 10 15 16 14 11 13 ...
                9 12 11 14 15 10 16 13  6  8  3  4  7  2  1  5 ...
                7  5  8  4  3  6  2  1 10 14 16  9 15 13 12 11 ...
               15 16 13 12 10 11 14  9  5  1  2  6  8  7  4  3];  
           
users{6} = '\Subjects\Old Data\AB_.USER';    % Ali Bagherpour
repOrder{6} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
               13 10  9 15 14 16 11 12  8  2  3  1  6  5  4  7 ...
                6  1  5  3  7  2  8  4 16 14 12 13  9 15 11 10 ...
               12 14 10 15 11 16 13  9  7  6  3  8  5  4  1  2];  

users{7} = '\Subjects\Old Data\AM_.USER';    % Arash Mansouri
repOrder{7} = [ 4  5  8  6  3  7  1  2 13 10 14 12 16 15  9 11 ...
               16 14 12 13  9 15 11 10  6  1  5  3  7  2  8  4 ...
                8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
               16 11 12  9 13 10 14 15  6  1  4  3  8  7  2  5]; 

users{8} = '\Subjects\Old Data\SHR_.USER';    % Shayan Rafizadeh
repOrder{8} = [ 3  5  7  4  2  8  1  6 16  9 11 15 10 12 13 14 ...
               11 15  9 16 12 13 14 10  7  3  1  8  5  4  2  6 ...
                8  7  5  1  6  3  2  4 12 15 16 11 10 14 13  9 ...
               16 13 15 12 11 14  9 10  8  2  4  5  3  6  1  7]; 
          
users{9} = '\Subjects\Old Data\MRR_.USER';    % Mohammad Reza Rafipour
repOrder{9} = [ 3  1  6  7  2  5  4  8 15  9 13 16 14 10 12 11 ...
               14 11  9 15 12 13 10 16  1  7  4  2  8  3  6  5 ...
                6  8  7  2  3  5  1  4 10  9 15 16 11 12 14 13 ...
               11  9 15 16 10 14 12 13  2  7  5  8  1  4  3  6]; 
           
users{10} = '\Subjects\Old Data\AZ_.USER';    % Abtin Zohrabi
repOrder{10} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
                14  9 13 11 15 10 16 12  8  6  4  5  1  7  3  2 ...
                 8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
                15 14 11 16 13 12  9 10  4  6  2  7  3  8  5  1];
           
users{11} = '\Subjects\Old Data\AP_.USER';    % Amir Pourafshar
repOrder{11} = [ 8  6  4  5  3  1  2  7 14 10 11 12  9 16 13 15 ...
                12 10 11  9 13 14 16 15  5  2  4  8  1  3  7  6 ...
                 8  3  6  4  5  2  1  7 10 16  9 11 13 15 12 14 ...
                12 13 16 14 11 15  9 10  4  3  5  6  7  8  1  2];
           

userList = 1:length(users);
userList = [6];%[1,3:11];

% positions = 1:5;
positions = 1:16;

numPositions = length(positions);

class = [1 2 3 4 7 10 11 12];
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

    curPosCombs = combntns(1:numPositions, iNumPos);
    for iComb = 1: size(curPosCombs,1)                                    
        posCombs(combNum).comb = curPosCombs(iComb,:);
        combNum = combNum + 1;
    end
end
posNumStartEndIdx(iNumPos,2) = combNum-1;
save('posCombs','posCombs');
save('posNumStartEndIdx','posNumStartEndIdx');

combs(1).list = [16,70,344,1536,4892,11959,23104,36522,49015,57773,62738,64775,65321,65511,65534,65535];
combs(2).list = [13,120,554,2228,3615,9474,19456,31568,44402,55000,61196,63980,65151,65425,65524,65535];
combs(3).list = [15,108,502,2235,6141,9144,18986,30140,43729,52529,58821,63154,64858,65411,65522,65535];
combs(4).list = [8,106,211,1037,2766,8395,15417,27496,39770,52823,59119,63068,64970,65403,65522,65535];
combs(5).list = [2,94,314,1462,4337,10716,15721,26446,39466,51051,58849,63091,64900,65429,65527,65535]; 
% combs(6).list = [1,30,235,1051,3704,9742,19806,32717,42563,55416,60414,63949,65175,65459,65532,65535];    % Alternative      
combs(6).list = [1,30,234,1124,3728,9742,19806,32717,42584,53100,60401,63949,65175,65482,65532,65535];      % Original
combs(7).list = [11,86,259,1976,5921,12213,21785,26656,39803,51430,59383,63500,65035,65457,65522,65535];
combs(8).list = [4,104,378,1414,6802,11815,22833,36178,48369,58649,62653,64018,65202,65476,65532,65535];
combs(9).list = [8,63,337,906,3241,8804,15811,27658,43230,54125,59460,64386,64896,65402,65519,65535];
combs(10).list = [4,95,321,1139,4626,11588,22787,29327,41605,53022,60384,63850,65169,65452,65529,65535];
combs(11).list = [2,35,282,2260,5836,10841,15846,28093,46305,56198,62048,64557,65012,65458,65530,65535];


for iUser = 1:length(userList)
    
    disp(['Loading User File ' num2str(iUser) ' of ' num2str(length(userList))]);

    loadPath = [pwd users{userList(iUser)}];
    load(loadPath,'-mat');       

    if exist('sessionInfo','var');            

        class = [1 2 3 4 5 8 9 12];
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
    data = extractNormalizedFeatures(data,userInfo.settings,userInfo.settings.featType);
    
    
    %%
    for iClass = 1:numClasses 
        myTestData(iClass).emgFeats = [];
        for iPos = 1:numPositions
            myTestData(iClass).emgFeats = [myTestData(iClass).emgFeats; data(iClass,iPos).emgFeats(round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1),:)];
        end        
    end    
    
    mydata = [];
    for iComb = 1:length(combs(userList(iUser)).list)
%         %%
%         % Accepts a p x d matrix X in which each row is a vector
%         % of d numeric features (usually norm. into the range 0-1)
%         % t is a vector of labels (usually +1 or - 1)
%         % Returns s, a number between 0 and 1, a measure of
%         % degree to which classes are geometrically separable.
%         % s is the fraction of instances whose classification
%         % label is shared by its nearest neighbour (determined
%         % on the basis of simple Euclidean distance)
%         X = [];
%         t = [];
%         for iClass = 1:numClasses             
%             for iPos = posCombs(combs(userList(iUser)).list(iComb)).comb
%                 X = [X; data(iClass,iPos).emgFeats];
%                 t = [t; ones(size(data(iClass,iPos).emgFeats,1),1)*iClass];
%             end        
%         end
% 
%         
%         p = length(t); % number of points
%         d2 = dist2(X,X); % squared euclidean distances
%         [S,I] = sort(d2); % sort each col by distance; I = index
%         
%         sigmaMH = 0;
%         for ip = 1 : p
%             notFoundSame = true;
%             notFoundDiff = true;
%             idx = 2;
%             while notFoundSame || notFoundDiff
%                 if notFoundSame && t(I(1,ip)) == t(I(idx,ip))
%                     notFoundSame = false;
%                     sameIdx = idx;
%                 end
%                 if notFoundDiff && t(I(1,ip)) ~= t(I(idx,ip))
%                     notFoundDiff = false;
%                     diffIdx = idx;
%                 end
%                 idx = idx + 1;
%             end
%             sigmaMH = sigmaMH + 0.5*(S(diffIdx,ip)-S(sameIdx,ip));
%         end
%         MH(iUser,iComb) = sigmaMH / p;
%         
%         t1 = t(I(1,:)); % labels of points (row 1 of d2)
%         t2 = t(I(2,:)); % labels of n-neighbours (row 2 of d2)
%         s(iUser,iComb) = sum(t1==t2)/p; % fract. of points with same class n.nr
%     end
% end

        %%        
        for iClass = 1:numClasses 
            mydata(iClass,iComb).emgFeats = [];
            for iPos = posCombs(combs(userList(iUser)).list(iComb)).comb
                mydata(iClass,iComb).emgFeats = [mydata(iClass,iComb).emgFeats; data(iClass,iPos).emgFeats(1:round(size(data(iClass,iPos).emgFeats,1)/2),:)];                
            end        
        end

        %%
        sigmaRI = 0 ;
        for iClass = 1 : numClasses
            iMuTst = mean(myTestData(iClass).emgFeats);
            iMuTr = mean(mydata(iClass,iComb).emgFeats);
            iS = cov(mydata(iClass,iComb).emgFeats);  
            iStst = cov(myTestData(iClass).emgFeats);  
            sigmaRI = sigmaRI + 0.5 * sqrt((iMuTr-iMuTst)*inv((iS+iStst)/2)*(iMuTr-iMuTst)');
        end
        RI(iUser,iComb) = numClasses/sigmaRI;
        
        %%
        
        sigmaM = 0;
        sigmaA = 0;
        sigmaR = 0;
        avgSi = 0;
        for iClass = 1:numClasses 
            minM = inf;  
            maxR = 0;
            iMu = mean(mydata(iClass,iComb).emgFeats);
            iS = cov(mydata(iClass,iComb).emgFeats);            

            clusterSize = size(mydata(iClass,iComb).emgFeats,1);
            sigmaS = 0;
            for idx = 1 : clusterSize
                delta = mydata(iClass,iComb).emgFeats(idx,:) - iMu;
                sigmaS = sigmaS + delta * delta';
            end            
            Si = sqrt(sigmaS / clusterSize);
            avgSi = avgSi + Si / numClasses;

            for jClass = 1:numClasses                                
                if jClass ~= iClass                  
                    clusterSize = size(mydata(jClass,iComb).emgFeats,1);
                    sigmaS = 0;
                    for idx = 1 : clusterSize
                        delta = mydata(jClass,iComb).emgFeats(idx,:) - iMu;
                        sigmaS = sigmaS + delta * delta';
                    end            
                    Sj = sqrt(sigmaS / clusterSize);

                    jMu = mean(mydata(jClass,iComb).emgFeats);
                    jS = cov(mydata(jClass,iComb).emgFeats);
                    M = 0.5 * sqrt((jMu-iMu)*inv((jS+iS)/2)*(jMu-iMu)');
                    if M < minM
                        minM = M;
                    end

                    Dij = sqrt((jMu-iMu)*(jMu-iMu)');
                    Rij = (Si+Sj)/Dij;
                    if Rij > maxR
                        maxR = Rij;
                    end
                end                
            end
            sigmaM = sigmaM + minM;
            sigmaR = sigmaR + maxR;

            featMax = max(mydata(iClass,iComb).emgFeats);
            featMin = min(mydata(iClass,iComb).emgFeats);
            A = power(prod(featMax - featMin),0.25);
            sigmaA = sigmaA + A;                        
        end        
        SI(iUser,iComb) = sigmaM / numClasses;
        MSA(iUser,iComb) = sigmaA / numClasses;
        DB(iUser,iComb) = sigmaR / numClasses;
        Dispersion(iUser,iComb) = avgSi;
    end
    NSI(iUser,:) = (SI(iUser,:) - min(SI(iUser,:))) / (max(SI(iUser,:)) - min(SI(iUser,:)));
    NRI(iUser,:) = (RI(iUser,:) - min(RI(iUser,:))) / (max(RI(iUser,:)) - min(RI(iUser,:)));
end