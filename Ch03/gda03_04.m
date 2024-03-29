% gda03_04
%
% comparison of long-tailed and short tailed pdf's

% axes
Dd = 0.1;
N = 101;
d = Dd*[0:N-1]';
dmin=0;
dmax=10;

% short tailed pdf: Normal pdf
dbar=5;
d2=(d-dbar).^2;
sd = 1.0;
dbar = 5.0;
p1 = exp(-0.5*d2/(sd^2))/(sqrt(2*pi)*sd);
A1 = Dd*sum(p1);

% long-tailed distribution: Cauchy�Lorentz distribution
g = 1;
p2 = 1./(pi.*g.*(1+(d2./(g^2))));
A2 = Dd*sum(p2);

disp(sprintf('check on areas: true %f est1 %f est2 %f', 1, A1, A2));

figure(1);
clf;

% plot pdf
subplot(1,2,2);
set(gca,'LineWidth',2);
hold on;
axis( [dmin, dmax, 0, 0.5 ] );
plot(d,p1,'r-','LineWidth',3);
xlabel('d');
ylabel('p(d)');

% plot pdf
subplot(1,2,1);
set(gca,'LineWidth',2);
hold on;
axis( [dmin, dmax, 0, 0.5 ] );
plot(d,p2,'b-','LineWidth',3);
xlabel('d');
ylabel('p(d)');


