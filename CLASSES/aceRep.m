classdef aceRep
    
    % Matlab OOP Class for storing a single rep of ACE data.
    %
    % Methods:
    %   obj = aceRep(sampleFreq,data,hardware)
    %   obj = setData(obj,data)
    %   data = getData(obj)
    %   dataLen = getDataLen(obj)
    %   numChan = getNumChans(obj)
    %   obj = setHardware(obj, hardware)
    %   hardware = getHardware(obj)
    %
    
    properties (GetAccess = 'public', SetAccess = 'private') % public read access, but private write access.        
        data                    % The rep data
        imuData1                % The IMU1 data
        imuData2                % The IMU2 data
        date                    % Date and time when rep was collected
        sampleFreq              % Sampling frequency of data
        desc                    % String description of rep
        hardware                % Hardware used to collect the data
        
        availableChans
    end 

    methods 
        
        %% Constructor
        function obj = aceRep(sampleFreq, data, imuData1, imuData2, desc, hardware)       
            
            assert(nargin>0,'ACE:InvalidInputError','Invalid Input Parameters for Object aceRep');
            
            currentLength = size(imuData1,1);
            imuData = interp1(1:currentLength,[imuData1,imuData2],1:(currentLength-1)/(size(data,1)-1):currentLength);         
            
            data = [data imuData];
            
            if nargin>0
                obj.sampleFreq = sampleFreq;
            end
            if nargin>1
                obj.data = data;
            end
            
            if nargin>2
                obj.imuData1 = imuData1;
            end
            
            if nargin>3
                obj.imuData2 = imuData2;
            end
            
            if nargin>4
                obj.desc = desc;
            end
            
            if nargin>5
                obj.hardware = hardware;
            end
            obj.date = now;                        
        end
        
        %% Set Rep Data
        function obj = setData(obj, data)
            % Adds data to the rep class
            obj.data = data;
        end
        
        %% Get Rep Data
        function data = getData(obj)
            % Gets the data for the rep class
            data = obj.data;
        end
        
          %% Set Rep Desc
        function obj = setDesc(obj, desc)
            % Adds desc to the rep class
            obj.desc = desc;
        end
        
        %% Get Rep Desc
        function desc = getDesc(obj)
            % Gets the Desc for the rep class
            desc = obj.desc;
        end
        
        %% Get Data Length
        function dataLen = getDataLen(obj)
            dataLen = size(obj.data,1);
        end
        
        %% Get Num Channels
        function numChans = getNumChans(obj)
            numChans = size(obj.data,2);
        end
        
        
        %% Set Hardware
        function obj = setHardware(obj, hardware)
            obj.hardware = hardware;
        end
           
        %% Get Hardware
        function hardware = getHardware(obj)
            hardware = obj.hardware;
        end
        
    end % End Methods
    
end
