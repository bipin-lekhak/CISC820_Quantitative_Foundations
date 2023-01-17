function x_best = newton_method(func, grad_func, hess_func, x_guess)

x_guess = ensureVectorLength(x_guess);
x_new = x_guess;

diff = [10, 0];

step = 0;


while ~((norm(diff) < eps))
    x_old = x_new;
    p = -1 * hess_func(x_old) \ grad_func(x_old);
%     alpha = sufficient_decrease(func, grad_func, p, 1, x_old, 0.1, 0.8);
    alpha = 1;
    diff = alpha * p;
    x_new = x_old + diff;
    step = step + 1;
end
disp(step)
disp(norm(diff))

x_best = x_new;
end