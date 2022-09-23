% gds08_02
% comparizon of L1 and L2 error in estimating the mean of data

figure(1);
clf;

% this is a one-dimensional grid search
% define limits of m, the mean of the data
M=1001;
mmin = 0;
mmax = 2;
Dm = (mmax-mmin)/(M-1);
m = mmin + Dm*[0:M-1]';

% randomly generate the data
N=12;
d = random('Uniform', mmin, mmax, N, 1 );

% L1 norm with even number of data
E1 = zeros(M,1);
for i=[1:M]
    e=d-(m(i)*ones(N,1));
    E1(i)=sum(abs(e));
end
id = floor((d-mmin)/Dm)+1;

subplot(1,3,1)
set(gca, 'LineWidth', 2);
hold on;
mminp=0.5;
mmaxp=1.5;
axis( [mminp, mmaxp, 0, 10] );
plot(m, E1, 'r-', 'LineWidth', 3 );
plot(m(id), E1(id), 'ko', 'LineWidth', 3 );
xlabel('m');
ylabel('E(m)');

% L1 norm with odd number of data, using the
% same data as previously, except omitting last point
N=N-1;
d = d(1:N);
E2 = zeros(M,1);
for i=[1:M]
    e=d-(m(i)*ones(N,1));
    E2(i)=sum(abs(e));
end
id = floor((d-mmin)/Dm)+1;

subplot(1,3,2)
set(gca, 'LineWidth', 2);
hold on;
mminp=0.5;
mmaxp=1.5;
axis( [mminp, mmaxp, 0, 10] );
plot(m, E2, 'r-', 'LineWidth', 3 );
plot(m(id), E2(id), 'ko', 'LineWidth', 3 );
xlabel('m');
ylabel('E(m)');

% L2 norm
E3 = zeros(M,1);
for i=[1:M]
    e=d-(m(i)*ones(N,1));
    E3(i)=sqrt(sum(e.^2));
end
id = floor((d-mmin)/Dm)+1;

subplot(1,3,3)
set(gca, 'LineWidth', 2);
hold on;
mminp=0.5;
mmaxp=1.5;
axis( [mminp, mmaxp, 0, 10] );
plot(m, E3, 'r-', 'LineWidth', 3 );
plot(m(id), E3(id), 'ko', 'LineWidth', 3 );
xlabel('m');
ylabel('sqrt E(m)');



