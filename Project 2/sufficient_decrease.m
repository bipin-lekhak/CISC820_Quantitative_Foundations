function alpha = sufficient_decrease(func, grad_func, p, alpha, x, c, rho, varargin)

constraint = true;

if nargin > 7
    constraint_func = varargin{1};
    constraint = constraint_func(x);
end

p = ensureVectorLength(p);
grad_f = grad_func(x);

while (func(x + alpha*p) > func(x) + alpha * c * (p'*grad_f)) && (constraint) 
    alpha = rho * alpha;
end

