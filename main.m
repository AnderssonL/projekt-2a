x0 = 0.75;

err_central = zeros(1,8);
err_left    = zeros(1,8);
err_right   = zeros(1,8);
hs          = zeros(1,8);

true_du = exp(x0)*cos(exp(x0));
% up1 = u0 plus 1 timestep

% Approx derivata med central metod
for k = 1:8
    h = 2^(-k);
    hs(k) = h;
    
    u = @(x) sin(exp(x));
    u0  = u(x0);
    up1 = u(x0 + h);
    up2 = u(x0 + 2*h);
    un1 = u(x0 - h);
    un2 = u(x0 - 2*h);

    % central
    d_central = (up1 - un1)/(2*h);

    % frammåt
    d_left = (-up2 + 4*up1 - 3*u0)/(2*h);

    % bakåt
    d_right = (3*u0 - 4*un1 + un2)/(2*h);

    % fel
    err_central(k) = abs(d_central - true_du);
    err_left(k)    = abs(d_left    - true_du);
    err_right(k)   = abs(d_right   - true_du);
end

figure; 
hold on;

loglog(1./hs, err_central)
loglog(1./hs, err_left)
loglog(1./hs, err_right)

% referenskurva O(h^2)
loglog(1./hs, hs.^2)

xlabel('1/h')
ylabel('Error')
legend('Central (2)', 'Forward (6)', 'Backward (7)', '1/h')
grid on
title('Error vs O(h^2')
