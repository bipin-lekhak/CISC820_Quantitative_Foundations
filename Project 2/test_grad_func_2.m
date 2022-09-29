function grad_y = test_grad_func_2(x)
y1 = exp(x(1) + 3*x(2) -0.1) + exp(x(1) - 3*x(2) -0.1) - exp(-x(1) -0.1);
y2 = 3 * exp(x(1) + 3*x(2) -0.1) - 3 * exp(x(1) - 3*x(2) -0.1);
grad_y = [y1, y2]';
