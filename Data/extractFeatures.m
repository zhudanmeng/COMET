function [trainFeats, trainTargets, testFeats, testTargets] = extractFeatures(Data,settings,channels,classes,doReduction,override)

if nargin<5
    doReduction = 0;
end
if nargin<6
    override = [];
end

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

try
    for i=1:length(override)
        Data(length(Data)).testData = [Data(length(Data)).testData; Data(override(i)).testData];
        Data(override(i)).testData = [];
    end
catch
end

for iClass=classes
    if ~isempty(Data(iClass).trainData)
        % Notch Filter
        if settings.enableNotch
            for iFreq=1:length(settings.notchFreq)
                Data(iClass).trainData(:,channels) = filtfilt(NF(iFreq).b,NF(iFreq).a, Data(iClass).trainData(:,channels));
            end
        end

        %% High-Pass Filter
        if settings.enableHPF
            Data(iClass).trainData(:,channels) = filtfilt(HPF.b,HPF.a,Data(iClass).trainData(:,channels));
        end

        %% Low-Pass Filter
        if settings.enableLPF
            Data(iClass).trainData(:,channels) = filtfilt(LPF.b,LPF.a,Data(iClass).trainData(:,channels));
        end
    end
end

for iClass=classes
    if ~isempty(Data(iClass).testData)
        % Notch Filter
        if settings.enableNotch
            for iFreq=1:length(settings.notchFreq)
                Data(iClass).testData(:,channels) = filtfilt(NF(iFreq).b,NF(iFreq).a, Data(iClass).testData(:,channels));
            end
        end

        %% High-Pass Filter
        if settings.enableHPF
            Data(iClass).testData(:,channels) = filtfilt(HPF.b,HPF.a,Data(iClass).testData(:,channels));
        end

        %% Low-Pass Filter
        if settings.enableLPF
            Data(iClass).testData(:,channels) = filtfilt(LPF.b,LPF.a,Data(iClass).testData(:,channels));
        end
    end
end


