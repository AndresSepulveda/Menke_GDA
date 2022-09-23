% gda06_01
%
% upper/lower bounds on localized average using linear programming

clear all;

% data equation: mean of d
M=21; % must be odd
N=1;
mtrue = random('Uniform',-1,1,M,1);
mtrue = mtrue - mean(mtrue);
G=ones(N,M)/M;
dtrue=G*mtrue;
dobs=dtrue;

% upper bound: mi <= 1
ub = ones(M,1);

% lower bound: mi >= -1
lb = -ones(M,1);

M2 = floor(M/2)+1;
L=0; % counter
for i=[0:floor(M/2)]
    L=L+1;
    % averageing vector centered at N/2 of width 2*i+1
    f = zeros(M,1);
    f(M2-i:M2+i) = 1;
    I(L)=sum(f);
    f=f/I(L);
    [mest1, fmin(L)] = linprog(  f, [], [], G, dobs, lb, ub );
    [mest2, fmax(L)] = linprog( -f, [], [], G, dobs, lb, ub ); 
end

figure(1);
set(gca,'LineWidth',2);
hold on;
axis( [1, M, 0, 1.5] );
plot(I,-fmax, 'k-', 'LineWidth', 2);
plot(I,-fmax, 'ko', 'LineWidth', 4);
xlabel('width');
ylabel('bound on |<m>|');




