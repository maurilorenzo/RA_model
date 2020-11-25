function kss = SScapital(tk,th)
% this function computes the steady state level of capital given the tax
% rates tk (on capital rent income) and th (on labor income)
global alpha delta theta beta

kss=((1+beta*delta*(1-tk)-beta)/(beta*(1-tk)*alpha))^((alpha+theta)/(theta*(alpha-1)))*((1-th)*(1-alpha))^(1/theta);

end

