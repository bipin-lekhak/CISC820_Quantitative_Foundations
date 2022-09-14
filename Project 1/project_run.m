traindata = importdata("data/traindata.txt");

% shuffle data
rng(914);
traindata = traindata(randperm(size(traindata, 1)), :);

X = traindata(:,1:8);
Y = traindata(:,9);

Xtest = importdata('data/testinputs.txt');



X = norm_min_max(X);
Xtest = norm_min_max(Xtest);

[p_best, train_error_best, test_error_best] = model_selection(X', Y, @get_poly_basis)

% z = get_poly_basis(X', 1);


% KFoldCrossVal(z, Y', 5)
