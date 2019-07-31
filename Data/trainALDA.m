%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Train an adaptive LDA	
%
%	Inputs: data,       			- Training data arranged in columns
%			target                  - Target classes arranged in columns 
%                                    (assumes targets are in range 1:nClasses)
%	Outputs: alda.dataMean          - Mean of data
%            alda.covMat            - Covariance matrix
%            alda.Wg,Cg 			- LDA weights 
%            alda.numPat            - Number of patterns of each class
%            alda.dataSTD           - Standard deviation of data
%
% (c) Levi Hargrove,2007
% Based on LDA.m written by Kevin Englehart, 1997
% Modified for use in ACE by Erik Scheme, 2007
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function alda = trainALDA(data,target)

try
    nFeats = size(data,1);
    sc = std(data(:));
%     data =  data + sc./1000.*randn(size(data));

    %nClasses = max(target);
    unqClasses = unique(target);
    nClasses = length(unqClasses);
    

    %%-- Compute the means and the pooled covariance matrix --%%
    C = zeros(nFeats,nFeats);
    numPat = zeros(1,nClasses);
    covMat = cell(1,nClasses);
    dataSTD = zeros(nFeats,nClasses);
    dataMean = zeros(nFeats,nClasses);

    for iClass = 1:nClasses
        idx = find(target==unqClasses(iClass));
        numPat(iClass) = length(idx);
        dataMean(:,iClass) = mean(data(:,idx),2)';
        dataSTD(:,iClass) = std((data(:,idx)-dataMean(:,iClass)*ones(1,length(idx))),[],2)';
        covMat{iClass} = cov((data(:,idx)-dataMean(:,iClass)*ones(1,length(idx)))');
        C = C + covMat{iClass};
    end

    C = C./nClasses;
    Pphi = 1/nClasses;
%     Cinv = inv(C);
    Cinv = C\eye(nFeats);

    %% -- Compute the LDA weights --%%
%     Wg = zeros(nFeats,nClasses);
%     Cg = zeros(1,nClasses);

%     for iClass = 1:nClasses
%         Wg(:,iClass) = Cinv*dataMean(:,iClass);
%         Cg(:,iClass) = -1/2*dataMean(:,iClass)'*Cinv*dataMean(:,iClass) + log(Pphi)';
%     end
    Wg = Cinv*dataMean;
    Cg = -1/2*dot(dataMean,Wg) + log(Pphi);

    alda.dataMean = dataMean;
    alda.dataSTD = dataSTD;
    alda.covMat = covMat;
    alda.numPat = numPat;
    alda.W = Wg;
    alda.C = Cg;
    alda.Cinv = Cinv;
catch
    errordlg(['Error training ALDA: ' lasterr],'ACE Error','modal');
    alda.dataMean = [];
    alda.dataSTD = [];
    alda.covMat = [];
    alda.numPat = [];
    alda.W = [];
    alda.C = [];
end
