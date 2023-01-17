function W = solve_md(Z, Y)

% solution for y(k,N) = W'(k,p) * Z(p,N)

W = Y*Z'*pinv(Z*Z');

