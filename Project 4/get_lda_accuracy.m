function [accuracy] = get_lda_accuracy(x_train, y_train, x_test, y_test)

pred = lda_predictions(x_train, y_train, x_test);

accuracy = mean(y_test == pred);

end