function [test_error, train_error] = KFoldCrossVal(Z, y, K)

N = length(y);
chunk_size = floor(N/K);

errors = zeros(1,K);
t_errors = zeros(1,K);

for k = 1:K
    start_idx = (k-1)*chunk_size;
    end_idx = k*chunk_size;
    
    test_Z = Z(:,start_idx+1:end_idx);
    train_Z = [Z(:, 1:start_idx), Z(:, end_idx+1:N)];

    test_y = y(:,start_idx+1:end_idx);
    train_y = [y(:, 1:start_idx), y(:, end_idx+1:N)];

    [w_vec, t_error] = LeastSquareBasis(train_Z, train_y');

    errors(k) = norm(w_vec' * test_Z - test_y)^2 / chunk_size;
    t_errors(k) = t_error / (N-chunk_size);

end

test_error = mean(errors);
train_error = mean(t_errors);