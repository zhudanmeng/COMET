classdef aceLDA
    
    properties (GetAccess = 'public', SetAccess = 'private') % public read access, but private write access.        
        isTrained               % Is the classifier trained
        isTested                % Is the classifier tested
        covMatrix               % Covariance Matrix
        numPatterns             % Number of Exemplars for each Class
        weights                 % LDA Weights
        offsets                 % LDA Offsets
        invCov                  % Inverse Covariance Matrix        
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access

    end
        
    
    methods
        
        %% Constructor
        function obj = aceLDA()             
            obj;
        end
                     
    end % End Methods
    
end
