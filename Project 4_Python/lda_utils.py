import numpy as np


class LDA:
    def __init__(self, K_max, mu, sigma, pi):
        self.K = K_max
        self.mu = mu
        self.sigma = sigma
        self.pi = pi


def train_lda(x_vec, y_vec, K_max):
    """
    train_lda

    Parameters
    ----------
    x_vec : np.array: p,N
    y_vec : np.array (N,)
    K_max : int
    """
    p, N = x_vec.shape

    π = np.zeros((K_max,))
    μ = np.zeros((p, K_max))
    Σ = np.zeros((p, p))

    for cat in range(K_max):
        idx = np.where(y_vec.flatten() == cat)[0]
        # breakpoint()
        x_cat = x_vec[:, idx]
        mean_x = np.nanmean(x_cat, axis=1)  # mean_x.shape == (N,)
        μ[:, cat] = mean_x
        π[cat] = len(idx) / N
        mean_x = mean_x.reshape(-1, 1)
        del_Σ = (x_cat - mean_x) @ (x_cat - mean_x).T
        Σ += del_Σ

    Σ = Σ / (N - K_max)

    return LDA(K_max, μ, Σ, π)


def predict_lda(lda_trained, x_test, y_test):
    """
    predict_lda _summary_

    _extended_summary_

    Parameters
    ----------
    lda_trained : LDA object
    x_test : np.array p,M
    y_test : np.array (M,)
    """
    K_max = lda_trained.K
    Σ = lda_trained.sigma
    Σ_i = np.linalg.pinv(Σ)
    p, N = x_test.shape

    all_likelihood = np.zeros((K_max, N))
    all_log_prior = np.log(lda_trained.pi)
    all_posterior = np.zeros((K_max, N))

    for cat in range(K_max):
        μ_cat = lda_trained.mu[:, cat]
        μ_cat = μ_cat.reshape(-1, 1)
        likelihood_1 = (x_test.T @ Σ_i) @ μ_cat
        likelihood_2 = 0.5 * ((μ_cat.T @ Σ_i) @ μ_cat)
        likelihood = likelihood_1 - likelihood_2
        all_likelihood[cat, :] = likelihood.flatten()

    all_posterior = all_likelihood + all_log_prior.reshape(-1, 1)
    return np.nanargmax(all_posterior, axis=0)


def pandas_to_numpy_lda(df, x_col, y_col):
    df = df.copy()
    x_val = df[x_col].values
    y_val = df[y_col].values

    x_val = np.array([np.array(x) for x in x_val]).T

    return x_val, y_val


if __name__ == "__main__":
    import pandas as pd

    df = pd.read_feather("combined_data.feather")
    df = df[df["face"] == 1].copy().reset_index(drop=True)
    if df["face"].unique() == [1]:
        df["subject"] = df["subject"] - 1
    x_val = np.array(list(df.data.values)).T
    y_val = df.subject.values
    lda = train_lda(x_val, y_val, 40)
    preds = predict_lda(lda, x_val, y_val)
    print("Accuracy = ", np.mean(preds == y_val))
