# %%
import pandas as pd

from create_datasets import split_face_data, split_non_face_data
from lda_utils import pandas_to_numpy_lda, predict_lda, train_lda

# %%
df = pd.read_feather("combined_data.feather")

# %%
df["subject"] = df["subject"] - 1
train_face, test_face = split_face_data(df)

print(train_face.shape)
# %%
x_train, y_train = pandas_to_numpy_lda(train_face, "data", "subject")
x_test, y_test = pandas_to_numpy_lda(test_face, "data", "subject")

# %%
lda = train_lda(x_train, y_train, 35)
preds = predict_lda(lda, x_test, y_test)


# %%
accuracy = (y_test == preds).mean()
print("Accuracy = ", accuracy)
# %%
