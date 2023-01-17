function [y_pred] = lda_predictions_2C(x_train, y_train, x_test)

% size(x_train) = (p,N)
% size(y_train) = (1,N)
% size(x_test) = (p,M)

% size(y_pred) = (1,M)

y_pred = ones(1, size(x_test,2));
[a, b] = get_desicion_boundary_2class(x_train, y_train);

lines = x_test' * a + b;
idx = (lines <= 0);

y_pred(idx) = 2;


