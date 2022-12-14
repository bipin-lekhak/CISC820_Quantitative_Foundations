function test_check_ci(func_num, varargin)

if nargin == 2
    fname = varargin{1} + "_" + string(func_num) +".txt";
    fid = fopen(fname, "w");
else
    fid = 1;
end



sampler_names = [...
    "Beta(2,2)", ...
    "Beta(20000,1)",...
    "Beta(1, 20000)",...
    "Bern(0.9999)",...
    "Bern(0.0001)",...
    "U(0, 0.001)",...
    "U(0.999, 1)"...
    ];

for sampler_num = 1:7
    name = sampler_names(sampler_num);
    fprintf(fid,"%s\n", name);
    for N = 10:50:1011
        missing = check_ci(N, func_num, sampler_num);
        fprintf( fid,...
            "N =%d \t missing=%.4f \n", ...
            [N, missing] ...
        );
        if missing == 1
            break
        end
    end
end

if nargin == 2
    fclose(fid);
end

end


