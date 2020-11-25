function zero = FOCs(kt,ht,kt1,kt2,th,tk)
% this function is used in the extended path method algorithm
% given the value of kt and ht and a guess dor kt+2, it computes the value
% of kt+1 and ht+1
% th and tk are tax rates on labor income and rental income
% DECISION RULE

% labor formula from FOC w.r.t. to labor
ht1=labor(kt1,th);
% FOC w.r.t. kt+1
zero=FOCcapital(kt,ht,kt1,ht1,kt2,th,tk);

end

