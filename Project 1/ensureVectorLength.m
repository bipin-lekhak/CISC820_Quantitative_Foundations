function a = ensureVectorLength(a)

n = length(a);

if any(size(a) ~= [n, 1])
    if all(size(a) == [1, n])
        a = a';
    else
        error("Can't interpret as vector")
    end


end