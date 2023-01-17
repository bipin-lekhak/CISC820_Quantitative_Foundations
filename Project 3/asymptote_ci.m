function [percent_missing] = asymptote_ci(N, alpha)

act_mu = 0.5;

if alpha == .25
    epsiolon = 1.150349;
elseif alpha == .1
    epsiolon = 1.64485;
elseif alpha == .05
    epsiolon = 1.95996;
elseif alpha == .01
    epsiolon = 2.57582;
end

precent_mu = 0;
for i = 1:10000
    samples = sample_bernoulli(N, act_mu);
    x_n = mean(samples);
    s_n = std(samples);
    e_n = s_n * epsiolon / sqrt(N);
    A_n = x_n - e_n;
    B_n = x_n + e_n;
    if (act_mu >= A_n) && (act_mu <= B_n)
        precent_mu = precent_mu + 1;
    end
end

percent_missing = 1 - precent_mu/10000;

