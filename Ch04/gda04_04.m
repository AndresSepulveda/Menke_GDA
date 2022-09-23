% gda04_04
%
% Model Resolution Matrix example, Backus-Gilbert solution

% model, m(z), moztly zero but a few spikes
M=101;
zmin=0;
zmax=10;
Dz=(zmax-zmin)/(M-1);
z=zmin+Dz*[0:M-1]';
mtrue = zeros(M,1);
mtrue(5)=1;
mtrue(10)=1;
mtrue(20)=1;
mtrue(50)=1;
mtrue(90)=1;

% experiment: exponential smoothing of model
N=80;
cmin=0.00;
cmax=0.10;
Dc=(cmax-cmin);
c = cmin + Dc*[0:N-1]';
G = exp(-c*z');

sd=0.0;
dtrue = G*mtrue;
dobs = dtrue + random('Normal',0,sd,N,1);

% construct Backus-Gilbert solution row-wise
GMG = zeros(M,N);
u = G*ones(M,1);
for k = [1:M]
    
    % code the the hard way as a check
    % S=zeros(N,N);
    % for i=[1:N]
    % for j=[1:N]
    %    tmp=0;
    %    for el=[1:M]
    %        tmp=tmp+((el-k)^2)*G(i,el)*G(j,el);
    %    end
    %    S(i,j)=tmp;
    % end
    % end
    
    % note that S is a symmetric matrix
    S = G * diag(([1:M]-k).^2) * G';
    epsilon=1e-6;
    S = S+epsilon*eye(N);
    uSinv = u'/S;
    GMG(k,:) = uSinv / (uSinv*u);
   
end
    
mest = GMG * dobs;
Rres = GMG*G;

gda_draw(' ',mest,'=',' ',Rres,' ',mtrue);

% plot
figure(2);
clf;

pmmin=-0.2;
pmmax=1;

set(gca,'LineWidth',3);
hold on;
axis( [zmin, zmax, pmmin, pmmax ]' );
plot( z, mtrue, 'r-', 'LineWidth', 3);
plot( z, mest,  'b-', 'LineWidth', 3);
xlabel('z');
ylabel('m');

