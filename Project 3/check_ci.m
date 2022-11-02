function [percent_missing] = check_ci(N, func_num, check_num)

if check_num == 1
    act_mu = 0.5;
    sampler = @(x) sample_bernoulli(x, act_mu);
elseif check_num == 2
    act_mu = 20;
    sampler = @(x) sample_uniform(x, act_mu - 10, act_mu + 10);
elseif check_num == 3
    act_mu = -95;
    sampler = @(x) sample_uniform(x, act_mu - 5, act_mu + 5);
elseif check_num == 4
    act_mu = -0.5;
    sampler = @(x) sample_normal(x, 4, act_mu);
elseif check_num == 5
    act_mu = 10;
    sampler = @(x) (sample_normal(x, 1, act_mu-10) + sample_normal(x, 1, act_mu+10))/2;
end

precent_mu = 0;
for i = 1:10000
    x_n = sampler(N);
    [A_n, B_n] = ci(x_n, func_num);
    if (act_mu >= A_n) && (act_mu <= B_n)
        precent_mu = precent_mu + 1;
    end
end

percent_missing = 1 - precent_mu/10000;
