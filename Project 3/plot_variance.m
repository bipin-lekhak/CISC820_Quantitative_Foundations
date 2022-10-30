function plot_variance()

for i = 1:10
    [y_mu, y_var, y_entropy] = get_stat_yn(i);
    N(i) = i;
    mus(i) = y_mu;
    vars(i) = y_var;
    ents(i) = y_entropy;

end


figure(1)
subplot(321)
plot(N, mus)
% ylim([-0.01, 0.01])
ylabel("Mean")
xlabel("N")

subplot(322)
plot(N, vars)
% ylim(1 + [-0.01, 0.01])
ylabel("Variance")

subplot(323)
plot(N, ents)
ylabel("Entropy")

subplot(324)
hist(N, ents)
ylabel("Entropy")
