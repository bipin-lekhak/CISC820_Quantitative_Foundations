# Project 4.1: PCA

Files needed:

- Project4_PCA.ipynb

## Steps to run

1. Prepare the dataset in local directory

2. Specify

* `folder_pth`, i.e., `folder_pth=*/att_faces`
* `subset_img_num`: number of the image chosen in a subset for the PCA reconstruction visualization
* `eigen_vec_num_vis`: number of eigenvectors to be used for the PCA reconstruction visualization

3. The original code is in the form of `.ipynb`, so that one can run module by module under Anaconda. The `.py` code is also available as a backup. 

4. Attention

* Both the eigenvalues and eigenvectors will be produced and saved automatically to the `./eigen.npy` at the frist launching. This will take around 10mins, the `eigen.npy` takes around 1.7Gb.
* For the time efficiency, please run the follwoing code after the eigenvector producing part. 
* By default, 99% of the energy is kept for the following part (curve, visualization), which corresponds to 324 components. 
* We randomly choose the `subset_img_num` out of 400 images no matter of the class. Each time the chosen images differs due to the unfixed seed. 

# Project 4.2: Classification

Files needed:

- create_datasets.py
- data_prep.py
- face_id.py
- face_recognition.py
- lda.py
- lda_utils.py
- Att_faces/ folder which is zipped version of folder from my courses
- train-images-idx3-ubyte (from mycourses)
- train-labels-idx3-ubyte (from mycourses)
- requirements.txt

## Steps to run

1. Install requirements from requirements.txt

`pip install -r requirements.txt`

2. First prepare dataset from att faces and non face from
   train-images-idx3-ubyte

`python data_prep.py`

Running this script should the prepared dataset as a feather file named: `combined_data.feather`

3. Run face recognition script (check if image has face or not)

`python face_recognition.py`

4. Run face recognition script (identify subject face from given image of face)

`python face_id.py`


