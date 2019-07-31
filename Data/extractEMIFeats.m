
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extractTDFeats	Compute all time domain features
%       			and the mean features [Hudgins 1991]
%
% (c) Kevin Englehart, 1997
%
% Modified by Erik Scheme, 2006
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function feats = extractEMIFeats(DataSet,frameLen)

DEADZONE = 0.025;

Ntotal = size(DataSet,1);
Nsig = size(DataSet,2);
% DataSet = DataSet - ones(Ntotal,1)*mean(DataSet);
% DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));

% feats = zeros(4,Nsig);
feats = zeros(1,Nsig);

for SigNum = 1:Nsig
    clear mav turns zero_count len;
    zero_count = 0;
    len = 0;
    mav = 0;
    turns = 0;

    index = 1;
    range = index:index+frameLen-1;
    feats(:,SigNum) = mean(DataSet(range,SigNum));
    
%     mav = mean(abs(DataSet(range,SigNum)));
%     flag1 = 1;
%     flag2 = 1;
%     for i = 1:frameLen-2;
%         idx = index + i;
%         fst = DataSet(idx-1,SigNum);
%         mid = DataSet(idx,SigNum);
%         lst = DataSet(idx+1,SigNum);
% 
%         % Compute Zero Crossings
%         if ((mid>=0 && fst>=0) ||(mid<=0 && fst<=0))
%             flag1 = flag2;
%         elseif ((mid<DEADZONE) && (mid>-DEADZONE) && (fst<DEADZONE) && (fst>-DEADZONE))
%             flag1 = flag2;
%         else
%             flag1 = (-1)*flag2;
%         end
%         if (flag1~=flag2);
%             zero_count = zero_count + 1;
%             flag1 = flag2;
%         end
%         % Compute Turns (Slope Changes
%         if((mid>fst & mid>lst) | (mid<fst & mid<lst))
%             % turns threshold of 15mV (i.e. 3uV noise)
%             if (abs(mid-fst)>0.015) | (abs(mid-lst)>0.015)
%                 turns=turns+1;
%             end
%         end
%         % Compute Waveform Length
%         len = len + abs(fst-mid);
%     end
%        
    % Scale the feats to normalize for the neural network
%     len = len/frameLen;
%     turns = turns/frameLen;
%     zero_count = zero_count/frameLen;
%     feats(:,SigNum) = [mav len zero_count turns]';

end

