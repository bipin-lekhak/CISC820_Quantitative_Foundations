function permited = is_domain_proj_2(x)
[A, b] = project_read_2();

y = b - A * x;

y_pos = y>=0;

if sum(y_pos) == length(y)
    permited = true;
else
    permited = false;
end

end