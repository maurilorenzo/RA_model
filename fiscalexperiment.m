% exercise 6
% fiscal experiment 
% this script computes the fiscal revenues in the s.s. with different level
% of tax rate, the path to the s.s. under the regime that maximizes fiscal
% revenues.
% in the last part the outcomes under no intervention are compared with the
% ones under the regimes that maximizes fiscal revenues (GDP difference and
% consumption compensating variation)

% execute noint.m first


global T alpha beta delta theta time k1
T=100; % number of periods
time=1:1:T; % timeline

% production function
alpha=0.3; % cobb-douglass with CRS

% utility function
beta=1/1.04; % discount facor (=1/(1+rho), where rho is the subjective interest rate)
theta=0.6; % disutility of labor

% capital
delta=0.08; %depreciation rate

% tax scheme
% create vectors with different levels of tax rate
ths=0.01:0.01:0.999;
tks=0.01:0.01:0.999;

% create matrices to store results
kstars=zeros(length(ths),length(tks));
hstars=zeros(length(ths),length(tks));
fiscalrevs=zeros(length(ths),length(tks));

% for any value of th(tax rate on labor income) and tk(tax rate on capital
% rent) computes S.S. level of capital, labor and GDP
for h=1:length(ths)
    for k=1:length(tks)
        kstars(h,k)=SScapital(tks(k),ths(h));
        hstars(h,k)=labor(kstars(h,k),ths(h));
        fiscalrevs(h,k)=fiscalrevenues(kstars(h,k),hstars(h,k),tks(k),ths(h));
    end
end

% find tax scheme that maximizes fiscal revenues
maxrev=max(max(fiscalrevs));
[opttaxhposition, opttaxkposition]=find(fiscalrevs==maxrev);
opttaxh=ths(opttaxhposition);
opttaxk=tks(opttaxkposition);
display("the tax rates that maximize the government revenues are:")
display("labor income tax")
display(opttaxh)
display("capital rent tax")
display(opttaxk)
display("Government revenues")
display(maxrev)

% plot the 3D surface of fiscal revenues as a function of tk and th
figure(10)
surf(ths,tks,fiscalrevs)
hold on
plot3(opttaxk,opttaxh,maxrev,"ko")
hold off
xlabel("tk")
ylabel("th")
zlabel("fiscal revenues")
legend("revenues","max")


% compute the S.S. and the path under the regime that maximizes government
% revenues

% initial values
k1=kstar1; % starting point (= to the s.s. level undr the first regime th=0.25; tk=0.15)

% compute S.S. values
kstarmaxrev=SScapital(opttaxk,opttaxh);
hstarmaxrev=labor(kstarmaxrev,opttaxh);
GDPmaxrevstar=production(kstarmaxrev,hstarmaxrev);% GDP in the S.S.

display("Under the regimes that maximizes revenues, the Steady State levels are")
display("Capital, Labor & GDP")
display([kstarmaxrev hstarmaxrev GDPmaxrevstar])


% extended path method
% create a initial guess for the capital path
kguess=k1:(kstarmaxrev-k1)/(T-1):kstarmaxrev;

% set initial difference and counter
diff=1; % it must be greater than the tolerance
i=1;

% algorithm
while diff>tolerance && i<1000 % check converegnece
% revise guesses   
[krevised, hrevised] = extendedpath(kguess,kstarmaxrev,hstarmaxrev,opttaxh,opttaxk);

% uptdate difference
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
    kpathmaxrev=kguess;
    % labor path
    hpathmaxrev=hrevised;
    % GDP path
    outputpathmaxrev=production(kpathmaxrev,hpathmaxrev);
end

% compute consumption path
consumptionpathmaxrev=zeros(T,1);
for i=1:T-1
    consumptionpathmaxrev(i)=consumption(kpathmaxrev(i),hpathmaxrev(i),kpathmaxrev(i+1));
end
consumptionpathmaxrev(T)=consumption(kstarmaxrev,hstarmaxrev,kstarmaxrev); % consumption in the s.s. (period T)



figure(14)
plot(kpathmaxrev)
xlabel("t")
ylabel("K")
yline(kstarmaxrev);
legend("kpath","Steady State")
title("Capital max government revenues")

figure(15)
plot(hpathmaxrev)
xlabel("t")
ylabel("h")
yline(hstarmaxrev);
legend("hpath","Steady State")
title("Labor  max government revenues")

figure(16)
plot(consumptionpathmaxrev)
xlabel("t")
ylabel("c")
yline(consumptionpathmaxrev(T));
legend("cpath","Steady State")
title("Consumption max government revenues")

figure(17)
plot(time,outputpathmaxrev)
xlabel("t")
ylabel("y")
yline(GDPmaxrevstar);
legend("outputpath","Steady State")
title("Output max revenues")

% comparison between no intervention and max gov revenues
display("Reduction in GDP induced by rasing revenues")
display(GDPnointstar-GDPmaxrevstar)

% compute compensating vatiation
compvar2=compensatingvariation(kstarnoint,hstarnoint,kstarnoint,kstarmaxrev,hstarmaxrev,kstarmaxrev);
display("Compensating variation due to the reduction of welfare caused by the fiscal regime w.r.t. no intervention")
compvar2

% plot the 2 output paths
figure(18)
plot(outputpathnoint,"r")
hold on
plot(outputpathmaxrev,"b")
hold off
xlabel("t")
ylabel("Y")
legend("noint","maxrev")
title("Output path under the two regimes")
