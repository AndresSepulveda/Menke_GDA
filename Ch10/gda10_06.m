% gda10_06

% factor analysis with simple shapes

% figure 1 is plot of samples
figure(1);
clf;

% define samples
N=15;
M=11;
S=zeros(N,M);
S(1,:) = [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0];
S(2,:) = [0, 2, 3, 4, 5, 6, 5, 4, 3, 1, 0];
S(3,:) = [0, 1, 2, 4, 5, 6, 5, 4, 2, 1, 0];
S(4,:) = [0, 1, 3, 5, 5, 4.5, 4, 3.5, 3, 2.5, 0];
S(5,:) = fliplr(S(4,:));
S(6,:) = [0, 6, 6, 6, 5, 5, 5, 3.5, 2, 1, 0];
S(7,:) = fliplr(S(6,:));
S(8,:) = [0, 0.25, 0.5, 1, 3, 6, 3, 1, 0.5, 0.25, 0];
S(9,:) = [0, 1, 2.5, 3, 4, 6, 4, 3, 2.5, 1, 0];
S(10,:) = [0, 1, 2, 4, 6, 4, 2, 1, 1, 0.5, 0];
S(11,:) = fliplr(S(10,:));
S(12,:) = [0, 0, 0.5, 0, 1, 1, 2, 4, 6, 3, 0];
S(13,:) = fliplr(S(12,:));
S(14,:) = [0, 0, 0.5, 1, 3, 6, 5.5, 5.5, 4.5, 3.5, 0];
S(15,:) = fliplr(S(14,:));

% plot samples
for i=[1:N]
    subplot(5,3,i);
    set(gca,'LineWidth',2);
    hold on;
    axis( [0, M-1, 0, 7] );
    plot( [0:M-1], S(i,:), 'k-', 'LineWidth', 2 );
    plot( [0:M-1], S(i,:), 'k.', 'LineWidth', 2 );
    xlabel('i');
    ylabel(sprintf('s_{%d}',i));
end


% factor analysis
[U, LAMBDA, V] = svd(S);
C = U*LAMBDA;
F = V';
fprintf('First 3 singular values: %f %f %f\n', LAMBDA(1,1), LAMBDA(2,2), LAMBDA(3,3) );

% figure 2 is plot of the first three factors
figure(2);
clf;

% plot first 3 factors.  SIgn flip is just for aesthetic plot
for i=[1:3]
    subplot(1,3,i);
    set(gca,'LineWidth',2);
    hold on;
    axis( [0, 10, -1, 1] );
    plot( [0:M-1], -F(i,:), 'k-', 'LineWidth', 2 );
    plot( [0:M-1], -F(i,:), 'k.', 'LineWidth', 2 );
    plot( [0:M-1], zeros(1,M), 'k:', 'LineWidth', 2 );
    xlabel('i');
    ylabel(sprintf('F_{%d}',i));
end


% figure 3 is a plot of the profiles arranged by loadings 2 and 3
% figure 2 is plot of the first three factors
figure(3);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [-8, 8, -8, 8] );
plot( [-8, 8], [0, 0], 'k:', 'LineWidth', 2);
plot( [0, 0], [-8, 8], 'k:', 'LineWidth', 2);

for i=[1:N]
    % loadings
    c2 = C(i,2);
    c3 = C(i,3);
    
    % demean the sample and rescale
    scale1 = 0.4;
    x = [0:M-1];
    s = S(i,:);
    s = s - mean(s);
    s = s*scale1;
    [smax, ismax] = max(s);
    xmax = x(ismax);
    xbar = mean(x);
    x = x-xbar;
    xmax = xmax-xbar;
    x = x*scale1;
    xmax = xmax*scale1;

    % offset by scaled version of loadings
    x = x+c2;
    s = s+c3;
    fill( x, s, [0, 0.5, 1.0], 'FaceAlpha', 0.5 );
    plot( x, s, 'k-', 'Linewidth', 2);
    plot( x, s, 'k.', 'Linewidth', 2);
    plot( [x(1), x(M)], [s(1), s(M)], 'k-', 'LineWidth', 2 );
    
    
    text( c2+xmax, c3, sprintf('%d',i), 'HorizontalAlignment', 'center' );

end

xlabel('loading 2');
ylabel('loading 3');

