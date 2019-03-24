clear all
X_i = 0;
Y_i = 0;
theta_i = 0;

X_f = 4;
Y_f = 0;
theta_f = -pi/2;

k = 20;

ax = k * cos(theta_f) - 3 * X_f;
ay = k * sin(theta_f) - 3 * Y_f;

bx = k * cos(theta_i) + 3 * X_i;
by = k * sin(theta_i) + 3 * Y_i;

Xs = [X_f-X_i+ax+bx 3*X_i-ax-2*bx -3*X_i+bx X_i];

Ys = [Y_f-Y_i+ay+by 3*Y_i-ay-2*by -3*Y_i+by Y_i];


for i = 1:1001
    
  X(i) = polyval(Xs,(i-1)/1000);
  Y(i) = polyval(Ys,(i-1)/1000);
  
end

figure(1)
plot(X,Y)
hold on
plot(X_i,Y_i,'x')
plot(X_f,Y_f,'o')
xlabel('X')
ylabel('Y')
title('planning via Cartesian')
axis([-5 5 -5 5])