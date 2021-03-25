close all 
clc

Y1 = 1;
f = @(t,Y) [Y(2); Y1];
y1 = linspace(-2,8,20);
y2 = linspace(-2,2,20);
[x,y] = meshgrid(y1,y2);
u = zeros(size(x));
v = zeros(size(x));
t=0; % we want the derivatives at each point at t=0, i.e. the starting time
for i = 1:numel(x)
    Yprime = f(t,[x(i); y(i)]);
    u(i) = Yprime(1);
    v(i) = Yprime(2);
end
quiver(x,y,u,v,'r');
xlabel('x')
ylabel('xdot')
axis tight equal;
