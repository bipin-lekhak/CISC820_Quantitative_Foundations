function grad_x = get_gradient(func, x, h, order)

if order == 1
    grad_x = get_gradient_o1(func, x, h);
elseif order ==2
    grad_x = get_gradient_o2(func, x, h);
elseif order == 4
    grad_x = get_gradient_o4(func, x, h);
else
    grad_x = NaN;

end