function Data = extractNormFeatures(Data,settings,featType)

if nargin<3
    featType = 'TD';
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

for iClass = 1:size(Data,1)
    for jPos = 1:size(Data,2)
        
        % Notch Filter
        if settings.enableNotch
            for iFreq=1:length(settings.notchFreq)
                Data(iClass,jPos).EMG = filtfilt(NF(iFreq).b,NF(iFreq).a, Data(iClass,jPos).EMG);
            end
        end
        
        %% High-Pass Filter
        if settings.enableHPF
            Data(iClass,jPos).EMG = filtfilt(HPF.b,HPF.a,Data(iClass,jPos).EMG);
        end
        
        %% Low-Pass Filter
        if settings.enableLPF
            Data(iClass,jPos).EMG = filtfilt(LPF.b,LPF.a,Data(iClass,jPos).EMG);
        end
    end
end
    
for iClass = 1:size(Data,1)
    for jPos = 1:size(Data,2)
        
        curFeats = [];
        
        rawData = Data(iClass,jPos).EMG;    % get data corresponding to current class and channel

        ind = 1:settings.frameLen;                                          % initialize a range of data corresponding to the specified record length
        rawFrames = [];
        seg = 0;                                                            % initialize a segment counter
        while max(ind)<= size(rawData,1)                                    % loop to get as many complete segments of data as possible
            seg = seg + 1;                                                  % advance segment counter
            rawFrames(:,:,seg) = rawData(ind,:);                                % add segment of data as a column in 'enframedData'
            ind = ind + settings.frameInc;                                  % advance data-range counter by specified processing delay
        end
                
        if isequal(featType,'TD_NORMD')
            for iFrame = 1:size(rawFrames,3)
                rawFrames(:,:,iFrame) = rawFrames(:,:,iFrame)./mean(mean(abs(rawFrames(:,:,iFrame))));
            end           
        end
        
        for jChan=1:size(Data(iClass,jPos).EMG,2)
            
%             waitbar((length(channels)*(iClass-1)+jChan)/(length(channels)*length(classes)),waitHandle);

            chanFrames = rawFrames(:,jChan,:);
            chanFrames = reshape(chanFrames,size(chanFrames,1),size(chanFrames,3));
            switch featType
                case 'MEAN'
                    tdFeats = extractEMIFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];                    
                case 'TD'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                case 'TD_NORMD'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                
                case 'AR'
                    arFeats = extractARFeats(chanFrames,settings.arOrder);       % call to calculate the linear prediction coefficients
                    rms = sqrt(sum(chanFrames.^2)/size(chanFrames,1));            % calculate root mean square of data
                    curFeats = [curFeats; arFeats; rms];
                case 'TDAR'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    arFeats = extractARFeats(chanFrames,settings.arOrder);           % call to calculate the linear prediction coefficients
                    curFeats = [curFeats; tdFeats; arFeats];
                case 'KAUF'
                    rmsFeats = [];
                    for iSeg = 1:length(chanFrames(:,1))-9
                        rmsFeats(:,iSeg) = sqrt(sum(chanFrames(iSeg:iSeg+9,:).^2));            % calculate root mean square of data
                    end
                    magFeats = [];
                    for iSeg = 1:floor(length(rmsFeats(1,:))/10)-2
                        magFeats(:,iSeg) = -log10(mean(rmsFeats(:,(iSeg-1)*10+1:(iSeg-1)*10+20),2));
                    end
                    curFeats = [curFeats; magFeats'];
                    clear rmsFeats magFeats
                    
                case 'TD_KAUF_AMP'
                    rmsFeats = [];
                    for iSeg = 1:length(chanFrames(:,1))-9
                        rmsFeats(:,iSeg) = sqrt(sum(chanFrames(iSeg:iSeg+9,:).^2));            % calculate root mean square of data
                    end
                    magFeats = [];
                    for iSeg = 1:floor(length(rmsFeats(1,:))/10)-2
                        magFeats(:,iSeg) = -log10(mean(rmsFeats(:,(iSeg-1)*10+1:(iSeg-1)*10+20),2));
                    end
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; [magFeats tdFeats(2:end,:)']'];
                    
                case 'TD_NORM1'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                    
                case 'TD_NORM2'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                    
                case 'TD_NORM3'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                    
                case 'MFCC'
                    mfccFeatsTmp = getmfccfeat(chanFrames,1000,6,settings.frameLen,settings.frameInc);
                    for iFeat=1:size(mfccFeatsTmp,1)
                        mfccFeats(iFeat,:) = mfccFeatsTmp(iFeat,1,:);
                    end
                    rms = sqrt(sum(chanFrames.^2)/size(chanFrames,1));            % calculate root mean square of data
                    curFeats = [curFeats; mfccFeats; rms];
                otherwise
                    errordlg('Invalid Feature Type');
            end
        end
        if isequal(featType,'TD_NORM1')
            curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),size(curFeats(1:4:end,:),1),1);
        end
        if isequal(featType,'TD_NORM2')
            curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),size(curFeats(1:4:end,:),1),1);
            curFeats(4:4:end,:) = curFeats(4:4:end,:) ./ repmat(sum(curFeats(4:4:end,:)),size(curFeats(4:4:end,:),1),1);
        end
        if isequal(featType,'TD_NORM3')
            curFeats(1:4:end,:) = curFeats(1:4:end,:) ./ repmat(sum(curFeats(1:4:end,:)),size(curFeats(1:4:end,:),1),1);
            curFeats(2:4:end,:) = curFeats(2:4:end,:) ./ repmat(sum(curFeats(2:4:end,:)),size(curFeats(2:4:end,:),1),1);
            curFeats(3:4:end,:) = curFeats(3:4:end,:) ./ repmat(sum(curFeats(3:4:end,:)),size(curFeats(3:4:end,:),1),1);
            curFeats(4:4:end,:) = curFeats(4:4:end,:) ./ repmat(sum(curFeats(4:4:end,:)),size(curFeats(4:4:end,:),1),1);
        end
%         enframedFeats = [enframedFeats curFeats];                              % add each channel's (enframed) features to array        
%         enframedClass = [enframedClass ones(1,size(curFeats,2))*iClass];
        Data(iClass,jPos).emgFeats = curFeats';
    end
end
%     if isTrain
%         if doReduction
%             waitbar(1,waitHandle,'Performing Feature Reduction...');
%             try
%                 [trainFeats,gULDA] = uldaFeatureReduction(enframedFeats',inf,enframedClass');
%                 trainFeats = trainFeats';
%             catch
%                 errordlg({'An Error Occured During Feature Reduction.',' ','Please check data integrity.'},'Data Error','modal');
%             end
%         else
%             trainFeats = enframedFeats;
%         end
%         trainTargets = enframedClass';
%     else
%         if doReduction
%             testFeats = gULDA'*enframedFeats;
%         else
%             testFeats = enframedFeats;
%         end
%         testTargets = enframedClass';
%     end
end
