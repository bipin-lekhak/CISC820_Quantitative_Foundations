function [a_opt, sq_error] = SimpleAnalyticLeastSquare(X, Y)

a_opt = (X' * Y) / (X' * X);


error = Y - a_opt * X;
sq_error = error' * error;

end