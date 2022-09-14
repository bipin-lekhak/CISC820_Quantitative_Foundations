%% test 1
clc

x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];

z = ones(2, length(x));
z(1, :) = x;
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

KFoldCrossVal(z, y, 5)

%% test2
clc

x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];

z = ones(2, length(x));
z(1, :) = x;
% z(2, :) = x.^2;
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

errors = zeros(10,3);

for i = 2:10
    [test, train] = KFoldCrossVal(z, y, i);
    errors(i,:) = [i, test, train];
end
errors

%% test 3
clc
x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

best_p = zeros(10,3);

for p = 0:10
    z = ones(p+1, length(y));
    for p_ = 1:p+1
        z(p_, :) = x.^(p_ - 1);
    end
    [test_error, train_error] = KFoldCrossVal(z, y, 5);
    best_p(p+1,:) = [p, train_error, test_error];
end
best_p

%% test 4
clc
x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

best_p = zeros(10,3);
model_selection(x, y, @get_poly_basis)
best_p;



