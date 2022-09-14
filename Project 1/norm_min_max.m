function [x_norm, max_x, min_x] = norm_min_max(X)

    max_x = max(X);
    min_x = min(X);

    x_norm = (X - min_x) ./ (max_x - min_x); 

end