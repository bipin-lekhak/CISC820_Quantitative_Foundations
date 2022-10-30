function [percent_missing] = simulate_ci(N, alpha)

act_mu = 0.5;

precent_mu = 0;
for i = 1:10000
    x_n = mean(sample_bernoulli(N, act_mu));
    e_n = sqrt(log(2/alpha) / (2*N));
    A_n = x_n - e_n;
    B_n = x_n + e_n;
    if (act_mu >= A_n) && (act_mu <= B_n)
        precent_mu = precent_mu + 1;
    end
end

percent_missing = 1 - precent_mu/10000;

