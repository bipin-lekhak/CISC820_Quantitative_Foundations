function [p_best, train_error_best, test_error_best] = model_selection(X, Y, basis_func)

max_p = 25;
K_val = 10;

Y = ensureVectorLength(Y)';


best_p = zeros(max_p, 3);

for p = 0:max_p
    z = basis_func(X, p);
    [test_error, train_error] = KFoldCrossVal(z, Y, K_val);
    best_p(p+1,:) = [p, train_error, test_error];
end


plot(best_p(:,1), best_p(:,2));
hold on;
plot(best_p(:,1), best_p(:,3));
ylim([0, max(best_p(:,2))])
xlabel("max\_p")
ylabel("error")
legend("train\_error", "test\_error")
title("Model selection using K-fold cross validation")

[~, arg_min_test] = min(best_p(:,3));


p_best = best_p(arg_min_test, 1);
train_error_best = best_p(arg_min_test, 2);
test_error_best = best_p(arg_min_test, 3);
end