function h = project_hess_1(x)

x = ensureVectorLength(x);


h = diag(2* (1:length(x)));


end