function test_check_ci(func_num, varargin)

if nargin == 2
    fname = varargin{1}
    fid = fopen(fname + "_" + string(func_num) +".txt", "a")
else
    fid = 1;
end



sampler_names = [...
    "Ber(0.5)", ...
    "U(10,30)",...
    "U(-100, -90)",...
    "N(-0.5, 4)",...
    "Mix. gaussian:"...
    ];

for sampler_num = 1:5
    name = sampler_names(sampler_num);
    fprintf(fid,"%s\n", name);
    for N = 10:50:1011
        missing = check_ci(N, func_num, sampler_num);
        fprintf( fid,...
            "N =%d \t missing=%.4f \n", ...
            [N, missing] ...
        );
    end
end

if nargin == 2
    fclose(fid);
end

end


