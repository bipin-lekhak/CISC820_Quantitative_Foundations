function x = GaussianElimination(A, b)

[A_ut, b_ut] = UpperTriangular(A, b);
x = BackSubstitute(A_ut, b_ut);

end