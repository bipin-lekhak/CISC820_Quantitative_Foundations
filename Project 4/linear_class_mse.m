function out_classes = linear_class_mse(Z, y, num_class)

% Z: (p,N)
oh_y = make_onehot(y, num_class); % (num_class, N)

W = solve_md(Z, oh_y); % (num_class, p)

y_hat = W * Z; % (num_class, N)


[~, out_classes] = max(y_hat);


