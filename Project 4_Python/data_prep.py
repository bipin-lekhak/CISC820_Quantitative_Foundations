# %%
import os
from collections import Counter
from dataclasses import dataclass
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from skimage.transform import downscale_local_mean, rescale, resize

# %%

data_path = Path("att_faces/")
list(data_path.iterdir())

# %%
subject_dirs = [x for x in data_path.iterdir() if not x.is_file()]
subject_dirs

# %%
{tuple({plt.imread(y).shape for y in x.iterdir()}) for x in subject_dirs}

# %%
def process_att_face(image):
    image = image.copy()  # 112, 92
    # resized = resize(image, output_shape=(28, 28), anti_aliasing=False)
    resized = downscale_local_mean(image, factors=(4, 3))  # 28,31
    resized = resized[:, 1:29]
    return resized


# %%
fields = ["face", "subject", "image_num", "data"]


@dataclass
class ImageName:
    face: int
    subject: int
    image_num: int
    data: np.array


all_entries = []
for subject in subject_dirs:
    subject_id = int(subject.stem[1:])
    for image in subject.iterdir():
        image_id = int(image.stem)
        img_data = plt.imread(image)
        img_data_fixed = process_att_face(img_data)
        img_data_fixed = img_data_fixed.flatten()
        entry = ImageName(
            face=1, subject=subject_id, image_num=image_id, data=img_data_fixed
        )
        all_entries.append(entry)


face_data_df = pd.DataFrame(all_entries)
face_data_df
# %%

# Time for non face data

with open("train-images-idx3-ubyte", "rb") as file:
    img_data = np.fromfile(file, "uint8")

img_data = img_data[16:]

with open("train-labels-idx1-ubyte", "rb") as file:
    img_labels = np.fromfile(file, "uint8")

img_labels = img_labels[8:]

img_data.shape, img_labels.shape

# %%
num_images = int(img_labels.size)
num_pixels = int(img_data.size / num_images)

pix_length = int(num_pixels**0.5)

# %%
img_data_entry = img_data.reshape(num_images, num_pixels)

# %%


all_entries = []

for i, (data, label) in enumerate(zip(img_data_entry, img_labels)):
    entry = ImageName(face=0, subject=label, image_num=i, data=data)
    all_entries.append(entry)


non_face_data_df = pd.DataFrame(all_entries)
non_face_data_df

# %%

all_entries = []
for _, gdf in non_face_data_df.groupby(["face", "subject"]):
    top_df = gdf.head(40)
    print(top_df.shape)
    top_df = top_df.copy()
    top_df = top_df.reset_index(drop=True)
    top_df.image_num = top_df.index.copy()

    all_entries.append(top_df)

non_face_data_df = pd.concat(all_entries).reset_index(drop=True)
non_face_data_df


# %%
all_df = pd.concat([face_data_df, non_face_data_df])
all_df = all_df.sort_values(["face", "subject", "image_num"]).reset_index(drop=True)
all_df

# %%
all_df.to_csv("combined_data.csv", index=False)
all_df.to_feather("comined_data.feather")

# %%
