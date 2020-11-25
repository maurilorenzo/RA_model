function T = fiscalrevenues(k,h,tk,th)
% this function computes fiscal revenues
global alpha delta
T=th*h.*(1-alpha)*k.^alpha.*h.^(-alpha)+tk.*(alpha*h.^(1-alpha)*k.^(alpha-1)-delta).*k;
end

