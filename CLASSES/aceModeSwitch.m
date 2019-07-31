classdef aceModeSwitch
    
    properties (GetAccess = 'public', SetAccess = 'public') % public read access, but private write access.        
                      
        mode = 2;
        activeDOFs = [];
        numStates = 0;
        state = 1;
        
        saChan = 0;
        saGain = 3;
        saThresh = 0.01;
        
        caChan1 = 0;
        caChan2 = 0;
        caGain1 = 3;
        caGain2 = 3;
        caThresh1 = 0.01;
        caThresh2 = 0.01;
        
        percentVote = 100;
        numVotes = 5;
        timeoutLength = 3;
        allowSwitch = 1;
        msWindow = [];
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access
        isSaved                 % Saved status
    end
    
    methods
        
        %% Constructor
        function obj = aceModeSwitch(aceInit)       
            obj;
        end
        
    end % End Methods
    
end
