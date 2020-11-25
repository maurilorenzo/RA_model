% exercise 6
% this script compute the S.S. and the path under no public intervention 
% (th=tk=0)

global T alpha beta delta theta k1 time
T=100; % number of periods
time=1:1:T; % timeline
% production function
alpha=0.3; % cobb-douglass with CRS
% utility function
beta=1/1.04; % discount facor (=1/(1+rho), where rho is the subjective interest rate)
theta=0.6; % disutility of labor
% capital
delta=0.08; %depreciation rate
% tax scheme (no intervention)
thnoint=0;
tknoint=0;
% initial values
k1=kstar1; % capital in t=1 assumed = to the steady state of the first regime

% compute S.S. values
kstarnoint=SScapital(tknoint,thnoint);
hstarnoint=labor(kstarnoint,thnoint);
GDPnointstar=production(kstarnoint,hstarnoint);% GDP in the S.S.

display("With no intervention, the Steady State levels are")
display("Capital, Labor & GDP")
display([kstarnoint hstarnoint GDPnointstar])

% extended path method
% create a initial guess for the capital path
kguess=k1:(kstarnoint-k1)/(T-1):kstarnoint;

% set initial difference and counter
diff=1; % it must be greater than the tolerance
i=1;

% algorithm
while diff>tolerance && i<1000 % check converegnece
% revise guesses   
[krevised,  hrevised]= extendedpath(kguess,kstarnoint,hstarnoint,thnoint,tknoint);

% uptade difference
diff=norm(krevised-kguess);
% update the guess and the counter
kguess=krevised;
i=i+1;
end

if i>=1000
    display("max number of iterations hit. Convergence issues!!!")
else
    display("the algorithm converged in ")
    display(i-1)
    display("iterations")
    % capital path
    kpathnoint=kguess;
    % labor path
    hpathnoint=hrevised;
    % GDP path
    outputpathnoint=production(kpathnoint,hpathnoint);

end

% compute consumption path
consumptionpathnoint=zeros(T,1);
for i=1:T-1
    consumptionpathnoint(i)=consumption(kpathnoint(i),hpathnoint(i),kpathnoint(i+1));
end
consumptionpathnoint(T)=consumption(kstarnoint,hstarnoint,kstarnoint); % consumption in the s.s. (period T)


figure(10)
plot(kpathnoint)
xlabel("t")
ylabel("K")
yline(kstarnoint);
legend("kpath","Steady State")
title("Capital no intervention")

figure(11)
plot(hpathnoint)
xlabel("t")
ylabel("h")
yline(hstarnoint);
legend("hpath","Steady State")
title("Labor no intervention")

figure(12)
plot(consumptionpathnoint)
xlabel("t")
ylabel("c")
yline(consumptionpathnoint(T));
legend("cpath","Steady State")
title("Consumption no intervention")

figure(13)
plot(time,outputpathnoint)
xlabel("t")
ylabel("y")
yline(GDPnointstar);
legend("outputpath","Steady State")
title("Output no intervention")
