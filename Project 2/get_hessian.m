function hess = get_hessian(func, x, h)

xp = x + h .* eye(length(x));
xp_cell = num2cell(xp, 1);

xm = x - h .* eye(length(x));
xm_cell = num2cell(xm, 1);

% grad_x = get_gradient_o4(func, x, h)';

wp = @(y) get_gradient_o4(func, y, h);
gxph = cellfun(wp, xp_cell, 'UniformOutput', false);
gxmh = cellfun(wp, xm_cell, 'UniformOutput', false);

grad1 = cell2mat(gxph')';
grad2 = cell2mat(gxmh')';

hess = (grad1 - grad2) / (2*h);


