stats = [];
statIdx = 1;

for iNumPos = 1 : 4 %5
    for iUser = 1 : 11 %10           
       stats(statIdx,:) = [lili(iUser,iNumPos),iUser,iNumPos];%,iClassifier*11+iFeat]; 
       statIdx = statIdx + 1;
    end
end
            
%do the multi-way ANOVA

figure
[p,tbl,statss] = anovan(stats(:,1),{stats(:,3) },...
    'display','off','model',2,'varnames',{'numClassifiers'});
[c,m,h] = multcompare(statss);