classdef aceClassifier 
    
    properties (GetAccess = 'public', SetAccess = 'private') % public read access, but private write access.        
        type                    % Classifier Type
        isTrained               % Is the classifier trained
        isTested                % Is the classifier tested
        overrides               % Override classes
        classNumbers            % Class Numbers
        classNames              % Class Names
        name                    % Name of classifier 
        trainSettings           % The settings used when trained
        
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access

    end
        
    
    methods
        
        %% Constructor
        function obj = aceClassifier(type)             
            obj.type = type;
        end
        
            
             
    end % End Methods
    
end
