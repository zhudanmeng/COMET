function Data = extractNormalizedFeatures(Data,settings,featType)

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

maxs = zeros(1,100);    
mins = ones(1,100) * inf;

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
        
        for jChan=1:size(Data(iClass,jPos).EMG,2)
            
       
            chanFrames = rawFrames(:,jChan,:);
            chanFrames = reshape(chanFrames,size(chanFrames,1),size(chanFrames,3));            
            switch featType
                case 'MEAN'
                    tdFeats = extractEMIFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                case 'TD'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    curFeats = [curFeats; tdFeats];
                case 'AR'
                    arFeats = extractARFeats(chanFrames,settings.arOrder);       % call to calculate the linear prediction coefficients
%                     rms = sqrt(sum(chanFrames.^2)/size(chanFrames,1));            % calculate root mean square of data
                    curFeats = [curFeats; arFeats];
                case 'TDAR'
                    tdFeats = extractTDFeats(chanFrames,settings.frameLen);
                    arFeats = extractARFeats(chanFrames,settings.arOrder);           % call to calculate the linear prediction coefficients
                    curFeats = [curFeats; tdFeats; arFeats];
                otherwise
                    errordlg('Invalid Feature Type');
            end
        end

        Data(iClass,jPos).emgFeats = curFeats';
        
        numFeats = size(curFeats,1);           
        for jFeat=1:numFeats     %Features            
            minV = min (curFeats(jFeat,:));
            maxV = max (curFeats(jFeat,:));                
            if minV < mins(jFeat)
                mins(jFeat) = minV;
            end
            if maxV > maxs(jFeat)
                maxs(jFeat) = maxV;
            end
        end            
    end
end

for iClass = 1:size(Data,1)
    for jPos = 1:size(Data,2)                
        for jFeat=1:numFeats                                   
            Data(iClass,jPos).emgFeats(:,jFeat) = (Data(iClass,jPos).emgFeats(:,jFeat) - mins(jFeat))/(maxs(jFeat)- mins(jFeat));
            if max(Data(iClass,jPos).emgFeats(:,jFeat)) == 0 
                Data(iClass,jPos).emgFeats(:,jFeat) = 1e-5 * rand(size(Data(iClass,jPos).emgFeats,1),1);
            end
        end         
    end
end
