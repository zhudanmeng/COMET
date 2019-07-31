function classifier = trainClassifier(classifier,userInfo,classifierType,trainFeats,trainTargets)

settings = userInfo.settings;
activeClasses = classifier.classNumbers;

disp(['Training Classifier: ' classifierType]);
switch classifierType
    
%% GMM Classifier
    case 'GMM'
        try
            [uldaFeats,gULDA] = uldaFeatureReduction(trainFeats',inf,trainTargets);
            classifier.gULDA = gULDA;
            classifier.classList = activeClasses(trainTargets);
        catch
            errordlg({'Unable to extract valid features for cluster plot.',' ','Please check data integrity.'},'Data Error','modal');
            classifier.gULDA = [];
            classifier.trainFeats = [];
            classifier.classList = [];
        end
        input_dim_d = size(uldaFeats,2); %%the dimension of the training data after ULDA. with the max dimension
        
        for i = 1:length(activeClasses)
            temp = []; temp2 = [];
            temp2 = uldaFeats(trainTargets == i,:); %compare the classification result.
            ncentres=1;
            mix_d = gmm(input_dim_d,ncentres,'full');
            options = foptions;
            options(14) = 5;	% Just use 5 iterations of k-means in initialisation
            % Initialise the model parameters from the trdata{classind}
            mix_d = gmminit(mix_d,temp2,options); %trained gaussian coeffients for feature with all the dimension
            % plot out the model
            options = zeros(1,18);
            options(1)  = 0;		% Prints out error values.
            options(14) = 8;		% Number of iterations.
            [mix_d, options, errlog] = gmmem(mix_d, temp2, options);
            mix_d2(activeClasses(i)) = mix_d;
            
            for itrue = 1:length(temp2)
                prob_d(itrue,:) = gmmprob(mix_d,temp2(itrue,:));
            end
            classifier.max(activeClasses(i)) = max(prob_d);
            Prob(activeClasses(i)).prob_d = log10(prob_d)./log(max(prob_d));
        end
        
        classifier.mix_d = mix_d2;
        classifier.trainFeats = uldaFeats';
        classifier.Prob = Prob;
        % Test the training data to get confidence estimation region
        for isample = 1:length(uldaFeats)
            for iclass = 1:length(activeClasses)
                test_train.prob(isample,iclass) = gmmprob(classifier.mix_d(activeClasses(iclass)),uldaFeats(isample,:));
            end
            temp2 = test_train.prob(isample,:);
            temp2(temp2==0) = [];
            temp2 = min(temp2);
            test_train.prob(isample,test_train.prob(isample,:)==0) = temp2;
            
        end
        
        test_train.norm = log10(test_train.prob)./log10(ones(size(test_train.prob,1),1)*max(test_train.prob,[],1));
        test_train.con = exp(test_train.norm - max(test_train.norm,[],2)*ones(1,size(test_train.norm,2)));
        test_train.con = test_train.con./(sum(test_train.con,2)*ones(1,size(test_train.con,2)));
        for iclass = 1:length(activeClasses)
            classifier.meanconfidence(iclass) = mean(test_train.con(trainTargets == iclass,iclass));
            classifier.minconfidence(iclass) = min(test_train.con(trainTargets == iclass,iclass));
            classifier.maxconfidence(iclass) = max(test_train.con(trainTargets == iclass,iclass));
            classifier.stdconfidence(iclass) = std(test_train.con(trainTargets == iclass,iclass));
        end
        classifier.con = test_train.con;
        classifier.thresh = classifier.meanconfidence - 2*classifier.stdconfidence;
        
%% MBC Classifier
    case 'MBC'
        waitHandle = waitbar(0,'Training Classifiers...');
        
        for iClass=1:length(activeClasses)
            waitbar((iClass-1)/length(activeClasses),waitHandle,['Training Classifiers for Class ' num2str(iClass) '...']);
            
            enframedClass = zeros(size(trainTargets));
            enframedClass(trainTargets==iClass) = 1;
            enframedClass(trainTargets~=iClass) = 2;
            
            try
                [uldaFeats,gULDA] = uldaFeatureReduction(trainFeats',1,enframedClass');
                classifier.gULDA{iClass} = gULDA;
            catch
                errordlg({'Unable to extract valid ulda features',' ','Please check data integrity.'},'Data Error','modal');
                classifier.gULDA{iClass} = [];
            end
            
            if mean(uldaFeats(enframedClass == 2)) < mean(uldaFeats(enframedClass == 1))
                classifier.trainFeats{iClass} = uldaFeats;
                classifier.featFlip(iClass) = 1;
            else
                classifier.trainFeats{iClass} = -1*uldaFeats;
                classifier.featFlip(iClass) = -1;
            end
            
            classifier.trainTargets{iClass} = enframedClass;
            
            activeFeats = classifier.trainFeats{iClass}(classifier.trainTargets{iClass} == 1);
            inactiveFeats = classifier.trainFeats{iClass}(classifier.trainTargets{iClass} == 2);
            
            if max(inactiveFeats) < min(activeFeats)
                curThresh = mean([max(inactiveFeats) min(activeFeats)]);
            else
                tmp = sort(classifier.trainFeats{iClass});
                for i = 1:length(classifier.trainFeats{iClass})
                    err(i) = sum(activeFeats < tmp(i)) + sum(inactiveFeats > tmp(i));
                end
                [minErr errIdx] = min(err);
                curThresh = tmp(errIdx);
            end
            classifier.thresh(iClass) = curThresh;
        end
        try close(waitHandle); catch end       
        
%% Neural Network Classifier        
    case 'NN'
        
        % extract the parameter value that necessary in NN training
        num_layer = classifier.params.numLayers; 
        act_func = classifier.params.actFunction;
        num_neuron = classifier.params.numNeurons;
                
        try
            [uldaFeats,gULDA] = uldaFeatureReduction(trainFeats',inf,trainTargets);
            classifier.gULDA = gULDA;
            classifier.classList = activeClasses(trainTargets);
        catch
            errordlg({'Unable to extract valid features for cluster plot.',' ','Please check data integrity.'},'Data Error','modal');
            classifier.gULDA = [];
            classifier.trainFeats = [];
            classifier.classList = [];
        end
        [classifier.net,classifier.val_err] = trainNN(uldaFeats,trainTargets,num_layer,act_func,num_neuron);

        try close(gcf);
        catch 
        end
        
%% Multi-Class SVM Classifier
    case 'SVM'

        [osu_svm.AlphaY, osu_svm.SVs, osu_svm.Bias, osu_svm.Parameters, osu_svm.nSV, osu_svm.nLabel] = u_RbfSVC(trainFeats, trainTargets',2);
        % [osu_svm.AlphaY, osu_svm.SVs, osu_svm.Bias, osu_svm.Parameters, osu_svm.nSV, osu_svm.nLabel] = u_LinearSVC(trainFeats, trainTargets,1);
        % [osu_svm.AlphaY, osu_svm.SVs, osu_svm.Bias, osu_svm.Parameters, osu_svm.nSV, osu_svm.nLabel] = u_PolySVC(trainFeats, trainTargets,1);
        
        classifier.osu_svm = osu_svm;


%% One-Against-One Classifier
    case 'OVO'
        waitHandle = waitbar(0,'Training Classifier...');
        stdThreshMatrix = zeros(length(activeClasses),length(activeClasses));
        for iClass=1:length(activeClasses)
            waitbar((iClass-1)/length(activeClasses),waitHandle,['Training Classifiers for Class ' num2str(iClass) '...']);
            for jClass = iClass+1:length(activeClasses)
                
                i_ind = find(trainTargets==iClass);
                j_ind = find(trainTargets==jClass);
                nvnFeats = [trainFeats(:,i_ind) trainFeats(:,j_ind)];
                nvnTargets = [ones(1,length(i_ind)) repmat(2,1,length(j_ind))];
                
                try
                    [uldaFeats,gULDA] = uldaFeatureReduction(nvnFeats',1,nvnTargets');
                    classifier.gULDA{iClass,jClass} = gULDA;
                catch
                    errordlg({'Unable to extract valid ulda features',' ','Please check data integrity.'},'Data Error','modal');
                    classifier.gULDA{iClass} = [];
                end
                
                if mean(uldaFeats(nvnTargets == 2)) < mean(uldaFeats(nvnTargets == 1))
                    classifier.featFlip(iClass,jClass) = 1;
                else
                    uldaFeats = -1*uldaFeats;
                    classifier.featFlip(iClass,jClass) = -1;
                end
                
                iFeats = uldaFeats(nvnTargets == 1);
                jFeats = uldaFeats(nvnTargets == 2);
                
                %% Remove Outliers
                iTmp = iFeats - mean(iFeats);
                [iSort iIdx] = sort(abs(iTmp));
                iFeats = iFeats(iIdx(1:floor(0.99*length(iFeats))));
                
                jTmp = jFeats - mean(jFeats);
                [jSort jIdx] = sort(abs(jTmp));
                jFeats = jFeats(jIdx(1:floor(0.99*length(jFeats))));
                
                classifier.stats(iClass,jClass).iMean = mean(iFeats);
                classifier.stats(iClass,jClass).iStd = std(iFeats);
                classifier.stats(iClass,jClass).jMean = mean(jFeats);
                classifier.stats(iClass,jClass).jStd = std(jFeats);
                
                try
                    iFeats = uldaFeats(nvnTargets == 1);
                    iStds = abs(iFeats - classifier.stats(iClass,jClass).iMean)/classifier.stats(iClass,jClass).iStd;
                    stdThreshMatrix(iClass,jClass) = min(max(3,max(iStds)),4.5);
%                      stdThreshMatrix(iClass,jClass) = max(3,max(iStds));
                    
                    jFeats = uldaFeats(nvnTargets == 2);
                    jStds = abs(jFeats - classifier.stats(iClass,jClass).jMean)/classifier.stats(iClass,jClass).jStd;
                    stdThreshMatrix(jClass,iClass) = min(max(3,max(jStds)),4.5);
%                     stdThreshMatrix(jClass,iClass) = max(3,max(jStds));
                catch
                end
            end
        end
        classifier.stdThreshMatrix = stdThreshMatrix;
        
        
    otherwise
        error('Invalid Classifier Type Specified');
end

classifier.classifierType = classifierType;
classifier.featType = settings.featType;
classifier.arOrder = settings.arOrder;
classifier.frameLen = settings.frameLen;
classifier.sampleFreq = settings.sampleFreq;
try classifier.enableULDA = settings.ULDA; catch end

try close(waitHandle); catch end
