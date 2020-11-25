function c = consumption(k,h,k1)
% this function computes comsumption when all the fiscal revenues are
% rebated back through transfers
% k and h current level of capital and labor, k1 is the future level of
% capital 
global delta
y=production(k,h); % production in the economy
c=y+(1-delta)*k-k1;% consumption
end

