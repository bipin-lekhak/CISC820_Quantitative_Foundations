# CISC820_Quantitative_Foundations

Course contents and projects for CISC820_Quantitative_Foundations taught by Dr. Linwei Wang at RIT in the fall of 2022.

## How to run

- Unzip folder

- cd into Project 1: 

`cd CISC820_Quantitative_Foundations/Project\ 1`

- Run file project_run.m using matlab

- This should create a `predictions.txt` file with values of y.

- For Bonus points, Random Forest was tested using MATLAB's built in toolbox features. After installing correct toolbox files, run: `RamdomForestRegressor(traindata)` for testing it. It returns cross validation mean testing MSE error as second output argument:

```matlab
[~, mean_MSE_crossval] = RamdomForestRegressor(traindata)
```
