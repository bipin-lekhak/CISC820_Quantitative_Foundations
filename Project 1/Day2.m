%% test1
clc
z = zeros(2, 4);

z(1, :) = [0.1 0.2 0.3 0.4];
z(2, :) = [0.5 0.6 0.7 0.7];
y = [0.9 1.0 1.1 1.2];

LeastSquareBasis(z, y);

%% test 2
clc

x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];

z = ones(2, length(x));
z(1, :) = x;
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

LeastSquareBasis(z, y);

%% test 3
clc

x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];

z = ones(3, length(x));
z(1, :) = x;
z(3, :) = x .* x;
y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

LeastSquareBasis(z, y);

%% test 4
clc

x = [0.23,0.88,0.21,0.92,0.49,0.62,0.77,0.52,0.30,0.19];

z = ones(3, length(x));

z(1, :) = sin(2*x);
z(2, :) = log(x);
z(3, :) = x .^ .5;

y = [0.19,0.96,0.33,0.80,0.46,0.45,0.67,0.32,0.38,0.37];

LeastSquareBasis(z, y);
