function Ut = utility(kt,ht,kt1)
% this function computes the infraperiod utility
global  theta delta 
Ct=production(kt,ht)+(1-delta)*kt-kt1;
% consumption

Ct=max(Ct,0.000001);
% the consumption cannot be negative

Gt=ht^(1+theta)/(1+theta);
% disutility of labor in term of consumption

% utility (log preferences)
Ut=log(max(Ct-Gt,0.0001)); % max operator prevent the argument of log from being negative
end

