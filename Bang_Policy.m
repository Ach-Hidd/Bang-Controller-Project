clear all
clc

figure()
xlabel('x');
ylabel('dotx');

hold on
x = -100:10:100;
n_times = length(x);
y_Matrix = zeros(1, n_times);
for i = 1:n_times
    if 0 < x(i)
        y = -sqrt(2*x(i));
    else
        y = sqrt(-2*x(i));
    end
    y_Matrix(1,i) = y;
end
Y=y_Matrix;

plot(x,Y)
patch([x fliplr(x)], [Y max(ylim)*ones(size(Y))], 'b') 
patch([x fliplr(x)], [Y min(ylim)*ones(size(Y))], 'r') 
legend() 
