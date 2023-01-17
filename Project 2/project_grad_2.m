function g = project_grad_2(x)

x = ensureVectorLength(x);
n = length(x);

if ~(n == 100)
    error("vector x must be 2 dim")
end


[A, b, c] = project_read_2();


g = c + A' * (1 ./(b - A * x));


end