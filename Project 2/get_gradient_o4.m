function grad_x = get_gradient_o4(func, x, h)

xp2 = x + 2 .* h .* eye(length(x));
xp1 = x + 1 .* h .* eye(length(x));
xm2 = x - 2 .* h .* eye(length(x));
xm1 = x - 1 .* h .* eye(length(x));

xp2_cell = num2cell(xp2, 1);
xp1_cell = num2cell(xp1, 1);
xm2_cell = num2cell(xm2, 1);
xm1_cell = num2cell(xm1, 1);

fxp2h = cellfun(func, xp2_cell);
fxp1h = cellfun(func, xp1_cell);
fxm2h = cellfun(func, xm2_cell);
fxm1h = cellfun(func, xm1_cell);


grad_x = (-fxp2h + 8 * fxp1h - 8 * fxm1h + fxm2h) ./ (12*h);

end