function [A, b, c] = project_read_2()
% Read A
fid = fopen('fun2_A.txt','r');
A = fscanf(fid,'%e ',[500,100]);
fclose(fid);


% Read b
fid = fopen('fun2_b.txt','r');
b = fscanf(fid,'%e ',[500,1]);
fclose(fid);


% Read c
fid = fopen('fun2_b.txt','r');
c = fscanf(fid,'%e ',[100,1]);
fclose(fid);

end