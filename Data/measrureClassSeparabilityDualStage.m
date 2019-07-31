addpath 'C:\Users\Peter Zhu\Documents\MATLAB'
clear
close all
clc
           
users{1} = '\Data\Subjects\Ashkan2_.USER';
repOrder{1} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
                1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16];  
           
users{2} = '\Data\Subjects\Ashkan3_.USER';
repOrder{2} = [ 6  7  2  8  3  4  1  5 16 14 12 13 11  9 10 15 ...
               14 10 11 12  9 16 13 15  4  2  3  1  5  6  8  7 ...
                5  2  4  8  1  3  7  6 16 11 14 12 13 10  9 15 ...
               10 16  9 11 13 15 12 14  4  5  8  6  3  7  1  2];
  

users{3} = '\Data\Subjects\Ali_.USER';
repOrder{3} = [ 8  1  3  7  2  4  5  6 15 11  9 16 13 12 10 14 ...
               11 15  9 16 12 13 14 10  8  7  5  1  6  3  2  4 ...
                7  4  8  3  2  6  5  1 16 10 12 13 11 14  9 15 ...
               16 13 15 12 11 14  9 10  5  6  3  2  4  1  7  8];

users{4} = '\Data\Subjects\Rolando_.USER';
repOrder{4} = [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 ...
               15 14 11 16 13 12  9 10  4  6  2  7  8  5  1  3 ...
                4  8  6  3  7  1  2  5 13 10 14 12 16 15  9 11 ...
               14  9 12 16 15 10 13 11  4  3  8  1  5  2  6  7];  
           
users{5} = '\Data\Subjects\Bahareh_.USER';    %
repOrder{5} = [ 4  3  5  6  7  8  1  2 12  9 10 15 16 14 11 13 ...
                9 12 11 14 15 10 16 13  6  8  3  4  7  2  1  5 ...
                7  5  8  4  3  6  2  1 10 14 16  9 15 13 12 11 ...
               15 16 13 12 10 11 14  9  5  1  2  6  8  7  4  3];  
           
users{6} = '\Data\Subjects\AB_.USER';    % Ali Bagherpour
repOrder{6} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
               13 10  9 15 14 16 11 12  8  2  3  1  6  5  4  7 ...
                6  1  5  3  7  2  8  4 16 14 12 13  9 15 11 10 ...
               12 14 10 15 11 16 13  9  7  6  3  8  5  4  1  2];  

users{7} = '\Data\Subjects\AM_.USER';    % Arash Mansouri
repOrder{7} = [ 4  5  8  6  3  7  1  2 13 10 14 12 16 15  9 11 ...
               16 14 12 13  9 15 11 10  6  1  5  3  7  2  8  4 ...
                8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
               16 11 12  9 13 10 14 15  6  1  4  3  8  7  2  5]; 

users{8} = '\Data\Subjects\SHR_.USER';    % Shayan Rafizadeh
repOrder{8} = [ 3  5  7  4  2  8  1  6 16  9 11 15 10 12 13 14 ...
               11 15  9 16 12 13 14 10  7  3  1  8  5  4  2  6 ...
                8  7  5  1  6  3  2  4 12 15 16 11 10 14 13  9 ...
               16 13 15 12 11 14  9 10  8  2  4  5  3  6  1  7]; 
          
users{9} = '\Data\Subjects\MRR_.USER';    % Mohammad Reza Rafipour
repOrder{9} = [ 3  1  6  7  2  5  4  8 15  9 13 16 14 10 12 11 ...
               14 11  9 15 12 13 10 16  1  7  4  2  8  3  6  5 ...
                6  8  7  2  3  5  1  4 10  9 15 16 11 12 14 13 ...
               11  9 15 16 10 14 12 13  2  7  5  8  1  4  3  6]; 
           
users{10} = '\Data\Subjects\AZ_.USER';    % Abtin Zohrabi
repOrder{10} = [ 6  3  7  8  5  1  2  4 16 11 14 15 13  9 10 12 ...
                14  9 13 11 15 10 16 12  8  6  4  5  1  7  3  2 ...
                 8  2  3  1  6  5  4  7 13 10  9 15 14 16 11 12 ...
                15 14 11 16 13 12  9 10  4  6  2  7  3  8  5  1];
           
users{11} = '\Data\Subjects\AP_.USER';    % Amir Pourafshar
repOrder{11} = [ 8  6  4  5  3  1  2  7 14 10 11 12  9 16 13 15 ...
                12 10 11  9 13 14 16 15  5  2  4  8  1  3  7  6 ...
                 8  3  6  4  5  2  1  7 10 16  9 11 13 15 12 14 ...
                12 13 16 14 11 15  9 10  4  3  5  6  7  8  1  2];
           

userList = 1:length(users);
userList = [1,3:11];

% positions = 1:5;
positions = 1:16;

numPositions = length(positions);

