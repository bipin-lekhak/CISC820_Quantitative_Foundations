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
