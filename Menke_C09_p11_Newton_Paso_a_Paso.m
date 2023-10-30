% gda09_11
% Newton's method example
close all
clear all
% data are in a sinple auxillary variable, x
N=40;
xmin=0;
xmax=1.0;
Dx=(xmax-xmin)/(N-1);
x = Dx*[0:N-1]';

% true model parameters
M=2;
mt = [1.21, 1.54]';

% y=f(x, m1, m2);
w0=20;
dtrue = sin(w0*mt(1)*x) + mt(1)*mt(2);
sd=0.4;
dobs = dtrue + random('Normal',0,sd,N,1);

% plot data
figure(1);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [0, xmax, 0, 4 ] );
plot(x,dtrue,'k-','LineWidth',3);
plot(x,dobs,'ko','LineWidth',3);
xlabel('x');
ylabel('d');

% 2D grid, for plotting purposes only
L = 101;
Dm = 0.02;
m1min=0;
m2min=0;
m1a = m1min+Dm*[0:L-1]';
m2a = m2min+Dm*[0:L-1]';
m1max = m1a(L);
m2max = m2a(L);

% compute error, E, on grid for plotting purposed only
E = zeros(L,L);
for j = [1:L]
for k = [1:L]
    dpre = sin(w0*m1a(j)*x) + m1a(j)*m2a(k);
    E(j,k) = (dobs-dpre)'*(dobs-dpre);
end
end

figure(2);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [m2min, m2max, m1min, m1max] );
axis ij;
imagesc( [m2min, m2max], [m1min, m1max], E);
colorbar;
xlabel('m2');
ylabel('m1');
plot( mt(2), mt(1), 'go', 'LineWidth', 3 );

% Newton's method, calculate derivatives
% y = sin( w0 m1  x) + m1 m2;
% dy/dm1 = w0 x cos( w0 m1 x) + m2
% dy/dm2 = m1   !!! was m2

% initial guess and corresponding error
% mg=[1.2,0.5]';   % facil
mg=rand(2,1)*2
dg = sin(w0*mg(1)*x) + mg(1)*mg(2);
Eg = (dobs-dg)'*(dobs-dg);
plot( mg(2), mg(1), 'ko', 'LineWidth', 3 );
plot( mt(2), mt(1), 'go', 'LineWidth', 3 );
hold off
mt
mg

% save solution and minimum error as a function of iteration number
Niter=200;
Ehis=zeros(Niter+1,1);
m1his=zeros(Niter+1,1);
m2his=zeros(Niter+1,1);
Ehis(1)=Eg;
m1his(1)=mg(1);
m2his(1)=mg(2);

% iterate to improve initial guess
G = zeros(N,M);
pause
 figure(3)
for k = [1:Niter]
       hold on
    axis( [m2min, m2max, m1min, m1max] );
    axis ij;
    imagesc( [m2min, m2max], [m1min, m1max], E);
    colorbar;
    xlabel('m2'); 
    ylabel('m1');

    set(gca,'LineWidth',2);
    %imagesc( [m2min, m2max], [m1min, m1max], E);
    
    dg = sin( w0*mg(1)*x) + mg(1)*mg(2);
    dd = dobs-dg;
    Eg=dd'*dd;
    Ehis(k+1)=Eg;
    
    G = zeros(N,2);
    G(:,1) = w0 * x .* cos( w0 * mg(1) * x ) + mg(2);
    G(:,2) = mg(1)*ones(N,1);     %%% was m2
    
    % least squares solution
    dm = (G'*G)\(G'*dd);
    mgm1=mg;
    % update
    mg = mg+dm;
    hold on    
    plot( mgm1(2), mgm1(1), 'ro', 'LineWidth', 2 );
    plot( mg(2), mg(1), 'rx', 'LineWidth', 2 );
    plot( mt(2), mt(1), 'go', 'LineWidth', 3 );
%    a=[mgm1(2)-2*(abs(mgm1(2)-mg(2))), mgm1(2)+2*(abs(mgm1(2)-mg(2))), mgm1(1)-2*(abs(mgm1(1)-mg(1))), mgm1(1)+2*(abs(mgm1(1)-mg(1)))]
 %   axis( [mgm1(2)-2*(abs(mgm1(2)-mg(2))), mgm1(2)+2*(abs(mgm1(2)-mg(2))), mgm1(1)-2*(abs(mgm1(1)-mg(1))), mgm1(1)+2*(abs(mgm1(1)-mg(1)))] );
 %   axis ij;
 %   colorbar;
    m1his(k+1)=mg(1);
    m2his(k+1)=mg(2);
    for m = 2:k+1
        plot( [m2his(m-1), m2his(m) ], [m1his(m-1), m1his(m) ], 'r', 'LineWidth', 2 );
    end
    hold off
%    m2his(1+k-1), m2his(1+k), m1his(1+k-1), m1his(1+k) 
    mt
    mg
     pause

end
m1est = m1his(Niter+1);
m2est = m2his(Niter+1);

plot( mt(2), mt(1), 'go', 'LineWidth', 2 );
plot( mg(2), mg(1), 'ro', 'LineWidth', 2 );
    

figure(3);
clf;
subplot(3,1,1);
set(gca,'LineWidth',2);
hold on;
plot( [0:Niter], Ehis, 'k-*', 'LineWidth', 2 );
xlabel('iteration');
ylabel('E');
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
plot( [0, Niter], [mt(1), mt(1)], 'r', 'LineWidth', 2 );
plot( [0:Niter], m1his, 'k-*', 'LineWidth', 2 );
xlabel('iteration');
ylabel('m_1');
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
plot( [0, Niter], [mt(2), mt(2)], 'r', 'LineWidth', 2 );
plot( [0:Niter], m2his, 'k-*', 'LineWidth', 2 );
xlabel('iteration');
ylabel('m_2');
    
% evaluate prediction and plot it
figure(1);
dpre = sin(w0*m1est*x) + m1est*m2est;
plot(x,dpre,'r-','LineWidth',3);