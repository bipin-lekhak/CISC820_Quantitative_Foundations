function [a, b] = get_desicion_boundary_2class(x_vec, y_vec)

% of form a'x + b =0
% a = slope
% b = y-intercept

% size(x_vec) = (p,N)
% size(y_vec) = (1,N)

% size(a) = (p,1)
% size(b) = (1,1)


[mu, sigma, pi] = get_lda_stats(x_vec, y_vec, 2);

mu_k = mu(:, 1);
mu_l = mu(:, 2);

pi_k = pi(1);
pi_l = pi(2);


a = sigma \ (mu_k - mu_l);

b = log(pi_k/pi_l) - .5 * ((mu_k + mu_l)'* a);

end