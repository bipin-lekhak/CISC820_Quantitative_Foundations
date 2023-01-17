function test_asymptote_ci()

for alpha = [0.25, .1, .05, .01]
    for N = 10:50:1060
        missing = asymptote_ci(N,alpha);
        fprintf( ...
            "alpha=%.4f \t N =%d \t missing=%.4f \t diff=%f \n", ...
            [alpha, N, missing, alpha-missing] ...
        )
    end
end
end


