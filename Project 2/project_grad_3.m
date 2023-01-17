function g = project_grad_3(x)

x = ensureVectorLength(x);
n = length(x);

if ~(n == 2)
    error("vector x must be 2 dim")
end


x1 = x(1);
x2 = x(2);

g = zeros(2, 1);

g(1) = -400 * (x2 - x1^2) * x1 - 2* (1-x1);
g(2) = 200 * (x2 - x1^2);

end