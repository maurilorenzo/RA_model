function zero = FOCcapital(kt,ht,kt1,ht1,kt2,th,tk)
% this function represent the FOC w.r.t to capital (kt+1)
% kt capital in t kt1 capital in t+1 kt2 capital in t+2
% ht labor in t ht1 labor in t+1 ht2 labor in t+2

global alpha theta delta beta
wt=(1-alpha)*(kt/ht)^(alpha);
% hourly wage period t
rt=alpha*(ht/kt)^(1-alpha); 
% rent rate period t
lambdat=th*wt*ht+tk*(rt-delta)*kt;
% transfers period t
wt1=(1-alpha)*(kt1/ht1)^(alpha);
% hourly wage perio t+1
rt1=alpha*(ht1/kt1)^(1-alpha);
% rent rate period t+1
lambdat1=th*wt1*ht1+tk*(rt1-delta)*kt1;
% transfers period t
Ct=(1-th)*wt*ht+(1+(1-tk)*(rt-delta))*kt+lambdat-kt1; 
% consumtpion at period t
Ct1=(1-th)*wt1*ht1+(1+(1-tk)*(rt1-delta))*kt1+lambdat1-kt2;
% consumtpion at period t
Ct=max(Ct,0.000001);
% the consumption cannot be negative
Ct1=max(Ct1,0.000001); 
% the consumption cannot be negative

U1t=(max(Ct-1/(1+theta)*ht^(1+theta),0.00001))^-1; 
% marginal utility in period t (the max operator prevent the argument of 
% the marginal utility from being negative (log preferences--> log(x),x>0))
U1t1=(max(Ct1-1/(1+theta)*ht1^(1+theta),0.00001))^-1; 
% marginal utility in period t+1 (the max operator prevent the argument of 
% the marginal utility from being negative (log preferences--> log(x),x>0))

% foc w.r.t kt+1
zero=-U1t+beta*U1t1*(1+(1-tk)*(rt1-delta));
end


