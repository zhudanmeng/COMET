classdef aceSession
    
    properties (GetAccess = 'public', SetAccess = 'public') % public read access, but private write access.        
        userID                  % The session user 
        sessionName = ''        % The saved session file name
        familyName              % The session user last name
        givenName               % The session user first name
        clinician               % The attending clinician/experimenter
        startdate               % Session start time
        stopdate                % Session end time (when last saved)
        activeDOF               % List of active DOFs
        
        enablePropControl       % enable proportional control
        chan1                   % Input 1 
        chan2                   % Input 2
        thresh1 = 0.01          % Input 1 Threshold
        thresh2 = 0.01          % Input 2 Threshold
        max1 = 0
        max2 = 0
        inputGain1 = 1
        inputGain2 = 1
        outputGain1 = 3
        outputGain2 = 3
        isActive = 0
        motorEnable = 0
        actionDirection = 1
        controlMode = 0
        activationMode = 1
        riseTime = 0.2
        firstCome = []  
        
%         prData                  % Contains array of aceClass objects, which hold any collected data
%         classifiers             % Contains any trained classifiers
%         classOverrides 
            
        availableChans
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access
        isSaved = false         % Saved status
    end
    
    methods
        
        %% Constructor
        function obj = aceSession(aceInit,userID)       
            
            if nargin>1
                obj = obj.setUserID(userID);
            end

            if nargin>0
                aChans = zeros(1,aceInit.NUM_CHANNELS+aceInit.NUM_CLASSES);
                aChans(1:aceInit.NUM_CHANNELS) = 1;
                obj.availableChans = aChans;
                
                obj.enablePropControl = true(1,aceInit.NUM_DOF);       % enable proportional control
                obj.chan1 = zeros(1,aceInit.NUM_DOF);                  % Input 1
                obj.chan2 = zeros(1,aceInit.NUM_DOF);                  % Input 2
                obj.thresh1 = 0.01*ones(1,aceInit.NUM_DOF);            % Input 1 Threshold
                obj.thresh2 = 0.01*ones(1,aceInit.NUM_DOF);            % Input 2 Threshold
                obj.max1 = zeros(1,aceInit.NUM_DOF);
                obj.max2 = zeros(1,aceInit.NUM_DOF);
                obj.inputGain1 = ones(1,aceInit.NUM_DOF);
                obj.inputGain2 = ones(1,aceInit.NUM_DOF);
                obj.outputGain1 = 3*ones(1,aceInit.NUM_DOF);
                obj.outputGain2 = 3*ones(1,aceInit.NUM_DOF);
                obj.isActive = false(1,aceInit.NUM_DOF);
                obj.motorEnable = false(1,aceInit.NUM_DOF);
                obj.actionDirection = ones(1,aceInit.NUM_DOF);
                obj.controlMode = zeros(1,aceInit.NUM_DOF);
                obj.activationMode = ones(1,aceInit.NUM_DOF);
                obj.riseTime = 0.2*ones(1,aceInit.NUM_DOF);
                obj.firstCome = zeros(1,aceInit.NUM_DOF);
                
%                 obj.prData = aceClass(aceInit.className{1});
%                 for i=2:aceInit.NUM_CLASSES
%                     obj.prData(i) = aceClass(aceInit.className{i});
%                 end
%                 obj.classOverrides = 1:aceInit.NUM_CLASSES;

            else
                error('ACE Initialization Input Required');
            end
            
            obj.startdate = now;
        end
        
        %% Set User ID
        function obj = setUserID(obj, userID)
            if ~isequal(obj.userID,userID)
                obj = obj.setIsSaved(false);
            end
            assert((userID > datenum(2010,1,1)) && (userID < datenum(2050,1,1)))
            obj.userID = userID;
        end
        
        %% Set User Given name
        function obj = setGivenName(obj, givenName)
            if ~isequal(obj.givenName,givenName)
                obj = obj.setIsSaved(false);
            end
            obj.givenName = givenName;
        end
        
        %% Set User Family name
        function obj = setFamilyName(obj, familyName)
            if ~isequal(obj.familyName,familyName)
                obj = obj.setIsSaved(false);
            end
            obj.familyName = familyName;
        end
        
        %% Set User Family name
        function obj = setSessionName(obj, sessionName)
%             if ~isequal(obj.sessionName,sessionName)
%                 obj = obj.setIsSaved(false);
%             end
            obj.sessionName = sessionName;
        end
        
        
        %% Set Attending Clinicial/Experimenter
        function obj = setClinician(obj, clinician)
            if ~isequal(obj.clinician,clinician)
                obj = obj.setIsSaved(false);
            end
            obj.clinician = clinician;
        end

        %% Set End/Save Date/Time
        function obj = setStopDate(obj)
            obj = obj.setIsSaved(false);
            obj.stopdate = now;
        end
                   
        %% Set Active DOF
        function obj = setActiveDOF(obj, activeDOF)
            if ~isequal(obj.activeDOF,activeDOF)
                obj = obj.setIsSaved(false);
            end
            obj.activeDOF = activeDOF;
        end        
                
        %% Set Any Control Params
%         function obj = setParam(obj, paramName, paramValue)
%             try
%                 if ~isequal(obj.(paramName),paramValue)
%                     obj = obj.setIsSaved(false);
%                 end
%                 obj.(paramName) = paramValue;
%             catch
%                 error('aceSessionError: Invalid Session Parameter');
%             end
%         end      
        
        %% Get Save Status
        function isSavedStatus = getIsSaved(obj)
            isSavedStatus = obj.isSaved;
        end
        
        %% Set Save Status
        function obj = setIsSaved(obj, isSavedStatus)
            obj.isSaved = isSavedStatus;
%             if isSavedStatus
%                 set(findobj('Tag','aceSessionScreen'),'Name',['ACE User Session - ' obj.sessionName]);     % Update file name in title
%             else
%                 set(findobj('Tag','aceSessionScreen'),'Name',['ACE User Session - ' obj.sessionName ' *']);     % Update file name in title
%             end
        end
        
    end % End Methods
    
end
