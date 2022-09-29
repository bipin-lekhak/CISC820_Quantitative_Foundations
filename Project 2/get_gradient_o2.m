function grad_x = get_gradient_o2(func, x, h)

xp = x + h .* eye(length(x));
xm = x - h .* eye(length(x));

xp_cell = num2cell(xp, 2);
xm_cell = num2cell(xm, 2);

fxph = cellfun(func, xp_cell);
fxmh = cellfun(func, xm_cell);

grad_x = (fxph - fxmh) ./ (2*h);

end