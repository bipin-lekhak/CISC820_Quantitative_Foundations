function g = project_grad_1(x)

x = ensureVectorLength(x);
n = length(x);

g = zeros(n, 1);

for i = 1:n
    g(i) = 2 * i * x(i);
end


end