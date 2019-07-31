function [prPredict enframedClass classErr confMatrix] = testClassifier_LDA(classifier,userInfo,showGUI)

if nargin < 3
    showGUI = 1;
end

if showGUI
    handles = aceLDAAnalysis(classifier,userInfo,0);
    handles = guidata(handles);
    contourHandle = findobj('Tag','contourAxes');
end

prSetup = userInfo.prSetup;                                             % Get local PR configuration
aceInit = userInfo.aceInit;                                           % Get ACE params
settings = userInfo.settings;
  
activeClasses = classifier.classNumbers;
activeChannels = classifier.activeChannels;

Data = prSetup.prData;
frameLen = classifier.frameLen;
frameInc = settings.frameInc;

settings.enableLPF = 0;

try
    if settings.enableHPF
        [HPF.b,HPF.a] = butter(settings.filterOrder,settings.cutoffFreq/(classifier.sampleFreq/2),'high');
    end
    if settings.enableLPF
        [LPF.b,LPF.a] = butter(settings.filterOrder,500/(classifier.sampleFreq/2),'low');
    end
    if settings.enableNotch
        for iFreq=1:length(settings.notchFreq)
        [NF(iFreq).b,NF(iFreq).a] = butter(settings.notchQ, ...
            [(settings.notchFreq(iFreq)-5)/(classifier.sampleFreq/2) (settings.notchFreq(iFreq)+5)/(classifier.sampleFreq/2)],'stop');
        end
    end
catch
end


for i=1:length(Data)
    if classifier.overrides(i) ~= i
        Data(classifier.overrides(i)).testData = [Data(classifier.overrides(i)).testData; Data(i).testData];
        Data(classifier.overrides(i)).testReps = Data(classifier.overrides(i)).testReps + Data(i).testReps;
        Data(i).testData = [];
        Data(i).testReps = 0;        
    end
end
 
for iClass=activeClasses
    if ~isempty(Data(iClass).testData)
        % Notch Filter
        if settings.enableNotch
            for iFreq=1:length(settings.notchFreq)
                Data(iClass).testData(:,activeChannels) = filtfilt(NF(iFreq).b,NF(iFreq).a, Data(iClass).testData(:,activeChannels));
            end
        end

        % ECG Clipping
        if settings.enableECGClip
            ecgClippingBuffer = [];
            for iSample=1:size(Data(iClass).testData,1)
                if isempty(ecgClippingBuffer)
                    ecgClippingBuffer =  Data(iClass).testData(iSample,activeChannels);
                elseif size(ecgClippingBuffer,1) < settings.ecgClippingFrameLen
                    ecgClippingBuffer = [ecgClippingBuffer; Data(iClass).testData(iSample,activeChannels)];
                else
                    ecgClippingBuffer = [ecgClippingBuffer(2:end,:); Data(iClass).testData(iSample,activeChannels)];
                    thresh = settings.gainFactor*mean(abs(ecgClippingBuffer));
                    for jChan=1:length(thresh)
                        if abs(Data(iClass).testData(iSample,activeChannels(jChan))) > thresh(jChan)
                            Data(iClass).testData(iSample,activeChannels(jChan)) = thresh(jChan)*sign(Data(iClass).testData(iSample,activeChannels(jChan)));
                        end
                    end
                end
            end
        end

        %% High-Pass Filter
        if settings.enableHPF
            Data(iClass).testData(:,activeChannels) = filtfilt(HPF.b,HPF.a,Data(iClass).testData(:,activeChannels));
        end

        %% Low-Pass Filter
        if settings.enableLPF
            Data(iClass).testData(:,activeChannels) = filtfilt(LPF.b,LPF.a,Data(iClass).testData(:,activeChannels));
        end
        
        
        if classifier.enablePCA
            Data(iClass).testData = Data(iClass).testData(:,activeChannels)*classifier.pcaMat';
        end           
    end
end

%% TESTING FEATURE EXTRACTION

enframedFeats = [];
enframedClass = [];

clustersEnabled = 0;

% settings.featType = 'NEW';
% disp('Setting Feature Type to "New"')

