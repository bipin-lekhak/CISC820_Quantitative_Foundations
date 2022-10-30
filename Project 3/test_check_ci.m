function test_check_ci(func_num)

for alpha = 0:0.05:1
    for N = 10.^(1:4)
        missing = check_ci(N, func_num);
        fprintf( ...
            "alpha=%.4f \t N =%d \t missing=%.4f \t diff=%f \n", ...
            [alpha, N, missing, alpha-missing] ...
        )
    end
end
end


