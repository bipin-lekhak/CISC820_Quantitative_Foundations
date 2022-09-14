%  Back substituion

A = [
    [2, 1, 1]; 
    [1, 1, 2]; 
    [1, 1, 3]
    ];
x_act = [-4; 1; 5];
b = [2; 3; 6];

% (A * x_act);


[A_ut, b_ut] = UpperTriangular(A,b)

x = BackSubstitute(A_ut, b_ut);
x_act

