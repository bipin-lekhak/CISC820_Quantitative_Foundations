function z = get_poly_cos_basis(X, p)
    z_1 = get_poly_basis(X, p);
    z_2 = 5 * cos(X);
    z_4 = log(1 - X);
    z = [z_1; z_2; z_4];

end