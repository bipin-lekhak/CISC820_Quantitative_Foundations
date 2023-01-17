function [y_pred] = lda_predictions(x_train, y_train, x_test)

% size(x_train) = (p,N)
% size(y_train) = (1,N)
% size(x_test) = (p,M)

% size(y_pred) = (1,M)

[p, N] = size(x_train);
[p2, M] = size(x_test);
K_max = max(y_train');

[mu, sigma, pi] = get_lda_stats(x_train, y_train, K_max);

likelihood = zeros(K_max, N);
log_prior = log(pi);
posterior = zeros(K_max, N);

for i = 1:K_max
    mu_k = mu(:, i);
    likelihood(i, :) = (x_test' * (sigma \ mu_k) - .5 * mu_k' * (sigma \ mu_k))';
end

posterior = likelihood + log_prior';

[~, y_pred] = max(posterior);


