function f = project_func_3(x)

x = ensureVectorLength(x);
n = length(x);

if ~(n == 2)
    error("vector x must be 2 dim")
end


x1 = x(1);
x2 = x(2);

f = 100 * (x2 - x1^2)^2 + (1 - x1)^2;


end