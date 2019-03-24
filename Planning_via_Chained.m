X_i = 0;
Y_i = 0;
theta_i = 0;

X_f = 0;
Y_f = 0;
theta_f = pi/2;

Z1_i = theta_i;
Z2_i = X_i * cos(theta_i) + Y_i * sin(theta_i);
Z3_i = X_i * sin(theta_i) - Y_i * cos(theta_i);

Z1_f = theta_f;
Z2_f = X_f * cos(theta_f) + Y_f * sin(theta_f);
Z3_f = X_f * sin(theta_f) - Y_f * cos(theta_f);

a3 = Z2_f * (Z1_f - Z1_i) - 3 * Z3_f;
b3 = Z2_i * (Z1_f - Z1_i) + 3 * Z3_i;

Z1s = [Z1_f-Z1_i Z1_i];
Z3s = [Z3_f-Z3_i+a3+b3 3*Z3_i-a3-2*b3 -3*Z3_i+b3 Z3_i];
Z2s = polyder(Z3s) / (Z1_f - Z1_i);

for i = 1:1001
  
  Z1(i) = polyval(Z1s,(i-1)/1000);
  Z2(i) = polyval(Z2s,(i-1)/1000);
  Z3(i) = polyval(Z3s,(i-1)/1000);
    
    
  X(i) = Z2(i) * cos(Z1(i)) + Z3(i) * sin(Z1(i));
  Y(i) = Z2(i) * sin(Z1(i)) - Z3(i) * cos(Z1(i)); 
  
end

figure(1)
plot(X,Y)
hold on
plot(X_i,Y_i,'x')
plot(X_f,Y_f,'o')
xlabel('X')
ylabel('Y')
title('planning via Chained')
axis([-5 5 -5 5])
