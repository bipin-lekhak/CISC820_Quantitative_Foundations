function [a_opt, b_opt, sq_error] = AnalyticLeastSquare(X, Y)

n = length(Y);
y_bar = sum(Y) / n;
x_bar = sum(X) / n;

% x2_bar = norm(X) ^ 2 /n;
x2_bar = (X' * X) /n;
xy_bar = (X' * Y) / n;


b_opt = (y_bar - (x_bar * xy_bar) ./ x2_bar) ./ (1 - x_bar^2 ./ x2_bar);
a_opt = (y_bar - b_opt) ./ x_bar;


error = Y - a_opt * X - b_opt;
sq_error = error' * error;

end