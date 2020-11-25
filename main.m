% main.m
% this m.file computes the dynamic path of a system convering into a steady
% state
clear all
clc

% parameterization
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
% tax scheme (initial regime)
th1=0.25; % tax rate on labor income
tk1=0.15; % tax rate on rental income from capital

% steady state
kstar1=SScapital(tk1,th1); % S.S level of capital
hstar1=labor(kstar1,th1); % S.S level of labor
GDP1star=production(kstar1,hstar1);% GDP in the s.s

% compute fiscal revenues in the s.s
fiscalrev1=fiscalrevenues(kstar1,hstar1,tk1,th1);

display("When the tax rate on labor income is .25 and the tax rate on rental income from capital is .15, the Steady State levels are")
display("Capital, Labor & GDP")
display([kstar1 hstar1 GDP1star])

% new tax lavel
th2=0.30;
tk2=0.30;

% new steady state
kstar2=SScapital(tk2,th2);
hstar2=labor(kstar2,th2);
GDP2star=production(kstar2,hstar2);% GDP in the s.s

% compute fiscal revenues in the s.s
fiscalrev2=fiscalrevenues(kstar2,hstar2,tk2,th2);
% compute percentage increase in fiscal revenues w.r.t regime 1
frincrease=fiscalrev2/fiscalrev1-1;

display("When the tax rate on labor income is .30 and the tax rate on rental income from capital is .30, the Steady State levels are")
display("Capital, Labor & GDP")
display([kstar2 hstar2 GDP2star])

display("this regime has increased fiscal revenues (percentage increase) by")
display(frincrease)

% initial value
k1=kstar1; % capital in t=1 (= to its s.s. level under the old regime th=0.25;tk=0.15)

% extended path method
% create a initial guess for the capital path
kguess=k1:(kstar2-k1)/(T-1):kstar2;

% set initial difference, tolerance and counter
diff=1; % it must be greater than the tolerance
tolerance=10^-5;
i=1;

% algorithm
while diff>tolerance && i<1000 % check converegnece
% revise guesses   
[krevised hrevised] = extendedpath(kguess,kstar2,hstar2,th2,tk2);
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
    kpath=kguess;
    % labor path
    hpath=hrevised;
    % GDP path
    outputpath=production(kpath,hpath);
end

% compute consumption path
consumptionpath=zeros(T,1);
for i=1:T-1
    consumptionpath(i)=consumption(kpath(i),hpath(i),kpath(i+1));
end
consumptionpath(T)=consumption(kstar2,hstar2,kstar2); % consumption in the s.s. (period T)

figure(1)
plot(kpath)
xlabel("t")
ylabel("K")
yline(kstar2);
legend("kpath","Steady State")
title("Path of capital with the extended path method")

figure(2)
plot(hpath)
xlabel("t")
ylabel("h")
yline(hstar2);
legend("hpath","Steady State")
title("Path of labor with the extended path method")

figure(3)
plot(consumptionpath)
xlabel("t")
ylabel("c")
yline(consumptionpath(T));
legend("cpath","Steady State")
title("Path of consumption with the extended path method")

figure(4)
plot(time,outputpath)
xlabel("t")
ylabel("y")
yline(GDP2star);
legend("outputpath","Steady State")
title("Path of output with the extended path method")


% Congresswoman H.K.Ink proposal
% alternative fiscal regime
th3=.315;
tk3=0;

% steady state under this regime
kstar3=SScapital(tk3,th3);
hstar3=labor(kstar3,th3);
GDP3star=production(kstar3,hstar3);% GDP in the S.S.

% compute fiscal revenues in the s.s
fiscalrev3=fiscalrevenues(kstar3,hstar3,tk3,th3);
% compute percentage increase in fiscal revenues w.r.t regime 1
frincreasealternative=fiscalrev3/fiscalrev1-1;

display("When the tax rate on labor income is .315 and the tax rate on rental income from capital is 0, the Steady State levels are")
display("Capital, Labor & GDP")
display([kstar3 hstar3 GDP3star])

display("the alternative regime would increased fiscal revenues (percentage increase) w.r.t to the 1st regime by")
display(frincreasealternative)


% extended path method
% create a initial guess for the capital path
kguess=k1:(kstar3-k1)/(T-1):kstar3;

% set initial difference, tolerance and counter
diff=1; % it must be greater than the tolerance
i=1;

% algorithm
while diff>tolerance && i<1000 % check converegnece
% revise guesses   
[krevised hrevised] = extendedpath(kguess,kstar3,hstar3,th3,tk3);

