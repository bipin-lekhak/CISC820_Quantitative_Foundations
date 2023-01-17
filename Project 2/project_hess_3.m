function h = project_hess_3(x)


x = ensureVectorLength(x);
n = length(x);

if ~(n == 2)
    error("vector x must be 2 dim")
end

x1 = x(1);
x2 = x(2);

h = zeros(n, n);

h(1,1) = -400 * (x2 - 3 * x1^2) + 2;
h(1,2) = -400 * x1;
h(2,1) = -400 * x1;
h(2,2) = 200;

end