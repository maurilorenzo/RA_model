function h = labor(k,th)
% this function computes the labor effort given the level of capital
% formula derived from the F.O.C. w.r.t labor
global alpha theta
%labor
h=(k.^alpha *(1-alpha)*(1-th)).^(1/(theta+alpha));
end

