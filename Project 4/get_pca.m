function [P, S, Y] = get_pca(X, method)

% assume X is of dim N,p
% N is num point
% p is dimesion

X_mean = mean(X, 2);
X_m_mean = X - X_mean;


if method == "svd"
    [P, S, ~] = svd(X_m_mean);
elseif method == "eig"
    [P, s] = eig(X_m_mean*X_m_mean');
    % Sort eigens
    [s_sorted, idx] = sort(diag(s),'descend');
    S = diag(s_sorted);
    P = P(:, idx);

end

Y = P' * X;

