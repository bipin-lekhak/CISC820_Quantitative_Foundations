function h = project_hess_2(x)


x = ensureVectorLength(x);
n = length(x);

if ~(n == 100)
    error("vector x must be 100 dim")
end

[A, b, c] = project_read_2();

y = 1./((b-A*x).^2);

h = A' * diag(y) * A;

end