% uptade difference
diff=norm(krevised-kguess);
% update the guess and the counter
kguess=krevised;
i=i+1;
end

if i>=1000
    display("max number of iterations hit. Convergence issues!!!")
else
    display("the algorithm for the alternative proposal converged in ")
    display(i-1)
    display("iterations")
    % capital path
    kpathalternative=kguess;
    % labor path
    hpathalternative=hrevised;
    % GDP path
    outputpathalternative=production(kpathalternative,hpathalternative);

end
% compute consumption path
consumptionpathalternative=zeros(T,1);
for i=1:T-1
    consumptionpathalternative(i)=consumption(kpathalternative(i),hpathalternative(i),kpathalternative(i+1));
end
consumptionpathalternative(T)=consumption(kstar3,hstar3,kstar3); % consumption in the s.s. (period T


figure(5)
plot(kpathalternative)
xlabel("t")
ylabel("K")
yline(kstar3);
legend("kpath","Steady State")
title("Path of capital  (under Congresswoman T.H. INK proposal)")

figure(6)
plot(hpathalternative)
xlabel("t")
ylabel("h")
yline(hstar3);
legend("hpath","Steady State")
title("Path of labor (under Congresswoman T.H. INK proposal)")

figure(7)
plot(consumptionpathalternative)
xlabel("t")
ylabel("c")
yline(consumptionpathalternative(T));
legend("cpath","Steady State")
title("Path of consumption (under Congresswoman T.H. INK proposal)" )

figure(8)
plot(outputpathalternative)
xlabel("t")
ylabel("y")
yline(GDP3star);
legend("outputpath","Steady State")
title("Path of output (under Congresswoman T.H. INK proposal)")

% compensating variation between the steady states of the two regime
compvar=compensatingvariation(kstar2,hstar2,kstar2,kstar3,hstar3,kstar3);
% if compvar is > 0 the welfare decreses under the the congresswoman's
% proposal because the RA must be compensated to be indifferent between the
% 2 regime
% if compvar<0 the welfare increases under the the congresswoman's
% proposal

% who is right? The President or the Congresswoman?
if GDP3star >= GDP2star && compvar <=0
    display("the Congresswoman proposal is better")
    display("both GDP and welfare increase under the alternative regime")
elseif GDP3star>GDP2star 
    display("the alternative proposal increases GDP but decreases wealfare")
else
    %  GDP2star>GDP3star && compvar>0
    display("the President is right")
    display("both GDP and welfare decrease under the alternative regime proposed by the Congresswoman")
end

% equivalent variation of compsumption that leaves the individual
% indefferen betweeen the current regime (th=tk=0.3) and the regime
% suggested by the congresswoman (tk=0 and th=0.315)
equivalentvariation=compensatingvariation(kstar3,hstar3,kstar3,kstar2,hstar2,kstar2);    

% stimulus to GDP in the S.S. of the proposal 
if GDP3star >= GDP2star 
   display("the alternative proposal would increse the S.S level of GDP by")
   display(GDP3star-GDP2star)
else
    display("the alternative proposal would decrease the S.S level of GDP by")
    display(GDP2star-GDP3star)
end

if utility(kstar2,hstar2,kstar2)<utility(kstar3,hstar3,kstar3)
    display("percentage consume compesation required to make the individual indifferent")
    display(equivalentvariation)
end

% compute the life time (T periods) discounted utility
utility2=0;
utility3=0;
% add discounted utility from period 1 to period T-1
for t=1:T-1
    utility2=utility2+beta^(t-1)*utility(kpath(t),hpath(t),kpath(t+1));
    utility3=utility3+beta^(t-1)*utility(kpathalternative(t),hpathalternative(t),kpathalternative(t+1));
end
% add last period discounted utility
utility2=utility2+beta^(T-1)*utility(kpath(T),hpath(T),kstar2);
utility3=utility3+beta^(T-1)*utility(kpathalternative(T),hpathalternative(T),kstar3);

% comparison
if utility3>utility2
    display("the lifetime utility is greater under the alternative proposal")
elseif utility3<utility2
 display("the lifetime utility is greater under the current regime")
else
    display("the lifetime utility is equal under the two regimes")
end

display("ATTENTION! as the utility function is ordinal and not cardinal, the size of the difference has no economic meaning!!!")

% plot the two different output paths
figure(9)
plot(outputpath)
hold on
plot(outputpathalternative)
hold off
xlabel("t")
ylabel("Y")
legend("President","Congresswoman")
title("Output under the two proposals")