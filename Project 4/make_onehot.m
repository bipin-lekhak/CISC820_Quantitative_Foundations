function oh_y = make_onehot(y, num_class)

if size(y,1) == 1
    y = y';
end

oh_y = zeros(num_class, size(y,1));

for i = 1:size(y,1)
    oh_y(y(i),i) = 1;
end



