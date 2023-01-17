function plot_check_ci(func_num)

all_n = 10:10:100;
all_miss = zeros(size(all_n));

for i = 1:length(all_n)
    N = all_n(i);
    missing = 0;
    for idx = 1:1000
        missing_idx = check_ci(N, func_num);
        missing = max(missing, missing_idx);
    end
    all_miss(i) = missing;
end

stem(all_n, all_miss)
set(gca, 'XScale', 'log')
end


