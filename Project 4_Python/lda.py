import numpy as np


class LDA_Classifier:
    def __init__(self, num_classes, common_var=True):
        super().__init__()
        self.num_classes = num_classes
        self.fitted = False
        self.common_var = True

    @property
    def priors(self):
        if self.fitted:
            try:
                return self._prior
            except AttributeError as e:
                raise AttributeError("Prior not found") from e
        return [1 / self.num_classes for _ in range(self.num_classes)]

    @property
    def means(self):
        if self.fitted:
            try:
                return self._means
            except AttributeError as e:
                raise AttributeError("Means not found") from e
        raise AttributeError("Model not fit yet")

    def fit(self, x: np.array, y: np.array):
        if x.ndim == 2:
            x = x.flatten()
        num_data = len(x)
        assert len(y) == num_data

        prior, mean, variance = self._get_stats(x, y, num_data)
        self._priors = prior
        self._means = mean
        self._variance = variance

    def _get_stats(self, x, y):
        num_data = len(y)

        means = []
        for class_idx in range(self.num_class):
            x_class, y_class = self._filter_class(x, y, class_idx)
            mean_class, variance_class = self._get_class_stats(x_class, y_class)
