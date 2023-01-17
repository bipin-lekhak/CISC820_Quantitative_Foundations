function x_best = line_search(func, x_guess)

x_guess = ensureVectorLength(x_guess);
x_new = x_guess;

diff = [10, 0];

step = 0;

func  = @test_func_2;
grad_f= @test_grad_func_2;
hess_f= @test_hess_func_2;

while ~((norm(diff) < 1e-5))
    x_old = x_new;
%     p = get_search_distance("gd", func, x_old, grad_f);
    p = get_search_distance("newton", func, x_old, grad_f, hess_f);
    alpha = sufficient_decrease(func, grad_f, p, 1);
    diff = alpha * p;
    x_new = x_old + diff
    step = step + 1;
end
display(step)
display(norm(diff))
x_best = x_new;
end