function [percent_missing] = check_ci(N, func_num, check_num)

if check_num == 1 % "Beta(2,2)"
    act_mu = 0.5;
    sampler = @(x) betarnd(2,2, x, 1);
elseif check_num == 2 % "Beta(20000,1)"
    act_mu = 20000 / (20000 + 1);
    sampler = @(x) betarnd(20000, 1, x, 1);
elseif check_num == 3 % "Beta(1,20000)"
    act_mu = 1 / (20000 + 1);
    sampler = @(x) betarnd(1, 20000, x, 1);
elseif check_num == 4 % "Bern(0.9999)"
    act_mu = 0.9999;
    sampler = @(x) sample_bernoulli(x, act_mu);
elseif check_num == 5 % "Bern(0.0001)"
    act_mu = 0.0001;
    sampler = @(x) sample_bernoulli(x, act_mu);
elseif check_num == 6 % "U(0, 0.001)"
    act_mu = (0.001 + 0)/2;
    sampler = @(x) sample_uniform(x, 0, 0.001);
elseif check_num == 7 % "U(0.999, 1)"
    act_mu = (0.999 + 1)/2;
    sampler = @(x) sample_uniform(x, 0.999, 1);
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
