% y = x[1]^2 + 10* x[2]^2

% grad_y = [2, 20]' .* x

x = [.5, .5]';

h = 1;
get_gradient(@test_func_2, x, h, 4)

test_grad_func_2(x)

test_hess_func_2(x)
