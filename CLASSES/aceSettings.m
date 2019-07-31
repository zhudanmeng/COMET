classdef aceSettings
    
    properties (GetAccess = 'public', SetAccess = 'public') % public read access, but private write access.        
        frameLen = 160;             % Frame Length for windowing
        frameInc = 64;              % Frame Increment for windowing
        sampleFreq = 1000;          % Sampling Frequency 
        
        enableMV = false;           % Majority Vote smoothing of Intent outputs   
        numMV = 5;                  % Number of votes in majority vote
        timeMV = 80;                % Time of majority vote    
        
        enableGS = false;           % Majority Vote Count for Grasp Select
        numGS = 10;                 % Number of grasp select votes 
        timeGS = 160;               % Time of grasp select
        
        enableIT = false;           % Proportional Control Intensity Throttle (Ramp)
        numIT = 5;                  % Number of Intensity throttle votes
        timeIT = 80;                % Time of Intensity throttle

        enableALDA = false;         % Enable Adaptive LDA (Adaptation)       
        adaptFactor = 0.9500;       % Adaptation Factor
        confFactor = 2.5000;        % Required Confidence Factor to Adaptation (STD)
        
        enablePRThreshold = false;  % Enable Thresholding of LDA outputs using STD
        prThreshold = 3;            % Threshold for LDA Outputs
        
        enablePCA = false;          % Enable PCA Tuning
        enableULDA = true;          % Enable ULDA Feature Reduction
        
        enableLPF = false;          % Enable Low Pass Filtering
        enableHPF = true;           % Enable High Pass Filtering
        cutoffFreq = 20;            % High Pass Filter Cutoff Frequency
        filterOrder = 3;            % High Pass Filter Order
        
        enableNotch = true;         % Enable Notch Filtering
        notchFreq = [60 180 300];   % Notch Frequencies
        notchQ = 1;                 % Notch Q (Order)
        
        featType = 'TD';            % Feature Type
        arOrder = 7;                % Auto-Regressive Order (if featType == 'AR')
        classifierType = 'LDA';     % Classifier Type
        propCtrlType = 1;           % Proportional Control Type
        
        emiChans = false(1,8);      % Electro-Mechanical Channel Overrides
        
        delay = '1';                % Delay Between Pattern Recognition Data Collection Reps
        duration = '3';             % Length of Pattern Recognition Data Collection Reps
      
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access

    end
        
    
    methods
        
        %% Constructor
        function obj = aceSettings(aceInit)             
            if nargin>0
                obj.emiChans = false(1,aceInit.NUM_CHANNELS);
            end
        end
        
        function setParam(obj,paramName,paramVal)             
            switch lower(paramName)

                case 'framelen'                 % Frame Length for windowing, in mS
                    assert((paramVal > 16) && ~mod(paramVal,16),'Invalid Frame Length') 
                case 'frameinc'                 % Frame Increment for windowing, in mS
                    assert((paramVal > 16) && ~mod(paramVal,16),'Invalid Frame Increment') 
                case 'samplefreq'               % Sampling Frequency
                    assert(paramVal == 1000,'Invalid Sampling Frequency') 
                    
                case 'enablemv'                 % Majority Vote smoothing of Intent outputs
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable Majority Voting Value') 
                    paramVal = logical(paramVal);
                case 'nummv'                    % Number of votes in majority vote
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid Number of Majority Votes')
                    
                case 'enablegs'                 % Majority Vote Count for Grasp Select
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable Grasp Select Value') 
                    paramVal = logical(paramVal);
                case 'numgs'                    % Number of grasp select votes
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid Number of Grasp Select Votes')
                    
                case 'enableit'                 % Proportional Control Intensity Throttle 
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable Intensity Throttle Value') 
                    paramVal = logical(paramVal);
                case 'numit'                    % Number of Intensity throttle votes
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid Number of Intensity Throttle Votes')
                    
                case 'enablealda'               % Enable Adaptive LDA (Adaptation)
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable LDA Adaptation Value') 
                    paramVal = logical(paramVal);
                case 'adaptfactor'              % Adaptation Factor
                    assert((paramVal <= 1) || (paramVal > 0),'Invalid LDA Adaptation Factor Value')
                case 'conffactor'               % Required Confidence Factor to Adaptation (STD)
                    assert(paramVal > 0,'Invalid LDA Adaptation Confidence Factor Value') 
                    
                case 'enableldathreshold'        % Enable Thresholding of LDA outputs using STD
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable LDA Thresholding Value') 
                    paramVal = logical(paramVal);
                case 'prthreshold'              % Threshold for LDA Outputs
                    assert(paramVal > 0,'Invalid LDA Threshold Value') 
                    
                case 'enablepca'                % Enable PCA Tuning
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable PCA Value') 
                    paramVal = logical(paramVal);
                case 'enableulda'               % Enable ULDA Feature Reduction
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable ULDA Value') 
                    paramVal = logical(paramVal);
                    
                case 'enablehpf'                % Enable High Pass Filtering
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable HPF Filter Value') 
                    paramVal = logical(paramVal);
                case 'cutofffreq'               % High Pass Filter Cutoff Frequency
                    assert(~sum(paramVal<=0),'Invalid HPF Cutoff Frequency')
                case 'filterorderhpf'              % High Pass Filter Order
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid HPF Filter Order') 
                                        
                case 'enablenotch'              % Enable Notch Filtering
                    assert((paramVal == true) || (paramVal == false),'Invalid Enable Notch Filter Value') 
                    paramVal = logical(paramVal);
                case 'notchfreq'                % Notch Frequencies
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid Notch Frequency') 
                case 'notchq'                   % Notch Q (Order)
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid Notch Q') 
                    
                case 'feattype'                 % Feature Type
                    assert(sum(strcmpi({'TD','AR','TDAR'},paramVal)),'Invalid Feature Type')
                    
                case 'arorder'                  % Auto-Regressive Order (if featType == 'AR')
                    assert((paramVal > 0) && (round(paramVal)==paramVal),'Invalid AR Order') 
                                        
                case 'classifiertype'           % Classifier Type
                    assert(isequal(paramVal,'LDA'),'Invalid Classifier Type')
                        
                case 'emichans'                 % Electro-Mechanical Channel Overrides
                    assert(mean(paramVal == logical(paramVal))==1,'Invalid Electro-Mechanical Channel Definition')
                    
                case 'delay'                    % Delay Between Pattern Recognition Data Collection Reps, in seconds
                case 'duration'                 % Length of Pattern Recognition Data Collection Reps, in seconds
                    
                otherwise
                    error('Invalid Parameter Name Specified');
            end
            obj.(paramName) = paramVal;
        end       
             
    end % End Methods
    
end
