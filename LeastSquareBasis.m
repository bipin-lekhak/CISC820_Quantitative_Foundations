function [w_vec, R] = LeastSquareBasis(z, y)

y = ensureVectorLength(y); % length(y) == [n, 1] Stacked vertically

z; % length(z) == [p,n] Stacked horizontally


s = z * y % length(s) == [p, 1]

M = z * z' % [p, p]

w_vec = GaussianElimination(M, s) % [p, 1]


R = norm((w_vec' * z) - y')^2

end