function [A, b] = UpperTriangular(A,b)

n = size(b);

for j = 1:n
    for i = j+1: n
        C = A(i,j) / A(j,j);
        A(i,:) = A(i,:) - C*A(j,:);
        b(i) = b(i) - C*b(j);
    end
end

end