for isTrain = [1 0]

    enframedFeats = [];
    enframedClass = [];

    if isTrain
        waitHandle = waitbar(0,'Extracting Training Features...');
    else
        waitbar(0,waitHandle,'Extracting Testing Features...');
    end

    if isequal(settings.featType,'WPT')
          [enframedFeats enframedClass wptParams] = extractWPTFeats(Data,settings,channels,classes,wptParams);
    else
        for i=1:length(classes)
            curFeats = [];

            for j=1:length(channels)
                waitbar((length(channels)*(i-1)+j)/(length(channels)*length(classes)),waitHandle);

                if isTrain
                    rawData = Data(classes(i)).trainData(:,channels(j));    % get data coressponding to current class and channel
                else
                    rawData = Data(classes(i)).testData(:,channels(j));    % get data coressponding to current class and channel
                end

                ind = 1:settings.frameLen;                                          % initialize a range of data corresponding to the specified record length
                rawFrames = [];
                seg = 0;                                                            % initialize a segment counter
                while max(ind)<= length(rawData)                                    % loop to get as many complete segments of data as possible
                    seg = seg + 1;                                                  % advance segment counter
                    rawFrames(:,seg) = rawData(ind);                                % add segment of data as a column in 'enframedData'
                    ind = ind + settings.frameInc;                                  % advance data-range counter by specified processing delay
                end

                switch settings.featType
                    case 'TD'
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        curFeats = [curFeats; tdFeats];
                    case 'AR'
                        arFeats = extractARFeats(rawFrames,settings.arOrder);       % call to calculate the linear prediction coefficients
                        rms = sqrt(sum(rawFrames.^2)/size(rawFrames,1));            % calculate root mean square of data
                        curFeats = [curFeats; arFeats; rms];
                    case 'TDAR'
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        arFeats = extractARFeats(rawFrames,settings.arOrder);           % call to calculate the linear prediction coefficients
                        curFeats = [curFeats; tdFeats; arFeats];
                    case 'KAUF'
                        rmsFeats = [];
                        for iSeg = 1:length(rawFrames(:,1))-9
                            rmsFeats(:,iSeg) = sqrt(sum(rawFrames(iSeg:iSeg+9,:).^2));            % calculate root mean square of data
                        end
                        magFeats = [];
                        for iSeg = 1:floor(length(rmsFeats(1,:))/10)-2
                            magFeats(:,iSeg) = -log10(mean(rmsFeats(:,(iSeg-1)*10+1:(iSeg-1)*10+20),2));
                        end
                        curFeats = [curFeats; magFeats'];
                        clear rmsFeats magFeats

                    case 'TD_KAUF_AMP'
                        rmsFeats = [];
                        for iSeg = 1:length(rawFrames(:,1))-9
                            rmsFeats(:,iSeg) = sqrt(sum(rawFrames(iSeg:iSeg+9,:).^2));            % calculate root mean square of data
                        end
                        magFeats = [];
                        for iSeg = 1:floor(length(rmsFeats(1,:))/10)-2
                            magFeats(:,iSeg) = -log10(mean(rmsFeats(:,(iSeg-1)*10+1:(iSeg-1)*10+20),2));
                        end
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        curFeats = [curFeats; [magFeats tdFeats(2:end,:)']'];

                    case 'TD_NORM1'
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        curFeats = [curFeats; tdFeats];
                        
                    case 'TD_NORM2'
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        curFeats = [curFeats; tdFeats];
                        
                    case 'TD_NORM3'
                        tdFeats = extractTDFeats(rawFrames,settings.frameLen);
                        curFeats = [curFeats; tdFeats];
                        
                    case 'MFCC'
                        mfccFeatsTmp = getmfccfeat(rawFrames,1000,6,settings.frameLen,settings.frameInc);
                        for iFeat=1:size(mfccFeatsTmp,1)
                            mfccFeats(iFeat,:) = mfccFeatsTmp(iFeat,1,:);
                        end
                        rms = sqrt(sum(rawFrames.^2)/size(rawFrames,1));            % calculate root mean square of data
                        curFeats = [curFeats; mfccFeats; rms];
                    otherwise
                        errordlg('Invalid Feature Type');
                end
            end
            if isequal(settings.featType,'TD_NORM1')
                curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),length(channels),1);
            end
            if isequal(settings.featType,'TD_NORM2')
                curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),length(channels),1);
                curFeats(4:4:end,:) = curFeats(4:4:end,:) ./ repmat(sum(curFeats(4:4:end,:)),length(channels),1);
            end
            if isequal(settings.featType,'TD_NORM3')
                curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),length(channels),1);
                curFeats(2:4:end,:) = curFeats(2:4:end,:) ./ repmat(sum(curFeats(2:4:end,:)),length(channels),1);                
                curFeats(3:4:end,:) = curFeats(3:4:end,:) ./ repmat(sum(curFeats(3:4:end,:)),length(channels),1);                
                curFeats(4:4:end,:) = curFeats(4:4:end,:) ./ repmat(sum(curFeats(4:4:end,:)),length(channels),1);
            end            
            enframedFeats = [enframedFeats curFeats];                              % add each channel's (enframed) features to array
            enframedClass = [enframedClass ones(1,size(curFeats,2))*i];
        end
    end

    if isTrain
        if doReduction
            waitbar(1,waitHandle,'Performing Feature Reduction...');
            try
                [trainFeats,gULDA] = uldaFeatureReduction(enframedFeats',inf,enframedClass');
                trainFeats = trainFeats';
            catch
                errordlg({'An Error Occured During Feature Reduction.',' ','Please check data integrity.'},'Data Error','modal');
            end
        else
            trainFeats = enframedFeats;
        end
        trainTargets = enframedClass';
    else
        if doReduction
            testFeats = gULDA'*enframedFeats;
        else
            testFeats = enframedFeats;
        end
        testTargets = enframedClass';
    end
end
close(waitHandle);

