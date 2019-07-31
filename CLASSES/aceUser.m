classdef aceUser
    
    properties (GetAccess = 'public', SetAccess = 'private') % public read access, but private write access.        
        givenName               % Given Name (First)
        familyName              % Family Name (Last)
        gender                  % Male or Female
        dob                     % Date of birth
        dominantSide            % Side of Dominant Arm: Left or Right
        prostheticSide          % Side of Deficiency: Left or Right  
        prostheticLevel         % Level of Deficiency: Shoulder Disarticulation, Trans-Humeral, Trans-Radial, Trans-Carpal
        residuumLength          % Length of Residuum: Short, Medium, Long
        deficiencyType          % Conjenital or Acquired
        deviceHistory           % Array of used devices, starting dates and end dates

        sessions                % List of saved Sessions for this user
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access
        userID                  % ACE user ID  
        isSaved = false;        % Save status (note: should always be 1 for loaded file)
    end
    
    methods
        
        %% Constructor
        function obj = aceUser(firstname, lastname)             
            if nargin > 1
                obj.familyName = lastname;
            end
            if nargin > 0
                obj.givenName = firstname;
            end
            obj.userID = now;
        end
        
        %% Set Given/First Name
        function obj = setGivenName(obj, firstname)
            if ~isequal(obj.givenName,firstname)
                obj = obj.setIsSaved(false);
            end
            obj.givenName = firstname;
        end

        %% Set Family/Last Name
        function obj = setFamilyName(obj, lastname)
            if ~isequal(obj.familyName,lastname)
                obj = obj.setIsSaved(false);
            end
            obj.familyName = lastname;
        end
        
        %% Set Gender
        function obj = setGender(obj, gender)
            oldGender = obj.gender;
            if nargin > 1
                assert(sum(strcmpi({'male','female'},gender))>0,'Invalid Gender Entry')
                obj.gender = gender;
            else
                obj.gender = [];
            end
            if ~isequal(oldGender, obj.gender)
                obj = obj.setIsSaved(false);
            end
        end
        
        %% Set Date of Birth
        function obj = setDOB(obj, dob)
            oldDOB = obj.dob;
            if nargin > 1
                obj.dob = dob;
            else
                obj.dob = [];
            end
            if ~isequal(oldDOB, obj.dob)
                obj = obj.setIsSaved(false);
            end
        end
                   
        %% Set Dominant Side
        function obj = setDominantSide(obj, dominantSide)
            oldDominantSide = obj.dominantSide;
            if nargin > 1
                assert(sum(strcmpi({'left','right'},dominantSide))>0,'Invalid Dominant Side Entry')
                obj.dominantSide = dominantSide;
            else
                obj.dominantSide = [];
            end
            if ~isequal(oldDominantSide, obj.dominantSide)
                obj = obj.setIsSaved(false);
            end
        end
        
        %% Set Prosthetic Side
        function obj = setProstheticSide(obj, prostheticSide)
            oldProstheticSide = obj.prostheticSide;
            if nargin > 1
                assert(sum(strcmpi({'left','right','both','neither'},prostheticSide))>0,'Invalid Prosthetic Side Entry')
                obj.prostheticSide = prostheticSide;
            else
                obj.prostheticSide = [];
            end
            if ~isequal(oldProstheticSide, obj.prostheticSide)
                obj = obj.setIsSaved(false);
            end
        end        
        
        %% Set Deficiency Level (Shoulder Disarticulation, Trans-Humeral, Trans-Radial, Trans-Carpal)
        function obj = setProstheticLevel(obj, prostheticLevel)
            oldProstheticLevel = obj.prostheticLevel;
            if nargin > 1
                if strcmpi('<Select Level>',prostheticLevel)
                    obj.prostheticLevel = [];
                    return
                end
                assert(sum(strcmpi({'sd','th','tr','tc'},prostheticLevel))>0,'Invalid Deficiency Level Entry')
                obj.prostheticLevel = prostheticLevel;
            else
                obj.prostheticLevel = [];
            end
            if ~isequal(oldProstheticLevel, obj.prostheticLevel)
                obj = obj.setIsSaved(false);
            end            
        end
        
        %% Set Length of Residuum (Short, Medium, Long)
        function obj = setResiduumLength(obj, residuumLength)
            oldResiduumLength = obj.residuumLength;
            if nargin > 1
                if ischar(residuumLength)
                    assert(sum(strcmpi({'short','medium','long'},residuumLength))>0,'Invalid Residuum Length Entry')
                else
                    assert(residuumLength>0,'Invalid Residuum Length Entry')
                end
                obj.residuumLength = residuumLength;
            else
                obj.residuumLength = [];
            end
            if ~isequal(oldResiduumLength, obj.residuumLength)
                obj = obj.setIsSaved(false);
            end             
        end
        
        %% Set Deficiency Type (Conjenital or Acquired)
        function obj = setDeficiencyType(obj, deficiencyType)
            oldDeficiencyType = obj.deficiencyType;
            if nargin > 1
                assert(sum(strcmpi({'conjenital','acquired'},deficiencyType))>0,'Invalid Deficiency Type Entry')
                obj.deficiencyType = deficiencyType;
            else
                obj.deficiencyType = [];
            end
            if ~isequal(oldDeficiencyType, obj.deficiencyType)
                obj = obj.setIsSaved(false);
            end                
        end
        
        %% Set Prosthetic History 
        function obj = setDeviceHistory(obj, deviceHistory)
            oldDeviceHistory = obj.deviceHistory;
            if nargin > 1
                if isempty(deviceHistory)
                    obj.deviceHistory = [];
                    return
                end
                assert(size(deviceHistory,2) == 3,'Invalid Prosthetic History entry');
                obj.deviceHistory = deviceHistory;
            else
                obj.deviceHistory = [];
            end
            if ~isequal(oldDeviceHistory, obj.deviceHistory)
                obj = obj.setIsSaved(false);
            end               
        end
    
        %% Get User ID
        function userID = getUserID(obj)
            userID = obj.userID;
        end
        
        %% Get Full User Name
        function name = getFullName(obj)
            name = [obj.givenName ' ' obj.familyName];
        end
        
        %% Get Save Status
        function isSavedStatus = getIsSaved(obj)
            isSavedStatus = obj.isSaved;
        end
        
        %% Set Save Status
        function obj = setIsSaved(obj, isSavedStatus)
            obj.isSaved = isSavedStatus;
        end
        
    end % End Methods
    
end
