function z = get_poly_basis(X, p)
    [fet, num] = size(X);
    z = ones((p+1)*fet, num);
    for p_ = 1:p+1
        z((p_-1)*fet + 1 : (p_)*fet , :) = X.^(p_ - 1);
    end
end