function v = compensatingvariation(kta,hta,kt1a,ktb,htb,kt1b)
% this function computes the compensating variation between two fiscal
% regimes (a and b)
% kta capital time t hta labor time t kt1a capital time t+1 REGIME A
% ktb capital time t htb labor time t kt1b capital time t+1 REGIME B
global theta delta
Ua=utility(kta,hta,kt1a); % utility under regime a
Gb=htb^(1+theta) / (1+theta); % disutility of labor in term of consumption under regime b
Cb=production(ktb,htb)+(1-delta)*ktb-kt1b; % consumption under regime b
Cb=max(Cb,0.000001); % the consumption cannot be negative
v=(exp(Ua)+Gb)/Cb-1; % compensating variation
end

