import numpy as np

import pandas as pd

import random

RANDOM_SEED = 42

random.seed(RANDOM_SEED)


def split_face_data(df):
    df = df.copy()
    df = df[df.face == 1].copy().reset_index(drop=True)
    # df = df.drop(columns=["face"])

    assert df["subject"].nunique() == 40
    test_idx = random.sample(range(40), 5)

    train_data = []
    test_data = []

    for subject, sub_df in df.groupby("subject"):
        if subject not in test_idx:
            train = sub_df.sample(n=8, random_state=42)
            test = sub_df.drop(train.index)
            train_data.append(train)
            test_data.append(test)
        else:
            test_data.append(sub_df)

    train_data = pd.concat(train_data).reset_index(drop=True)
    test_data = pd.concat(test_data).reset_index(drop=True)

    return train_data, test_data


def split_non_face_data(df, train_size, test_size):
    df = df.copy()
    df = df[df.face != 1].copy().reset_index(drop=True)

    train = df.sample(n=train_size, random_state=42)
    rem_df = df.drop(train.index)
    test = rem_df.sample(n=test_size, random_state=42)

    return train, test
