function y = production(k,h)
% this function computes the production of the economy
% cobb-douglass function with CRS (alpha=0.3)
global alpha
y=k.^alpha .* h.^(1-alpha);
end

