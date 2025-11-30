function f = rastrigin(x)
    A = 10;
    x = x(:)';
    D = length(x);
    f = A*D + sum(x.^2 - A*cos(2*pi*x));
end
