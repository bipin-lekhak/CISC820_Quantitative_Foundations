function f = project_func_2(x)

x = ensureVectorLength(x);
n = length(x);

if ~(n == 100)
    error("vector x must be 100 dim")
end


[A, b, c] = project_read_2();


f = c' * x - sum(log(b - A * x));

end