waitHandle = waitbar(0,'Extracting Testing Features...');            
for iClass=1:length(activeClasses)
    curFeats = [];
    for j=1:length(activeChannels)
        waitbar((length(activeChannels)*(iClass-1)+j)/(length(activeChannels)*length(activeClasses)),waitHandle,'Extracting Testing Features...');        
        rawData = Data(activeClasses(iClass)).testData(:,activeChannels(j));            % get data coressponding to current class and channel

        ind = 1:frameLen;                                                   % initialize a range of data corresponding to the specified record length
        seg = 0;                                                            % initialize a segment counter
        rawFrames= [];
        while max(ind)<= length(rawData)                                    % loop to get as many complete segments of data as possible
            seg = seg + 1;                                                  % advance segment counter
            rawFrames(:,seg) = rawData(ind);                                % add segment of data as a column in 'enframedData'
            ind = ind + frameInc;                                           % advance data-range counter by specified processing delay
        end

        switch classifier.featType

            case 'TD'

                tdFeats = extractTDFeats(rawFrames,frameLen);
                curFeats = [curFeats; tdFeats];

            case 'AR'

                arFeats = extractARFeats(rawFrames,classifier.arOrder);        % call to calculate the linear prediction coefficients
                rms = sqrt(sum(rawFrames.^2)/size(rawFrames,1));            % calculate root mean square of data
                curFeats = [curFeats; arFeats; rms];

            case 'TDAR'

                tdFeats = extractTDFeats(rawFrames,frameLen);
                arFeats = extractARFeats(rawFrames,classifier.arOrder);           % call to calculate the linear prediction coefficients
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
    end
    if isequal(classifier.featType,'TD_NORM')
        curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),length(activeChannels),1);
    end
    
    if clustersEnabled
        axes(contourHandle);                                  % point to scatterplot axes
        getContours(contourHandle,classifier.gULDA'*curFeats,ones(1,size(curFeats,2))*activeClasses(iClass),activeClasses(iClass),iClass,0,1,classifier.clusterInfo); % call to scatterplot
        set(contourHandle,'Tag','contourAxes');
        set(contourHandle,'XTick',[],'YTick',[]);             %
    end

    enframedFeats = [enframedFeats curFeats];                              % add each channel's (enframed) features to array
    enframedClass = [enframedClass ones(1,size(curFeats,2))*activeClasses(iClass)];
end


try
    close(waitHandle);
catch
end

try
    if ~isempty(classifier.groupClass)
        origFeats = enframedFeats;
    end
catch
end

enframedFeats = classifier.gULDA'*enframedFeats;
 
ldaScore = enframedFeats'*classifier.alda.W + repmat(classifier.alda.C,size(enframedFeats,2),1);
[dum prMotion] = max(ldaScore,[],2); 

% [sortVal sortIdx] = sort(ldaScore,2);
% sM = sortVal-repmat(min(sortVal,[],2),1,length(activeClasses));
% for i=1:length(activeClasses)
%     meanCorrect(i) = mean(sM(find(activeClasses(prMotion)==enframedClass),i)./sM(find(activeClasses(prMotion)==enframedClass),length(activeClasses)));
%     meanWrong(i) = mean(sM(find(activeClasses(prMotion)~=enframedClass),i)./sM(find(activeClasses(prMotion)~=enframedClass),length(activeClasses)));
%     stdCorrect(i) = std(sM(find(activeClasses(prMotion)==enframedClass),i)./sM(find(activeClasses(prMotion)==enframedClass),length(activeClasses)));
%     stdWrong(i) = std(sM(find(activeClasses(prMotion)~=enframedClass),i)./sM(find(activeClasses(prMotion)~=enframedClass),length(activeClasses)));
%     
% end

% save([userInfo.userName '_norm_probs.mat'],'meanCorrect','stdCorrect','meanWrong','stdWrong','sM','sortVal','sortIdx','ldaScore','enframedClass','activeClasses','prMotion')

try
    if ~isfield(classifier,'groupClass') || isempty(classifier.groupClass)
        prPredict = classifier.classNumbers(prMotion)';                                                      % save vector of class predictions
    else
        topTierClasses = classifier.classNumbers;
        for iGroup = 1:length(classifier.groupClass)
            topTierClasses = setdiff(topTierClasses,classifier.hierarchy{iGroup}.classNumbers);
        end
        topTierClasses = union(topTierClasses,classifier.groupClass);
        prPredict = topTierClasses(prMotion)'; 
    end
catch
end

try
    for iGroup = 1:length(classifier.groupClass)
        groupIdx = find(prPredict == classifier.groupClass(iGroup));
        groupFeats = classifier.hierarchy{iGroup}.gULDA'*origFeats(:,groupIdx);
        groupScore = groupFeats'*classifier.hierarchy{iGroup}.alda.W + repmat(classifier.hierarchy{iGroup}.alda.C,size(groupFeats,2),1);
        [dum groupMotion] = max(groupScore,[],2); 
        prPredict(groupIdx) = classifier.hierarchy{iGroup}.classNumbers(groupMotion);
    end
catch
end

classErr = zeros(1,length(activeClasses));

if settings.enableMV
    prMotion = majority2(prPredict,settings.numMV,length(activeClasses));       % calculate new predictions based on majority voting
    prPredict = prMotion';                                                % copy to new array of predicted values
end

for i = 1:length(activeClasses)
    if Data(activeClasses(i)).testReps
        classErr(i) = mean(prPredict(enframedClass==activeClasses(i)) ~= activeClasses(i));
    else
        classErr(i) = -1;
    end
    if showGUI
        tmpHandle = handles.classErr(activeClasses(iClass));
        if classErr(i) == 0
            try
                set(tmpHandle,'String',0);
            catch
            end
        else
            tmp = sprintf('%0.1f',100*classErr(i));
            try
                set(tmpHandle,'String',tmp);
            catch
            end
        end
    end
end

confMatrix = zeros(length(activeClasses),length(activeClasses));
try
    for i=1:length(activeClasses)
        for j=1:length(activeClasses)
            confMatrix(i,j) = sum(activeClasses(i)==prPredict(enframedClass==activeClasses(j)));
        end
    end
catch
end

averageError = sprintf('%0.1f',100*mean(prPredict~=enframedClass'));
averageFAR = sprintf('%0.1f',100*mean(prPredict(find(prPredict~=aceInit.restClass))~=enframedClass(find(prPredict~=aceInit.restClass))'));


try
    if showGUI
        set(handles.averageError,'String',averageError);
        set(handles.averageFAR,'String',averageFAR);

        set(handles.confMatrixButton,'Enable','on','UserData',confMatrix);
    end
catch
end


disp(['LDA Average Error: ' averageError]);
disp(['LDA Average FAR: ' averageFAR]);
disp(' ');
    
