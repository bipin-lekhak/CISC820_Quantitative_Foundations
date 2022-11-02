function test_check_ci(func_num)

sampler_names = [...
    "Ber(0.5)", ...
    "U(10,30)",...
    "U(-100, -90)",...
    "N(-0.5, 4)",...
    "Mix. gaussian:"...
    ];

for sampler_num = 1:5
    name = sampler_names(sampler_num);
    fprintf("%s\n", [name]);
    for N = 10:50:1011
        missing = check_ci(N, func_num, sampler_num);
        fprintf( ...
            "N =%d \t missing=%.4f \n", ...
            [N, missing] ...
        )
    end
end
end


