%%/*++%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Name: trainClassifier.m
%  
%	Description: This file contains the data collection portion of ACE.
%
%	MATLAB Calling Parameters:
%
%	varargout = trainClassifier(varargin);
%	
%	where inputs are:
%       - classifier: an initialized classifier structure
%	and outputs are:
%       - classifier: the trained classifier structure 
%	Returns:	
%
%	NOTE: 
%
%	Revision History:
%	Date	 Who Comments	
%	-------- --- ---------------------------------------------------------------
%	10/12/07 EJS Created
%
%	$Id$
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--*/

function classifier = trainClassifier_LDA(classifier,userInfo) 

prSetup = userInfo.prSetup;                                             % Get local PR configuration
aceInit = userInfo.aceInit;                                           % Get ACE params
settings = userInfo.settings;

frameLen = settings.frameLen;
frameInc = settings.frameInc;
Data = prSetup.prData;

activeChannels = classifier.activeChannels;

settings.enableLPF = 0;

try
    if settings.enableHPF
        [HPF.b,HPF.a] = butter(settings.filterOrder,settings.cutoffFreq/(settings.sampleFreq/2),'high');
    end
    if settings.enableLPF
        [LPF.b,LPF.a] = butter(settings.filterOrder,500/(settings.sampleFreq/2),'low');
    end
    if settings.enableNotch
        for iFreq=1:length(settings.notchFreq)
        [NF(iFreq).b,NF(iFreq).a] = butter(settings.notchQ, ...
            [(settings.notchFreq(iFreq)-5)/(settings.sampleFreq/2) (settings.notchFreq(iFreq)+5)/(settings.sampleFreq/2)],'stop');
        end
    end
catch
end

activeClasses = unique(classifier.overrides(classifier.classNumbers));
classifier.origClassNumbers = classifier.classNumbers;
classifier.classNumbers = activeClasses;
        
for iClass=activeClasses
    if ~isempty(Data(iClass).trainData)

        % Notch Filter
        if settings.enableNotch
            for iFreq=1:length(settings.notchFreq)
                Data(iClass).trainData(:,activeChannels) = filtfilt(NF(iFreq).b,NF(iFreq).a, Data(iClass).trainData(:,activeChannels));
            end
        end

        %% High-Pass Filter
        if settings.enableHPF
            Data(iClass).trainData(:,activeChannels) = filtfilt(HPF.b,HPF.a,Data(iClass).trainData(:,activeChannels));
        end
        
        %% Low-Pass Filter
        if settings.enableLPF
            Data(iClass).trainData(:,activeChannels) = filtfilt(LPF.b,LPF.a,Data(iClass).trainData(:,activeChannels));
        end
    end
end

for i=1:aceInit.NUM_CLASSES
    if classifier.overrides(i) ~= i
        Data(classifier.overrides(i)).trainData = [Data(classifier.overrides(i)).trainData; Data(i).trainData];
        Data(i).trainData = [];
    end
end

for iClass = 1:length(activeClasses)
    classifier.MAV(iClass) = mean(mean(abs(Data(activeClasses(iClass)).trainData(:,activeChannels))));
end
 
for chn = 1:length(activeChannels)
    eval(['ch' num2str(activeChannels(chn)) ' = [];']);
end

enframedMAV = [];
enframedFeats = [];
enframedClass = [];

% settings.featType = 'NEW';
% disp('Setting Feature Type to "New"')

waitHandle = waitbar(0,'Extracting Training Features...');
for i=1:length(activeClasses)
    curFeats = [];
    curMAV = [];     
    
    for j=1:length(activeChannels)
        waitbar((length(activeChannels)*(iClass-1)+j)/(length(activeChannels)*length(activeClasses)),waitHandle,'Extracting Training Features...');

        rawData = Data(activeClasses(i)).trainData(:,activeChannels(j));    % get data coressponding to current class and channel

        ind = 1:frameLen;                                                   % initialize a range of data corresponding to the specified record length
        rawFrames = [];        
        seg = 0;                                                            % initialize a segment counter
        while max(ind)<= length(rawData)                                    % loop to get as many complete segments of data as possible
            seg = seg + 1;                                                  % advance segment counter
            rawFrames(:,seg) = rawData(ind);                                % add segment of data as a column in 'enframedData'
            ind = ind + frameInc;                                           % advance data-range counter by specified processing delay
        end
        
        switch settings.featType
            case 'TD'
                tdFeats = extractTDFeats(rawFrames,frameLen);
                curFeats = [curFeats; tdFeats];
            case 'AR'
                arFeats = extractARFeats(rawFrames,settings.arOrder);       % call to calculate the linear prediction coefficients
                rms = sqrt(sum(rawFrames.^2)/size(rawFrames,1));            % calculate root mean square of data
                curFeats = [curFeats; arFeats; rms];
            case 'TDAR'
                tdFeats = extractTDFeats(rawFrames,frameLen);
                arFeats = extractARFeats(rawFrames,settings.arOrder);           % call to calculate the linear prediction coefficients
                curFeats = [curFeats; tdFeats; arFeats];
            case 'NEW'
                rmsFeats = [];
                for iSeg = 1:length(rawFrames(:,1))-9
                    rmsFeats(:,iSeg) = sqrt(sum(rawFrames(iSeg:iSeg+9,:).^2));            % calculate root mean square of data
                end
                magFeats = [];
                for iSeg = 1:floor(length(rmsFeats(1,:))/10)-2
                    magFeats(:,iSeg) = -log10(mean(rmsFeats(:,(iSeg-1)*10+1:(iSeg-1)*10+20),2));
                end
%                 curFeats = [curFeats; magFeats'];       
%                 tdFeats = extractTDFeats(rawFrames,frameLen);
%                 curFeats = [curFeats; tdFeats];
                clear rmsFeats magFeats
            case 'TD_NORM'
                tdFeats = extractTDFeats(rawFrames,frameLen);
                curFeats = [curFeats; tdFeats];                
            otherwise
                errordlg('Invalid Feature Type');
        end
        curMAV = [curMAV; mean(abs(rawFrames))];
    end
    if isequal(settings.featType,'TD_NORM')
        curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),length(activeChannels),1);
    end   
            
    enframedMAV = [enframedMAV curMAV];
    enframedFeats = [enframedFeats curFeats];                              % add each channel's (enframed) features to array
    enframedClass = [enframedClass ones(1,size(curFeats,2))*i];
end

waitbar(1,waitHandle,'Performing Feature Reduction...');
try
    [trainFeats,gULDA] = uldaFeatureReduction(enframedFeats',inf,enframedClass');
    classifier.gULDA = gULDA;
    classifier.classList = []; %activeClasses(enframedClass);
catch
    errordlg({'An Error Occured During Feature Reduction.',' ','Please check data integrity.'},'Data Error','modal');
    classifier.gULDA = [];
    classifier.trainFeats = [];
    classifier.classList = [];
end

waitbar(1,waitHandle,'Training LDA Classifier...');
classifier.lda = trainALDA(trainFeats',enframedClass);
classifier.trainFeats = trainFeats';
classifier.trainTargets = enframedClass';
classifier.alda = classifier.lda;

classifier.enablePCA = settings.enablePCA;
classifier.featType = settings.featType;
classifier.arOrder = settings.arOrder;
classifier.frameLen = settings.frameLen;
classifier.sampleFreq = settings.sampleFreq;


classifier.prThresh.detected = zeros(1,length(activeClasses));
classifier.prThresh.rejected = zeros(1,length(activeClasses));

classifier.clusterInfo.g = [];
classifier.clusterInfo.xg = [];
classifier.clusterInfo.yg = [];

close(waitHandle);