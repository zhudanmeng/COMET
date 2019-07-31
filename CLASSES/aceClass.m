classdef aceClass

    % Matlab OOP Class for storing ACE class information & data.
    %
    % Methods:
    %   obj = aceClass(className)     
    %   obj = addRep(obj, rep)
    %   obj = delRep(obj, repIdx)
    %   numReps = getNumReps(obj)
    %   rep = getRep(obj, repIdx)
    %   data = getData(obj, repIdx)
    %
    
    properties (GetAccess = 'public', SetAccess = 'public') % public read access, but private write access.        
                
        reps        % The Rep data
        className   % The class Name             
        isSel = 0   % Selection Flag 
        trainRepStart   % Start Indices 
        trainRepStop    % Stop Indices        
        trainData       % All Rep Data
        
    end 

    properties (GetAccess = 'private', SetAccess = 'private') % private read and write access
        isSaved = false         % Saved status
    end
    
    methods
        
        %% Constructor
        function obj = aceClass(className, isSel)       
            
            assert(nargin>0,'ACE:InvalidInputError','Invalid Input Parameters for Object aceClass');           
            obj.className = className;  
            obj.isSel = isSel;
            obj.trainData = zeros(0,0);
            
        end
        
        %% Add Rep
        function obj = addRep(obj, rep)
            if isempty(obj.reps)
                obj.reps = rep;          
            else
                obj.reps(end+1:end+length(rep)) = rep;
            end
        end
        
        %% Remove Rep
        function obj = delRep(obj, repIdx)
            
            if nargin>1 
                assert(length(obj.reps)>=max(repIdx),'ACE:DimensionError','Requested Rep Does Not Exist')
                obj.reps(repIdx) = [];
            else
                obj.reps = [];
            end
        end

              
        %% Get Number of Rep
        function numReps = getNumReps(obj)
            numReps = length(obj.reps);
        end
        
        
        %% Get Rep(s)
        function rep = getRep(obj, repIdx)
            % Returns the data from the specified rep
            if nargin>1
            assert(length(obj.reps)>=repIdx,'ACE:DimensionError','Requested Rep Does Not Exist')
            rep = obj.reps(repIdx);
            else
                rep = obj.reps;
            end
        end
        
        %% Get Rep Data
        function data = getData(obj, repIdx)
            % Returns the data from all reps concatenated together
            if nargin>1
                assert(length(obj.reps)>=max(repIdx),'ACE:DimensionError','Requested Rep Does Not Exist')
                data = [];
                for i=1:length(repIdx)
                    data = [data; obj.reps(repIdx(i)).getData()];
                end
            else
                data = [];
                for i=1:length(obj.reps)
                    data = [data; obj.reps(i).getData()];
                end
            end
        end        
                
    end % End Methods
    
end
