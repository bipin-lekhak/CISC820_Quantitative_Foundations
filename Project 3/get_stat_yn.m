function [y_mu, y_var, y_entropy] = get_stat_yn(N)
for i = 1:100000
%     xs = sample_uniform(N, -(3^.5), 3^.5);
    xs = sample_normal(N, 1, 0);
    y(i) = sum(xs) / (N^.5);
end

y_mu = mean(y);
y_var = var(y);
y_entropy = estimate_entropy(y);
