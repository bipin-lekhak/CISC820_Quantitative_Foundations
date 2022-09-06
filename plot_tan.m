% Plot tan function

% Trial for intro class


x = 0: pi/40: 2*pi;
n = length(x);
y = zeros(1,n);

ind = (x ~= pi/2) & (x ~= 3*pi/2);
y(ind) = tan(x(ind));
y(~ind) = 1;

plot(x/pi, y)
