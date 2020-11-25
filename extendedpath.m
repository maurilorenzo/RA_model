function [knew hnew]= extendedpath(kguess,kstar,hstar,th,tk)

global T k1 

% create matrixes to store results in
knew=zeros(T,1);
knew(1,1)=k1; % initial value of capital 
knew(T,1)=kstar; % s.s. value
hnew=zeros(T,1);
hnew(1,1)=labor(k1,th);% initial value of labor (consistent with the new tax rate th)
hnew(T,1)=hstar; % s.s. value

for j=2:T-1
    guesssol=kguess(j) ;
    sol=fzero(@(kt1) FOCs(knew(j-1,1),hnew(j-1,1),kt1,kguess(j+1),th,tk),guesssol);
    % solution for the capital in period j
    knew(j,1)=sol;
    % solution for labor in period j
    hnew(j,1)=labor(sol,th);
end

end

 