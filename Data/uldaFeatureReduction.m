% ULDA_FEATURE_REDUCTION Feature reduction using uncorrelated linear
% discriminant analysis
%
% function [inFeats_pca,feature_test_pca] 
%   = ulda_feature_reduction(inFeats,numFeats,target,feature_test)
%
% Author Adrian Chan
%
% Performs feature reduction using uncorrelated linear discriminant
% analysis (ULDA).
%
% Reference J. Ye, R. Janardan, Q. Li, H. Park, "Feature extraction via
% generalized uncorrelated linear discriminant analysis", Proceedings of
% thte 21st International Conference on Machine Learning, Banff, Canada,
% 2004.
%
% Requires ULDA.m file from http://www-users.cs.umn.edu/~jieping/uLDA/
%
% Inputs
%    inFeats: input matrix of training features
%                   (rows: examplars, columns: features)
%    numFeats: number of features to reduce to (default inf; i.e. keep as
%               many features as possible)
%    target: column vector of training classes
%
% Outputs
%    uldaFeats: output matrix of training features
%    feature_test_ulda: output matrix of testing features
%
% Modifications
% 06/10/04 AC First created.
% 09/05/07 ES Modified for use in ACE
%

function [uldaFeats,G] = uldaFeatureReduction(inFeats,numFeats,target)

tmpClasses = unique(target);
targets = zeros(1,length(target));
for i=1:length(target)
    targets(i) = find(tmpClasses==target(i));
end

G = ulda(inFeats, targets');
uldaFeats = (inFeats*G);

if isempty(numFeats)
    numFeats = inf;
end

numFeats = min(numFeats,size(uldaFeats,2));
uldaFeats = uldaFeats(:,1:numFeats);
G = G(:,1:numFeats);

