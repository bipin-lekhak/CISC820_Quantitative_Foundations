function [mu, sigma, pi] = get_lda_stats(x_vec, y_vec, K_max)

% size(x_vec) = (p,N)
% size(y_vec) = (1,N)
% size(K_max) = (1,1)

% size(pi) = (1, K_max)
% size(mu) = (p, K_max)
% size(sigma) = (p,p)

N = size(x_vec, 2);
p = size(x_vec, 1);

pi = zeros(1, K_max);
mu = zeros(p, K_max);
sigma = zeros(p, p);

for i = 1:K_max
    idx = (y_vec == (i));
    x_i = x_vec(:, idx);
    mean_i = mean(x_i, 2);
    mu(:,i) = mean_i;
    pi(i) = mean(idx);
    updater = (x_i - mean_i) * (x_i - mean_i)';
    sigma = sigma + updater;
end


sigma = sigma./(N-K_max);


end