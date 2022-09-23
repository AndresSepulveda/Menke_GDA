% gda05_05
%
% examples of probability distributions

% grid
Nm1 = 51;
m1min = 0;
m1max = 5.0;
Dm1 = (m1max-m1min)/(Nm1-1);
m1 = m1min + Dm1*[0:Nm1-1]';

Nm2 = 51;
m2min = 0;
m2max = 5.0;
Dm2 = (m2max-m2min)/(Nm2-1);
m2 = m2min + Dm2*[0:Nm2-1]';

% dist 1
P1=zeros(Nm1,Nm2);
mbar1 = [2.5, 2.5]';
sd1 = 0.5;
C1 = diag( [sd1^2, sd1^2]' );
CI1 = inv(C1);
DC1 = det(C1);

% dist 2
P2=zeros(Nm1,Nm2);
mbar2 = [2.5, 2.5]';
sd2 = 1;
C2 = diag( [sd2^2, sd2^2]' );
CI2 = inv(C2);
DC2 = det(C2);

norm1 = (1/(2*pi)) * (1/sqrt(DC1));
norm2 = (1/(2*pi)) * (1/sqrt(DC2));
for i=[1:Nm1]
for j=[1:Nm2]
    x1 =[m1(i), m2(j)]' - mbar1;
    x2 =[m1(i), m2(j)]' - mbar2;
    P1(i,j) = norm1*exp( -0.5 * x1'*CI1* x1 );
    P2(i,j) = norm2*exp( -0.5 * x2'*CI2* x2 );
end
end

% for test purposes
% A1 = Dd1*Dd2*sum(sum(P1));
% A2 = Dd1*Dd2*sum(sum(P2));

gda_draw(' ', P1, ' ', ' ', P2 );





