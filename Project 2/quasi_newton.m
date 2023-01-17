function x_best = quasi_newton(func, grad_func, x_guess)

x_guess = ensureVectorLength(x_guess);
x_new = x_guess;

step = 0;

diff = [10,10];
% func  = @test_func_2;
% grad_f= @test_grad_func_2;
% hess_f= @test_hess_func_2;
approx_hess = eye(length(x_guess));

while ~((norm(diff) < 1e-6))
    x_old = x_new;
    p = -1 * approx_hess * grad_func(x_old);
    alpha = sufficient_decrease(func, grad_func, p, 1, x_old, 0.1, 0.5);
%     alpha = 0.8;
    diff = alpha * p;
    disp(step);
    x_new = x_old + diff
    step = step + 1;

    % Update F
    s = x_new - x_old;
    y = grad_func(x_new) - grad_func(x_old);
    approx_hess = approx_hess + (y'*(approx_hess*y + s))/((y'*s)^2) * s * s' - ...
        (s * y' * approx_hess + approx_hess * y * s') / (y' * s);
    
end
disp(step)
disp(norm(diff))
x_best = x_new;
end