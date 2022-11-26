# %%
import pandas as pd

from create_datasets import split_face_data, split_non_face_data
from lda_utils import pandas_to_numpy_lda, predict_lda, train_lda

# %%
df = pd.read_feather("combined_data.feather")

# %%
train_face, test_face = split_face_data(df)
train_no_face, test_no_face = split_non_face_data(df, len(train_face), len(test_face))

print(train_face.shape)
# %%
recog_data_train = pd.concat([train_face, train_no_face]).reset_index(drop=True)
recog_data_test = pd.concat([test_face, test_no_face]).reset_index(drop=True)

# %%
x_train, y_train = pandas_to_numpy_lda(recog_data_train, "data", "face")
x_test, y_test = pandas_to_numpy_lda(recog_data_test, "data", "face")

# %%
lda = train_lda(x_train, y_train, 2)
preds = predict_lda(lda, x_test, y_test)


# %%
accuracy = (y_test == preds).mean()
print("Accuracy=", accuracy)
# %%
