%% test1
clc
z = zeros(2, 4);

z(1, :) = [0.1 0.2 0.3 0.4];
z(2, :) = [0.5 0.6 0.7 0.7];
y = [0.9 1.0 1.1 1.2];

LeastSquareBasis(z, y);

%% test 2
clc
z = zeros(2, 3);

z(1, :) = [1 2 5];
z(2, :) = [1 1 1];
y = [2 7 9];

LeastSquareBasis(z, y);


