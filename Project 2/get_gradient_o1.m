function grad_x = get_gradient_o1(func, x, h)

fx = func(x);

xp = x + h .* eye(length(x));
xp_cell = num2cell(xp, 1);

fxph = cellfun(func, xp_cell);

grad_x = (fxph - fx) ./ h;

end