class = [1 2 3 4 7 10 11 12];
numClasses = length(class);
    
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
    
    numClssfrIdx = 0;
    for iNumClassifiers = [1,2,4,8,16]
        
        P_RI = [];
        P_SI = [];
        P_MSA = [];
        P_Dispersion = [];        
        P_DB = [];
        
        numClssfrIdx = numClssfrIdx + 1;
        posClusters = [];
        switch iNumClassifiers
            case 1
                posClusters(1,:) = [1:16];

            case 2                
                posClusters(1,:) = [1:4,9:12];
                posClusters(2,:) = [5:8,13:16];

            case 4
                posClusters(1,:) = [1:4];                
                posClusters(2,:) = [5:8];                
                posClusters(3,:) = [9:12];                
                posClusters(4,:) = [13:16];                

            case 8
                posClusters(1,:) = [1,2];                
                posClusters(2,:) = [3,4];                
                posClusters(3,:) = [5,6];                
                posClusters(4,:) = [7,8];   
                posClusters(5,:) = [9,10];                
                posClusters(6,:) = [11,12];                
                posClusters(7,:) = [13,14];                
                posClusters(8,:) = [15,16];


            case 16                
                posClusters(1,:) = [1];                
                posClusters(2,:) = [2];                
                posClusters(3,:) = [3];                
                posClusters(4,:) = [4];   
                posClusters(5,:) = [5];                
                posClusters(6,:) = [6];                
                posClusters(7,:) = [7];                
                posClusters(8,:) = [8];
                posClusters(9,:) = [9];                
                posClusters(10,:) = [10];                
                posClusters(11,:) = [11];                
                posClusters(12,:) = [12];   
                posClusters(13,:) = [13];                
                posClusters(14,:) = [14];                
                posClusters(15,:) = [15];                
                posClusters(16,:) = [16];
        end
        for iComb = 1 : size(posClusters,1)
            %%
            for iClass = 1:numClasses 
                myTestData(iClass).emgFeats = [];
                for iPos = posClusters(iComb,:)
                    myTestData(iClass).emgFeats = [myTestData(iClass).emgFeats; data(iClass,iPos).emgFeats(round(size(data(iClass,iPos).emgFeats,1)/2)+1:size(data(iClass,iPos).emgFeats,1),:)];
                end        
            end    
        end
        

        mydata = [];
        for iComb = 1 : size(posClusters,1)
            %%        
            for iClass = 1:numClasses 
                mydata(iClass).emgFeats = [];
                for iPos = posClusters(iComb,:)
                    mydata(iClass).emgFeats = [mydata(iClass).emgFeats; data(iClass,iPos).emgFeats(1:round(size(data(iClass,iPos).emgFeats,1)/2),:)];                
                end        
            end

            %%
            sigmaRI = 0 ;
            for iClass = 1 : numClasses
                iMuTst = mean(myTestData(iClass).emgFeats);
                iMuTr = mean(mydata(iClass).emgFeats);
                iS = cov(mydata(iClass).emgFeats);  
                iStst = cov(myTestData(iClass).emgFeats);  
                sigmaRI = sigmaRI + 0.5 * sqrt((iMuTr-iMuTst)*inv((iS+iStst)/2)*(iMuTr-iMuTst)');
            end
            P_RI(iComb) = numClasses/sigmaRI;

            %%

            sigmaM = 0;
            sigmaA = 0;
            sigmaR = 0;
            avgSi = 0;
            for iClass = 1:numClasses 
                minM = inf;  
                maxR = 0;
                iMu = mean(mydata(iClass).emgFeats);
                iS = cov(mydata(iClass).emgFeats);            

                clusterSize = size(mydata(iClass).emgFeats,1);
                sigmaS = 0;
                for idx = 1 : clusterSize
                    delta = mydata(iClass).emgFeats(idx,:) - iMu;
                    sigmaS = sigmaS + delta * delta';
                end            
                Si = sqrt(sigmaS / clusterSize);
                avgSi = avgSi + Si / numClasses;

                for jClass = 1:numClasses                                
                    if jClass ~= iClass                  
                        clusterSize = size(mydata(jClass).emgFeats,1);
                        sigmaS = 0;
                        for idx = 1 : clusterSize
                            delta = mydata(jClass).emgFeats(idx,:) - iMu;
                            sigmaS = sigmaS + delta * delta';
                        end            
                        Sj = sqrt(sigmaS / clusterSize);

                        jMu = mean(mydata(jClass).emgFeats);
                        jS = cov(mydata(jClass).emgFeats);
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

                featMax = max(mydata(iClass).emgFeats);
                featMin = min(mydata(iClass).emgFeats);
                A = power(prod(featMax - featMin),0.25);
                sigmaA = sigmaA + A;                        
            end        
            P_SI(iComb) = sigmaM / numClasses;
            P_MSA(iComb) = sigmaA / numClasses;
            P_DB(iComb) = sigmaR / numClasses;
            P_Dispersion(iComb) = avgSi;
        end        
        
        RI(iUser,numClssfrIdx) = mean(P_RI);
        SI(iUser,numClssfrIdx) = mean(P_SI);
        MSA(iUser,numClssfrIdx) = mean(P_MSA);
        DB(iUser,numClssfrIdx) = mean(P_DB);
        Dispersion(iUser,numClssfrIdx) = mean(P_Dispersion);
%         NSI(iUser,numClssfrIdx) = mean(P_NSI');
%         NRI(iUser,numClssfrIdx) = mean(P_NRI');
        
    end
    NSI(iUser,:) = (SI(iUser,:) - min(SI(iUser,:))) / (max(SI(iUser,:)) - min(SI(iUser,:)));
    NRI(iUser,:) = (RI(iUser,:) - min(RI(iUser,:))) / (max(RI(iUser,:)) - min(RI(iUser,:)));
end