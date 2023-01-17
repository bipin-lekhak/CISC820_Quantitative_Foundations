function p = get_search_distance(method, func, x, grad_f, varargin)

if nargin > 4
    hess_f = varargin{1};
end

if method == "gd"
    p = gradient_descent(func, x, grad_f);
elseif method == "newton"
    p = newton_method(func, x, grad_f, hess_f);
else
    error("Method for search_distance not defined")

end


end
