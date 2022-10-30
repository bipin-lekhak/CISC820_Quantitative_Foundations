function [percent_missing] = check_ci(N, func_num)

act_mu = 0.5;

precent_mu = 0;
for i = 1:10000
    x_n = sample_bernoulli(N, act_mu);
    [A_n, B_n] = ci(x_n, func_num);
    if (act_mu >= A_n) && (act_mu <= B_n)
        precent_mu = precent_mu + 1;
    end
end

percent_missing = 1 - precent_mu/10000;

