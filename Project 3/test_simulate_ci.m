function test_simulate_ci()

for alpha = [1, 0.05, 0.25]
    for N = [10, 100, 1000]
        missing = simulate_ci(N,alpha);
        fprintf( ...
            "alpha=%.4f \t N =%d \t missing=%.4f \t diff=%f \n", ...
            [alpha, N, missing, alpha-missing] ...
        )
    end
end
end


