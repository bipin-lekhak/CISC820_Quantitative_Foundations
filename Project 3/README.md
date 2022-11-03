# README



## Files needed

1. `ci.m` This is downloaded from mycourses

2. `check_ci.m`  Matlab function to run experiments for 10K times for given function number by sampling from specified distribution.

3. `test_check_ci.m` Matlab function to run experiments for multiple N and log them to file or console.

4. `sample_bernoulli.m` Downloaded from mycourses

5. `sample_uniform.m` Downloaded from mycourses

6. `Statistics toolbox` needs to be installed for using `betarnd` function which samples from beta distribution



## To run

### Individual function

To run for function number 1 with output in console:

```matlab
check_ci(1)
```

To run for function number 2 with output in console:

```matlab
check_ci(2)
```

To run for function number 2 with output in file `Outputs/output_2.txt`:

```matlab
check_ci(2, "Outputs/output")
```

### All functions

Just run the script:

```matlab
runn_all_func
```

This script is just the following lines:

```matlab
for i = 1:10
    test_check_ci(i, "Outputs/output")
end
```

**NOTE:** Before running the script `run_all_func`

- Before running the script `run_all_func` Make sure there is an "Outputs" folder

- This script will save all its outputs in "Outputs" folder, with different files for different functions and the outputs will be saved as: `Outputs/output_{func_num}.txt` where func_num is an int between 1 and 10.

- The scripts are written such that if at any point a invalid ci is detected the loop for multiple N for that function under the given distribution stops.

- If none of 21 values of N for all 7 of the distributions return invalidity, the log files will have 22*7=154 lines, if there are fewer than 154 lines, it is because for some value of N, for some distribution of x, invalidity was detected. This can be used to check invalidity with the following bash command.
  

- ```bash
  wc -l Outputs/
  ```

- The above bash command should return list of output files based on functions along with the number of lines in each, any file containing less than 154 lines is invalid. The output should be similar to:

```bash
     154 Outputs/output_1.txt
     154 Outputs/output_10.txt
     116 Outputs/output_2.txt
     154 Outputs/output_3.txt
      34 Outputs/output_4.txt
     154 Outputs/output_5.txt
      94 Outputs/output_6.txt
     154 Outputs/output_7.txt
     115 Outputs/output_8.txt
     154 Outputs/output_9.txt
    1283 total
```

From this we can clearly see that the invalid functions are:

    -  Function 2: (116 lines)

    - Function 4: (34 lines)

    - Function 6: (94 lines)

    - Function 8: (115 lines)

## Determining alpha

- For valid ci's, the alpha is seen as the worst case alpha, i.e. the value of alpha which is highest is the value of alpha returned. If the highest value of alpha for a function is 0.1, it means at worst case 90% of ci contain true mean. Alpha less than 0.1 just mean that the probability of ci containing true mean is less than 90% and therefore the confidence interval is still 90%



## Determining asymptotic validity

- Checking values of alpha (missing fraction) with respect to N
  
  - If missing fraction saturates/ converges at certain point as N increases, it means it is asymptotic validity.


